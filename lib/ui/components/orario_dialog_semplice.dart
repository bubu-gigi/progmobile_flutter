import 'package:flutter/material.dart';
import 'package:progmobile_flutter/data/collections/template_giornaliero.dart';

class OrariDialogSemplice extends StatefulWidget {
  final ValueChanged<TemplateGiornaliero> onOrarioAdded;

  const OrariDialogSemplice({super.key, required this.onOrarioAdded});

  @override
  State<OrariDialogSemplice> createState() => _OrariDialogSempliceState();
}

class _OrariDialogSempliceState extends State<OrariDialogSemplice> {
  int giornoSettimana = 1;
  TimeOfDay orarioInizio = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay orarioFine = const TimeOfDay(hour: 20, minute: 0);

  final giorni = [
    "Lunedì", "Martedì", "Mercoledì", "Giovedì", "Venerdì", "Sabato", "Domenica"
  ];

  Future<void> _pickTime(bool isInizio) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isInizio ? orarioInizio : orarioFine,
    );
    if (picked != null) {
      setState(() {
        isInizio ? orarioInizio = picked : orarioFine = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Seleziona giorno e orari'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<int>(
            value: giornoSettimana,
            items: List.generate(7, (i) {
              return DropdownMenuItem(
                value: i + 1,
                child: Text(giorni[i]),
              );
            }),
            onChanged: (val) {
              if (val != null) setState(() => giornoSettimana = val);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => _pickTime(true),
                child: Text('Inizio: ${orarioInizio.format(context)}'),
              ),
              TextButton(
                onPressed: () => _pickTime(false),
                child: Text('Fine: ${orarioFine.format(context)}'),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Annulla'),
        ),
        TextButton(
          onPressed: () {
            final template = TemplateGiornaliero(
              giornoSettimana: giornoSettimana,
              orarioApertura: '${orarioInizio.hour.toString().padLeft(2, '0')}:${orarioInizio.minute.toString().padLeft(2, '0')}',
              orarioChiusura: '${orarioFine.hour.toString().padLeft(2, '0')}:${orarioFine.minute.toString().padLeft(2, '0')}',
            );
            widget.onOrarioAdded(template);
            Navigator.pop(context);
          },
          child: const Text('Salva'),
        ),
      ],
    );
  }
}
