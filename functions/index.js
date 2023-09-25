const functions = require("firebase-functions");
const admin = require("firebase-admin");
const pdfjs = require("pdfjs-dist");
const {extractDetails, removeDetailsFromText} = require("./extractProfileDetails");
const {standardizeDates} = require("./standartFormatDates");
const {extractExperienceUsingNPL, removeExperienceFromText} = require("./extractExperienceNPL");

admin.initializeApp();

exports.extractTextFromPDF = functions.storage
    .bucket("ready4job-4f54b.appspot.com")
    .object()
    .onFinalize(async (object) => {
      const filePath = object.name;

      if (!filePath.startsWith("cvs/")) {
        console.log("Le fichier n'est pas dans le répertoire 'cvs'.");
        return null;
      }

      const bucket = admin.storage().bucket("ready4job-4f54b.appspot.com");
      const file = bucket.file(filePath);
      const [fileContent] = await file.download();

      // Convertissez le contenu du fichier en Uint8Array
      const fileBuffer = Buffer.from(fileContent);
      const uint8Array = new Uint8Array(fileBuffer);

      // Utilisez pdf.js pour extraire le texte du PDF
      const pdfData = await pdfjs.getDocument({data: uint8Array}).promise;
      const text = await extractTextFromPDF(pdfData);

      console.log("Texte extrait du PDF : ");
      console.log(text);

      // Extract and remove the details from the text
      const details = extractDetails(text);
      const newText = removeDetailsFromText(text, details);

      console.log("Nouveau texte après suppression des détails:");
      console.log(newText);

      // Standardiser les dates dans le nouveau texte
      const textWithStandardizedDates = standardizeDates(newText);

      console.log("Texte avec dates standardisées :");
      console.log(textWithStandardizedDates);

      // Extract experience from the new text using imported function (Google NLP)
      const experience = extractExperienceUsingNPL(textWithStandardizedDates);

      console.log("Expérience professionnelle extraite (Google NLP) :");
      console.log(experience);

      if (Array.isArray(experience) && experience.length > 0) {
        const textWithoutExperience = removeExperienceFromText(newText, experience);

        console.log("Nouveau texte sans l'expérience :");
        console.log(textWithoutExperience);
      } else {
        console.log("Aucune expérience trouvée.");
      }

      return null;
    });

/**
 * Extrait le texte d'un document PDF sans traitement supplémentaire.
 *
 * @param {Object} pdfData - Les données du PDF.
 * @return {string} - Le texte brut extrait du PDF.
 */
async function extractTextFromPDF(pdfData) {
  const numPages = pdfData.numPages;
  let text = "";

  for (let pageNum = 1; pageNum <= numPages; pageNum++) {
    const page = await pdfData.getPage(pageNum);
    const pageText = await page.getTextContent();
    const pageString = pageText.items.map((item) => item.str).join(" ");
    text += pageString + " "; // Ajoutez un espace après chaque page
  }

  return text.trim(); // Supprimez les espaces inutiles à la fin du texte
}
