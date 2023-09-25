const {LanguageServiceClient} = require("@google-cloud/language");
const dateFns = require("date-fns");
const keyFilename = "C:/Users/thery/ready4jobs/functions/ready4job-4f54b-f1132d1276aa.json";

const client = new LanguageServiceClient({
  keyFilename: keyFilename,
});

/**
 * Extrait l'expérience professionnelle à partir du texte donné en utilisant l'API Google NLP.
 *
 * @param {string} text - Le texte contenant l'expérience professionnelle.
 * @return {Object[]} - Un tableau d'objets représentant l'expérience professionnelle.
 */
async function extractExperienceUsingNPL(text) {
  // Recherchez les dates potentielles dans le texte
  const dateRegex = /(\d{1,2}\/\d{1,2}\/\d{4})/g; // Exemple de regex pour les dates au format JJ/MM/AAAA
  const potentialDates = text.match(dateRegex);

  // Normalisez les dates détectées dans un format standard (par exemple, ISO 8601)
  const normalizedDates = potentialDates.map((dateStr) => {
    const parsedDate = dateFns.parse(dateStr, "dd/MM/yyyy", new Date());
    return dateFns.format(parsedDate, "yyyy-MM-dd");
  });

  // Utilisation de l'API Google NLP pour analyser le texte avec les dates normalisées
  const document = {
    content: text,
    type: "PLAIN_TEXT",
  };

  const [result] = await client.analyzeEntities({document});
  const entities = result.entities;

  // Filtrer les entités pertinentes (les dates normalisées)
  const dateEntities = entities.filter((entity) => {
    return entity.type === "DATE" && normalizedDates.includes(entity.name);
  });

  const dates = dateEntities.map((dateEntity) => {
    return dateEntity.name;
  });

  return dates;
}

/**
 * Supprime l'expérience professionnelle du texte donné.
 *
 * @param {string} text - Le texte d'origine contenant l'expérience professionnelle.
 * @param {Object[]} dates - Un tableau d'objets représentant l'expérience professionnelle à supprimer.
 * @return {string} - Le texte avec l'expérience supprimée.
 */
function removeExperienceFromText(text, dates) {
  let modifiedText = text;

  // Parcourez chaque date et supprimez-la du texte
  dates.forEach((date) => {
    modifiedText = modifiedText.replace(date, "");
  });

  return modifiedText;
}

module.exports = {
  extractExperienceUsingNPL,
  removeExperienceFromText,
};
