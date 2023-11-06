import 'dart:convert';

import 'package:christmas/features/present_selector/presentation/widgets/build_gift_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class PresentSelectorPage extends StatefulWidget {
  const PresentSelectorPage({super.key});

  @override
  PresentSelectorPageState createState() => PresentSelectorPageState();
}

class PresentSelectorPageState extends State<PresentSelectorPage> {
  int _currentStep = 0;
  final TextEditingController _hobby1Controller = TextEditingController();
  final TextEditingController _hobby2Controller = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _pastPresent1 = TextEditingController();
  final TextEditingController _pastPresent2 = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _gender = TextEditingController();

  // Weitere Controller für andere Eingaben...

  final Map<String, bool> _selections = {
    'Neugierig': false,
    'Zuverlässig': false,
    'Gesellig': false,
    'Hilfsbereit': false,
    'Ruhig': false,
    'Organisiert': false,
    'Kreativ': false,
    'Mutig': false,
    'Mitfühlend': false,
  };

  bool isLoading = false;

  String answer = '';
  // "1. Gutschein 2. Persönliche Fotoalben 3. Kinderspielzeug – zum Beispiel ein Rollenspiel-Set 4. Stoffpuppe mit verschiedenen Outfits 5. Kinderschürze oder Küchensets 6. Ein Zubehörset für die Puppe 7. Etwas zum Basteln oder Nähen 8. Ein Ausflug ins Kino oder zu einer Show 9. Ein neues Spiel oder ein neues Spielzeug 10. Eine Geschenkkarte für eine Aktivität (z.B. Eislaufen, Klettern, etc.)";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(40, 135, 139, 96),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(40, 135, 139, 96),
        title: const Text(
          'Geschenkefinder',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: getCurrentStateWidget(),
      ),
    );
  }

  Widget getCurrentStateWidget() {
    if (isLoading) {
      return LottieBuilder.asset('./assets/lottie/present.json');
    } else if (answer != '') {
      return buildGiftList(answer);
    } else {
      return Stepper(
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (_currentStep != 0)
                TextButton(
                  onPressed: details.onStepCancel,
                  child: const Text('Zurück'),
                ),
              if (_currentStep < _buildSteps().length - 1)
                ElevatedButton(
                  onPressed: details.onStepContinue,
                  child: const Text('Nächster Schritt'),
                ),
              if (_currentStep == _buildSteps().length - 1)
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    final prompt = createGptPrompt(
                        gender: _gender.text.trim(),
                        age: _age.text.trim(),
                        hobby1: _hobby1Controller.text.trim(),
                        hobby2: _hobby2Controller.text.trim(),
                        job: _jobController.text.trim(),
                        pastPresent1: _pastPresent1.text.trim(),
                        pastPresent2: _pastPresent2.text.trim(),
                        selections: _selections);

                    const String apiKey =
                        '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';

                    await fetchGptResponse(prompt, apiKey).then((responseText) {
                      setState(() {
                        answer = responseText;
                        isLoading = false;
                      });

                      print(responseText);
                    }).catchError((error) {
                      // Fehlerbehandlung
                      print(error);
                    });
                    print(prompt);
                  },
                  child: const Text('Fertig'),
                ),
            ],
          );
        },
        currentStep: _currentStep,
        onStepContinue: _onStepContinue,
        onStepCancel: _onStepCancel,
        steps: _buildSteps(),
      );
    }
  }

  List<Step> _buildSteps() {
    return [
      Step(
        title: const Text('Alter & Geschlecht'),
        content: Column(
          children: [
            const Text(
                'Bitte gebe das Alter und Geschlecht der Person an. Wenn du es nicht genau weißt reicht eine Schätzung.'),
            _buildTextInput(_age, 'Alter'),
            _buildTextInput(_gender, 'Geschlecht'),
            const SizedBox(
              height: 16,
            )
          ],
        ),
        isActive: _currentStep >= 0,
        state: _currentStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text('Hobbys'),
        content: Column(
          children: [
            const Text(
                'Bitte gib zwei Hobbys oder Interessen der zu beschenkenden Person ein.'),
            _buildTextInput(_hobby1Controller, 'Hobby oder Interesse 1'),
            _buildTextInput(_hobby2Controller, 'Hobby oder Interesse 2'),
            const SizedBox(
              height: 16,
            )
          ],
        ),
        isActive: _currentStep >= 1,
        state: _currentStep > 1 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text('Persönlichkeit'),
        content: Column(
          children: [
            const Text(
              'Wähle die Persönlichkeitsmerkmale, die am besten auf die zu beschenkende Person zutreffen.',
            ),
            const SizedBox(height: 16),
            _customToggleButtons(
              labels: ['Neugierig', 'Zuverlässig', 'Gesellig'],
              selections: _selections,
              onPressed: (String label) {
                setState(() {
                  _selections[label] = !_selections[label]!;
                });
              },
            ),
            const SizedBox(height: 8),
            _customToggleButtons(
              labels: ['Hilfsbereit', 'Ruhig', 'Organisiert'],
              selections: _selections,
              onPressed: (String label) {
                setState(() {
                  _selections[label] = !_selections[label]!;
                });
              },
            ),
            const SizedBox(height: 8),
            _customToggleButtons(
              labels: ['Kreativ', 'Mutig', 'Mitfühlend'],
              selections: _selections,
              onPressed: (String label) {
                setState(() {
                  _selections[label] = !_selections[label]!;
                });
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
        isActive: _currentStep >= 2,
        state: _currentStep > 2 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text('Beruf'),
        content: Column(
          children: [
            const Text(
                'Bitte nenne den Beruf der zu beschenkenden Person, falls sie mit dieser Wahl bereits glücklich ist. Alternativ gib den Traumberuf an den diese Person gerne hätte.'),
            _buildTextInput(_jobController, 'Beruf'),
            const SizedBox(
              height: 16,
            )
          ],
        ),
        isActive: _currentStep >= 3,
        state: _currentStep > 3 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text('Vergangene Geschenke'),
        content: Column(
          children: [
            const Text(
                'Bitte benenne zwei Geschenke über die sich die zu beschenkende Person in der Vergangenheit gefreut hat. Alternativ kannst du angeben was du vermutest worüber sie sich freuen würde.'),
            _buildTextInput(_pastPresent1, 'Geschenk 1'),
            _buildTextInput(_pastPresent2, 'Geschenk 2'),
            const SizedBox(
              height: 16,
            )
          ],
        ),
        isActive: _currentStep >= 4,
        state: _currentStep > 4 ? StepState.complete : StepState.indexed,
      ),
    ];
  }

  Widget _buildTextInput(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Bitte fülle dieses Feld aus oder überspringe es.';
        }
        return null;
      },
    );
  }

  void _onStepContinue() {
    if (_currentStep < _buildSteps().length - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      // Fertig mit allen Schritten, führe die Suche aus
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  String createGptPrompt(
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

  Widget _customToggleButtons({
    required List<String> labels,
    required Map<String, bool> selections,
    required void Function(String label) onPressed,
  }) {
    // Find the widest label after measuring them
    final List<Widget> buttonChildren = labels.map((label) {
      return IntrinsicWidth(
        child: toggleButton(
          label: label,
          isSelected: selections[label] ?? false,
          onPressed: () => onPressed(label),
        ),
      );
    }).toList();

    return ToggleButtons(
      onPressed: (int index) {
        String label = labels[index];
        onPressed(label);
      },
      isSelected: labels.map((label) => selections[label] ?? false).toList(),
      borderColor: Colors.green[800],
      fillColor: Colors.red[200],
      selectedBorderColor: Colors.green[900],
      selectedColor: Colors.white,
      borderRadius: BorderRadius.circular(10),
      borderWidth: 2,
      children: buttonChildren,
    );
  }

  Widget toggleButton({
    required String label,
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return Container(
      constraints: const BoxConstraints(
          minWidth: 100, minHeight: 40), // Set a minimum width and height
      alignment: Alignment.center,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: isSelected ? Colors.white : Colors.black,
          backgroundColor: isSelected ? Colors.red[200] : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
        child: Text(label),
      ),
    );
  }
}

Future<String> fetchGptResponse(String prompt, String apiKey) async {
  final url = Uri.parse('https://api.openai.com/v1/completions');
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    },
    body: jsonEncode({
      'model': 'text-davinci-003', // Hier geben Sie das Modell an
      'prompt': prompt,
      'max_tokens': 500, // Sie können diese Zahl anpassen
      'temperature': 0.7, // Optional: Anpassen für Kreativität der Antwort
      // 'top_p': 1, // Optional: Anpassen für Diversität der Antwort
      // 'frequency_penalty': 0, // Optional: Bestraft wiederholte Informationen
      // 'presence_penalty': 0, // Optional: Bestraft fehlende Informationen
    }),
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    return jsonResponse['choices'][0]['text'];
  } else {
    throw Exception('Failed to load data from GPT-3.5-turbo API');
  }
}
