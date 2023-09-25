// pdf-utils.js

/**
 * Extrait les détails tels que l'e-mail, le numéro de téléphone, le nom et le numéro de permis de conduire du texte donné.
 *
 * @param {string} text - Le texte à partir duquel extraire les détails.
 * @return {Object} - Un objet contenant les détails extraits.
 */
function extractDetails(text) {
  const details = {};

  // Extract Email
  const emailRegex = /[\w.-]+@[\w.-]+\.[a-zA-Z]{2,4}/;
  const emailMatch = text.match(emailRegex);
  details.email = emailMatch ? emailMatch[0] : null;

  // Extract Phone Number
  const phoneRegex = /0[1-9](?:[.\s]*\d{2}){4}/;
  const phoneMatch = text.match(phoneRegex);
  details.phone = phoneMatch ? phoneMatch[0] : null;

  // Extract Name
  const nameRegex = /([A-Z][a-z]+)\s?([A-Z][a-z]+)/;
  const nameMatch = text.match(nameRegex);
  details.name = nameMatch ? nameMatch[0] : null;

  // Extract Driving License
  const drivingLicenseRegex = /Permis\s+[A-Z]+\s+[A-Z]+/; // Format "Permis B" ou similaire
  const drivingLicenseMatch = text.match(drivingLicenseRegex);
  details.drivingLicense = drivingLicenseMatch ? drivingLicenseMatch[0] : null;

  return details;
}


/**
 * Supprime les détails (e-mail, téléphone, nom, numéro de permis de conduire) du texte donné.
 *
 * @param {string} text - Le texte d'origine contenant les détails.
 * @param {Object} details - Un objet contenant les détails à supprimer du texte.
 * @return {string} - Le texte avec les détails supprimés.
 */
function removeDetailsFromText(text, details) {
  return text.replace(details.email, "")
      .replace(details.phone, "")
      .replace(details.name, "")
      .replace(details.drivingLicense, "");
}

module.exports = {
  extractDetails,
  removeDetailsFromText,
};
