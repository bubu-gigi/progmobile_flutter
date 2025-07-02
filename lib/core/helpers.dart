import 'package:intl/intl.dart';

import '../data/collections/template_giornaliero.dart';

List<String> generaSlotOrari(TemplateGiornaliero template) {
  final inizio = _parseOrario(template.orarioApertura);
  final fine = _parseOrario(template.orarioChiusura);
  final slots = <String>[];

  var current = inizio;
  while (current.isBefore(fine)) {
    final next = current.add(const Duration(hours: 1));
    if (next.isAfter(fine)) break;
    slots.add("${_formatOrario(current)} - ${_formatOrario(next)}");
    current = next;
  }

  return slots;
}

DateTime _parseOrario(String orario) {
  final parts = orario.split(':');
  return DateTime(0, 1, 1, int.parse(parts[0]), int.parse(parts[1]));
}

String _formatOrario(DateTime time) {
  final formatter = DateFormat.Hm();
  return formatter.format(time);
}