import 'package:intl/intl.dart';

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

List<List<String>> raggruppaSlotConsecutivi(List<List<String>> slots) {
  final formatter = DateFormat.Hm();

  final parsedSlots = slots
      .map((s) => [formatter.parse(s[0]), formatter.parse(s[1])])
      .toList()
    ..sort((a, b) => a[0].compareTo(b[0]));

  if (parsedSlots.isEmpty) return [];

  final gruppi = <List<List<DateTime>>>[];
  var gruppoCorrente = <List<DateTime>>[parsedSlots.first];

  for (var i = 1; i < parsedSlots.length; i++) {
    final precedente = gruppoCorrente.last;
    final corrente = parsedSlots[i];

    if (precedente[1] == corrente[0]) {
      gruppoCorrente.add(corrente);
    } else {
      gruppi.add(gruppoCorrente);
      gruppoCorrente = [corrente];
    }
  }
  gruppi.add(gruppoCorrente);

  return gruppi.map((gruppo) {
    final inizio = formatter.format(gruppo.first[0]);
    final fine = formatter.format(gruppo.last[1]);
    return [inizio, fine];
  }).toList();
}

List<List<String>> generaSlotOrari(String inizio, String fine) {
  final formatter = DateFormat.Hm(); // formato "HH:mm"
  final startTime = formatter.parse(inizio);
  final endTime = formatter.parse(fine);

  final slots = <List<String>>[];

  var current = startTime;
  while (current.isBefore(endTime)) {
    final next = DateTime(
      current.year,
      current.month,
      current.day,
      current.hour + 1,
      current.minute,
    );

    if (next.isAfter(endTime)) break;

    slots.add([formatter.format(current), formatter.format(next)]);
    current = next;
  }

  return slots;
}

