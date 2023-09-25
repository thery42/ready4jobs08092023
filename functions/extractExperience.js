/**
 * Extrait l'expérience professionnelle à partir du texte donné.
 *
 * @param {string} text - Le texte contenant l'expérience professionnelle.
 * @return {Object[]} - Un tableau d'objets représentant l'expérience professionnelle.
 */
function extractExperience(text) {
  const experienceRegex = /((\d{1,2}(\/|-| )?\d{2,4}|Aujourd’hui)?\s*(–|-|à|→)\s*(\d{1,2}(\/|-| )?)?\d{2,4}|(\d{2,4}))\s*:\s*([^:]+)/g;

  const experienceMatches = [];
  let match;

  while ((match = experienceRegex.exec(text)) !== null) {
    experienceMatches.push({
      period: match[1].trim(),
      details: match[5].trim(),
    });
  }

  if (experienceMatches.length === 0) {
    return []; // Aucune expérience trouvée
  }

  return experienceMatches;
}

/**
 * Supprime l'expérience professionnelle du texte donné.
 *
 * @param {string} text - Le texte d'origine contenant l'expérience professionnelle.
 * @param {Object[]} experience - Un tableau d'objets représentant l'expérience professionnelle à supprimer.
 * @return {string} - Le texte avec l'expérience supprimée.
 */
function removeExperienceFromText(text, experience) {
  let modifiedText = text;

  // Parcourez chaque élément d'expérience
  experience.forEach((exp) => {
    const experienceString = `${exp.period} : ${exp.details}`;
    modifiedText = modifiedText.replace(experienceString, "");
  });

  return modifiedText;
}

module.exports = {extractExperience, removeExperienceFromText};
