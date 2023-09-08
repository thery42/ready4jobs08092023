const functions = require("firebase-functions");
const admin = require("firebase-admin");
const pdf = require("pdf-parse");


admin.initializeApp();

// Récupérer le chemin du fichier PDF téléchargé
exports.extractTextFromPDF =
functions.storage.bucket("ready4job-4f54b.appspot.com")
    .object()
    .onFinalize(async (object) => {
      const filePath = object.name;

      // Vérifier si le fichier est dans le répertoire "cvs"
      if (!filePath.startsWith("cvs/")) {
        console.log("Le fichier n'est pas dans le répertoire 'cvs'.");
        return null;
      }

      // Extraire l'ID de l'utilisateur à partir du chemin
      const userId = filePath.split("/")[1];
      // Supposant que l'ID de l'utilisateur est le premier élément après "cvs/"

      // Télécharger le PDF depuis le bucket
      const bucket = admin.storage().bucket("ready4job-4f54b.appspot.com");
      const file = bucket.file(filePath);
      const [fileContent] = await file.download();

      // Extraire le texte du PDF avec pdf-parse
      const pdfData = await pdf(fileContent);
      const extractedText = pdfData.text;

      // Stocker le texte extrait dans Firestore,
      const db = admin.firestore();

      // Assurez-vous d'adapter le chemin à votre structure de données
      const userDocRef = db.collection("users").doc(userId);
      await userDocRef.collection("extractedTexts").add({
        content: extractedText,
      });

      // Assurez-vous de retourner quelque
      // chose pour éviter les erreurs de timeout
      return null;
    });
