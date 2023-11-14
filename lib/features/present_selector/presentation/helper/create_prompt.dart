class CreatePrompt {
  String build(
      {required String gender,
      required String age,
      required String hobby1,
      required String hobby2,
      required String job,
      required String pastPresent1,
      required String pastPresent2,
      required Map<String, bool> selections}) {
    String prompt =
        "Bitte sei mein Experte für das perfekte Geschenk. Ich suche ein Geschenk für eine Person, die ";

    if (age.isNotEmpty) {
      prompt += "$age Jahre alt ist,";
    }

    if (gender.isNotEmpty) {
      prompt += "ihr Geschlecht ist $gender";
    }

    // Hobbies hinzufügen, wenn vorhanden
    if (hobby1.isNotEmpty || hobby2.isNotEmpty) {
      prompt += "sich für ";
      if (hobby1.isNotEmpty) {
        prompt += hobby1;
        if (hobby2.isNotEmpty) prompt += " und $hobby2";
      } else if (hobby2.isNotEmpty) {
        prompt += hobby2;
      }
      prompt += " interessiert. ";
    }

    // Persönlichkeitsmerkmale hinzufügen, wenn vorhanden
    var selectedTraits = selections.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    if (selectedTraits.isNotEmpty) {
      prompt += "Die Person weist die folgenden Persönlichkeitsmerkmale auf: ";
      prompt += "${selectedTraits.join(", ")}. ";
    }

    // Beruf hinzufügen, wenn vorhanden
    if (job.isNotEmpty) {
      prompt +=
          "Derzeit arbeitet sie als $job und ist mit dieser Wahl sehr zufrieden bzw. ist es sogar Ihre Traumbeschäftigung. ";
    }

    // Vergangene Geschenke hinzufügen, wenn vorhanden
    if (pastPresent1.isNotEmpty || pastPresent2.isNotEmpty) {
      prompt += "In der Vergangenheit hat sie sich über Geschenke wie ";
      if (pastPresent1.isNotEmpty) {
        prompt += pastPresent1;
        if (pastPresent2.isNotEmpty) prompt += " und $pastPresent2";
      } else if (pastPresent2.isNotEmpty) {
        prompt += pastPresent2;
      }
      prompt += " gefreut. ";
    }

    // Abschluss des Prompts
    prompt += "Was wäre das perfekte Weihnachts-Geschenk für diese Person?";
    prompt +=
        "Basierend auf diesen Informationen, Bitte berücksichtige bei der Auswahl der Geschenke das Alter, sowie das Geschlecht und die Lebensphase der beschenkten Person. Für Kinder, die die Welt durch Spiel und Kreativität entdecken, sollten Geschenke gewählt werden, die ihre Neugier wecken und ihre Entwicklung fördern. Teenager, die ihre Identität ausbilden und neue Interessen entwickeln, würden sich über Geschenke freuen, die ihre aktuellen Leidenschaften unterstützen und ihnen helfen, Verbindungen mit Gleichaltrigen zu knüpfen. Erwachsene, die vielleicht mitten im Berufsleben stehen oder eigene Familien haben, würden Geschenke schätzen, die Entspannung und eine Auszeit vom Alltag bieten oder die es ihnen ermöglichen, wertvolle Zeit mit ihren Liebsten zu verbringen. Eltern könnten sich über Geschenke freuen, die das Familienleben bereichern oder ihnen persönliche Erholung ermöglichen. Und schließlich würden Großeltern Geschenke zu schätzen wissen, die Erinnerungen wachrufen, die Familie zusammenbringen oder ihnen neue Erfahrungen ermöglichen, die sie mit ihren Enkelkindern teilen können. Bitte erstelle eine Liste mit Geschenkideen, die diese Aspekte für jede Altersgruppe berücksichtigen und dabei die individuellen Vorlieben und Interessen einbeziehen. ";
    prompt +=
        "erstelle mir bitte eine Liste von 10 Geschenkideen, die von einfachen Aufmerksamkeiten bis hin zu ausgefallenen Überraschungen reichen. ";
    prompt +=
        "Die Geschenke sollten eine Mischung aus physischen Gegenständen, Erlebnissen und persönlichen Gesten sein, die die festliche Stimmung und die Freude am Teilen und Erleben hervorheben, es sollten aber schon konkrete Geschenke sein und ruhig auch etwas ausgefallenes.";
    prompt +=
        "Bitte begründe keine Geschenkidee, liste einfach nur die Geschenke auf.";

    return prompt;
  }
}
