import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

// Diese Funktion nimmt den String mit den Geschenkideen und gibt ein Widget zurück
Widget buildGiftList(String giftResponse) {
  // Verwende Regex, um die Aufzählungen zu identifizieren und zu trennen
  RegExp exp = RegExp(r'\d+\.\s(.+?)(?=\d+\.|$)', dotAll: true);
  Iterable<RegExpMatch> matches = exp.allMatches(giftResponse);

  // Erstelle eine Liste von Widgets für jede Geschenkidee
  List<Widget> giftWidgets = matches.map((match) {
    String gift = match.group(1)!; // Extrahiere die Geschenkidee
    IconData iconData = Iconsax.gift; // Standard-Icon Standard-Icon
    // Überprüfe, ob das Geschenk bestimmte Schlüsselwörter enthält und weise ein Icon zu
    if (gift.contains('Malbuch')) {
      iconData = Iconsax.brush;
    } else if (gift.contains('Fotoalben')) {
      iconData = Iconsax.image;
    } else if (gift.contains('Spielzeug') || gift.contains('Spiel')) {
      iconData = Iconsax.game;
    } else if (gift.contains('Geschenkkarte')) {
      iconData = Iconsax.gift;
    } else if (gift.contains('Buch') || gift.contains('Lesen')) {
      iconData = Iconsax.book;
    } else if (gift.contains('Musik') || gift.contains('Instrument')) {
      iconData = Iconsax.music;
    } else if (gift.contains('Sport') || gift.contains('Fitness')) {
      iconData = Iconsax.people;
    } else if (gift.contains('Reise') || gift.contains('Urlaub')) {
      iconData = Iconsax.airplane;
    } else if (gift.contains('Schmuck')) {
      iconData = Iconsax.watch;
    } else if (gift.contains('Kunst') || gift.contains('Malen')) {
      iconData = Iconsax.image4;
    } else if (gift.contains('Technologie') || gift.contains('Gadget')) {
      iconData = Iconsax.smart_home;
    } else if (gift.contains('Haustier')) {
      iconData = Iconsax.pet4;
    } else if (gift.contains('Süßigkeiten') || gift.contains('Schokolade')) {
      iconData = Iconsax.cake;
    } else if (gift.contains('Spiel') || gift.contains('Brettspiel')) {
      iconData = Iconsax.game3;
    } else if (gift.contains('Mode') || gift.contains('Kleidung')) {
      iconData = Iconsax.woman2;
    } else if (gift.contains('Auto') || gift.contains('Fahrzeug')) {
      iconData = Iconsax.car4;
    } else if (gift.contains('Kamera')) {
      iconData = Iconsax.camera3;
    } else if (gift.contains('Malerei') || gift.contains('Zeichnen')) {
      iconData = Iconsax.brush;
    } else if (gift.contains('Dekoration')) {
      iconData = Iconsax.paintbucket;
    } else if (gift.contains('Uhren')) {
      iconData = Iconsax.watch;
    } else if (gift.contains('Reisen')) {
      iconData = Iconsax.airplane;
    } else if (gift.contains('Sprachen lernen')) {
      iconData = Iconsax.language_circle;
    } else if (gift.contains('Fotografie')) {
      iconData = Iconsax.camera;
    } else if (gift.contains('Filmen')) {
      iconData = Iconsax.camera;
    } else if (gift.contains('Podcasting')) {
      iconData = Iconsax.microphone;
    } else if (gift.contains('Zeichnen')) {
      iconData = Iconsax.activity;
    } else {
      iconData = Iconsax.gift4; // Standard-Icon für nicht erkannte Geschenke
    }

    // Erstelle das Listenelement mit Icon und Text
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Abgerundete Ecken
        border: Border.all(
          color: const Color.fromARGB(165, 175, 145, 76), // Rahmenfarbe
          width: 3, // Rahmenbreite
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Schattenfarbe
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // Position des Schattens
          ),
        ],
        image: const DecorationImage(
          opacity: .45,
          image: AssetImage("assets/images/christmas_red_background.jpg"),
          fit: BoxFit.cover, // Füllt den Container mit dem Bild
        ),
      ),
      child: ListTile(
        leading: Icon(
          iconData,
          color: Colors.white,
          size: 35,
        ), // Icon in Weihnachtsfarbe
        title: Text(gift.trim(),
            style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );
  }).toList();

  // Erstelle das Gesamt-Widget mit CustomScrollView
  return CustomScrollView(
    slivers: <Widget>[
      const SliverPadding(
        padding: EdgeInsets.all(16.0),
        sliver: SliverToBoxAdapter(
          child: Text(
            'Weihnachtsgeschenkideen:',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 104, 67, 67),
            ),
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return giftWidgets[index];
          },
          childCount: giftWidgets.length, // Anzahl der Elemente in der Liste
        ),
      ),
    ],
  );
}
