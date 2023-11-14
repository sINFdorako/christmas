# Geschenkefinder

Eine kleine Spaßapp um die richtigen Geschenke für Weihnachten zu finden :)

## Funktionsweise

So einfach geht's:
* Formular ausfüllen: Ein paar schnelle Klicks und du bist startklar
* Personalisierte Vorschläge: Die App sucht Geschenke basierend auf den von dir eingegebenen Merkmalen der Person, die du beschenken möchtest. Je mehr Infos du gibst, desto genauer werden die Vorschläge.
* Freie Wahl bei jedem Schritt: Du kannst jeden Schritt überspringen, wenn du willst – flexibel und unkompliziert.
* Überraschen lassen: Bis zu 10 persönliche Geschenkideen warten auf dich.
* Ganz locker: Keine Anmeldung, keine Daten, kein Stress.

### Clean Architecture

Für dieses kleine Projekt wurde eine light Clean Architecture bentutzt

```
/feature
      /data
          /repositories
      /domain
        /respositories
        /usecases
      /presentation
        /helper
        /pages
        /widgets
        /providers
```


## Externe Packete

- Dio für Api Requests
- Dartz für Functional Programming
- Flutter Riverpod für Riverpod
- Lottie für Animation

## Installation und Nutzung

bis auf Flutter, keine zusätzliche Installationen nötig.

1. Repository Klonen oder Forken
2. `flutter pub get & flutter run` (für bevorzugtes Device)

## Open Source

MIT License
