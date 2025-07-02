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

String? validateNome(String? value) {
  if (value == null || value.trim().isEmpty) return 'Il nome è obbligatorio';
  if (value.trim().length < 2) return 'Minimo 2 caratteri';
  return null;
}

String? validateCognome(String? value) {
  if (value == null || value.trim().isEmpty) return 'Il cognome è obbligatorio';
  if (value.trim().length < 2) return 'Minimo 2 caratteri';
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) return 'Email obbligatoria';
  final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!regex.hasMatch(value.trim())) return 'Formato non valido';
  return null;
}

String? validateCodiceFiscale(String? value) {
  if (value == null || value.trim().isEmpty) return 'Codice fiscale obbligatorio';
  final regex = RegExp(r'^[A-Z]{6}[0-9]{2}[A-Z][0-9]{2}[A-Z][0-9]{3}[A-Z]$');
  if (!regex.hasMatch(value.toUpperCase())) return 'Codice fiscale non valido';
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) return 'La password è obbligatoria';
  if (value.length < 6) return 'Minimo 6 caratteri';
  if (!value.contains(RegExp(r'[A-Za-z]'))) return 'Deve contenere almeno una lettera';
  if (!value.contains(RegExp(r'\d'))) return 'Deve contenere almeno un numero';
  return null;
}
