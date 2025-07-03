import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progmobile_flutter/data/collections/template_giornaliero.dart';

class CampoDatePicker extends StatefulWidget {
  final List<TemplateGiornaliero> disponibilita;
  final void Function(DateTime) onDateSelected;
  final String label;

  const CampoDatePicker({
    super.key,
    required this.disponibilita,
    required this.onDateSelected,
    this.label = "Seleziona una data",
  });

  @override
  State<CampoDatePicker> createState() => _CampoDatePickerState();
}

class _CampoDatePickerState extends State<CampoDatePicker> {
  DateTime? _selectedDate;

  DateTime _primaDataDisponibile(DateTime from, Set<int> giorniDisponibili) {
    for (int i = 0; i <= 30; i++) {
      final candidate = from.add(Duration(days: i));
      if (giorniDisponibili.contains(candidate.weekday)) return candidate;
    }
    return from;
  }


  @override
  Widget build(BuildContext context) {
    final giorniDisponibili = widget.disponibilita
        .map((e) => (e.giornoSettimana) % 7 == 0 ? 7 : (e.giornoSettimana) % 7)
        .toSet();
    print("Giorni disponibili: $giorniDisponibili");
    return TextFormField(
      readOnly: true,
      onTap: () async {
        final now = DateTime.now();
        final picked = await showDatePicker(
          context: context,
          initialDate: _selectedDate ?? _primaDataDisponibile(now, giorniDisponibili),
          firstDate: now,
          lastDate: now.add(const Duration(days: 30)),
          selectableDayPredicate: (day) {
            return giorniDisponibili.contains(day.weekday);
          },
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: Color(0xFF6136FF),
                  onPrimary: Colors.white,
                  surface: Color(0xFF232323),
                  onSurface: Colors.white,
                ),
              ),
              child: child!,
            );
          },
        );

        if (picked != null) {
          setState(() => _selectedDate = picked);
          widget.onDateSelected(picked);
        }
      },
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(color: Colors.white70),
        hintText: "gg/mm/aaaa",
        hintStyle: const TextStyle(color: Colors.white38),
        suffixIcon: const Icon(Icons.calendar_today, color: Colors.white70),
        filled: true,
        fillColor: const Color(0xFF2E2E2E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      controller: TextEditingController(
        text: _selectedDate != null
            ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
            : '',
      ),
    );
  }
}
