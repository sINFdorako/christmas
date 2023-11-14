import 'package:flutter/material.dart';

Widget buildGiftList(
  BuildContext context,
  String giftResponse,
) {
  final RegExp exp = RegExp(r'\d+\.\s(.+?)(?=\d+\.|$)', dotAll: true);
  final Iterable<RegExpMatch> matches = exp.allMatches(giftResponse);

  List<Widget> giftWidgets = matches.map((match) {
    final String gift = match.group(1)!.trim();
    return _buildGiftWidget(
      context,
      gift,
    );
  }).toList();

  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) => giftWidgets[index],
      childCount: giftWidgets.length,
    ),
  );
}

Widget _buildGiftWidget(
  BuildContext context,
  String gift,
) {
  return Container(
    height: 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Theme.of(context).colorScheme.primary,
        width: 3,
      ),
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).colorScheme.secondary,
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: ListTile(
      leading: const Icon(
        Icons.card_giftcard_sharp,
        color: Colors.white,
        size: 35,
      ),
      title: Text(
        gift,
        style: const TextStyle(
            fontSize: 16.5, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
