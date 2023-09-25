const dateFns = require("date-fns");

/**
 * Standardise les dates dans le texte au format YYYY-MM-DD.
 *
 * @param {string} text - Le texte contenant des dates à standardiser.
 * @return {string} - Le texte avec les dates standardisées.
 */
function standardizeDates(text) {
  // Expression régulière pour rechercher des dates au format JJ/MM/AAAA, DD MMMM YYYY, YYYY-MM-DD ou YYYY-MM-DD à YYYY-MM-DD
  const dateRegex = /(\d{2}\/\d{4}(\s*[-–]\s*(\d{2}\/)?\d{4}| - Aujourd’hui)?|\d{4}( :| saison)?|\b(?:Janvier|Février|Mars|Avril|Mai|Juin|Juillet|Août|Septembre|Octobre|Novembre|Décembre)\s\d{4}|\d{4} [àa] \d{4})/;

  // Recherche toutes les occurrences de dates dans le texte
  const dates = text.match(dateRegex);

  if (dates && dates.length) {
    // Parcours toutes les dates trouvées et les standardise
    for (const date of dates) {
      if (date.includes("/")) {
        // Format JJ/MM/AAAA
        const [day, month, year] = date.split("/");
        const parsedDate = dateFns.parse(`${year}-${month.padStart(2, "0")}-${day.padStart(2, "0")}`, "yyyy-MM-dd", new Date());
        const standardizedDate = dateFns.format(parsedDate, "yyyy-MM-dd");
        // Remplace la date non standardisée par la date standardisée dans le texte
        text = text.replace(date, standardizedDate);
      }
    }
  }


  return text;
}

module.exports = {
  standardizeDates,
};
