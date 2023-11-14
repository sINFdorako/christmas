import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectionsProvider = StateProvider<Map<String, bool>>((ref) => {
      'Neugierig': false,
      'Zuverlässig': false,
      'Gesellig': false,
      'Hilfsbereit': false,
      'Ruhig': false,
      'Organisiert': false,
      'Kreativ': false,
      'Mutig': false,
      'Mitfühlend': false,
    });
