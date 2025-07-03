import 'package:flutter/material.dart';
import 'package:progmobile_flutter/data/collections/campo.dart';
import 'package:progmobile_flutter/data/collections/prenotazione.dart';
import 'package:progmobile_flutter/core/helpers.dart';

import '../../data/collections/template_giornaliero.dart';

class OrariDialog extends StatefulWidget {
  final Campo campo;
  final DateTime data;
  final List<Prenotazione> prenotazioniOccupate;
  final void Function(List<List<String>>) onOrariConfermati;
  final VoidCallback onDismiss;

  const OrariDialog({
    super.key,
    required this.campo,
    required this.data,
    required this.prenotazioniOccupate,
    required this.onOrariConfermati,
    required this.onDismiss,
  });

  @override
  State<OrariDialog> createState() => _OrariDialogState();
}

class _OrariDialogState extends State<OrariDialog> {
  final Set<List<String>> slotSelezionati = {};

  @override
  Widget build(BuildContext context) {
    final giornoSettimanaConvertito = widget.data.weekday;
    print("Data selezionata: ${widget.data}");
    print("weekday: ${widget.data.weekday}");
    print("giornoSettimanaConvertito: $giornoSettimanaConvertito");

    for (var g in widget.campo.disponibilitaSettimanale) {
      print("🗓️ Giorno disponibile: ${g.giornoSettimana} dalle ${g.orarioApertura} alle ${g.orarioChiusura}");
    }
    late final TemplateGiornaliero agenda;
    try {
      agenda = widget.campo.disponibilitaSettimanale.firstWhere(
            (g) => g.giornoSettimana == giornoSettimanaConvertito,
      );
    } catch (_) {
      WidgetsBinding.instance.addPostFrameCallback((_) => widget.onDismiss());
      return const SizedBox.shrink();
    }

    print(agenda);
    if (agenda == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => widget.onDismiss());
      return const SizedBox.shrink();
    }

    final slots = generaSlotOrari(agenda.orarioApertura, agenda.orarioChiusura);

    DateTime _parseOrarioConData(DateTime data, String orario) {
      final parts = orario.split(":");
      return DateTime(
        data.year,
        data.month,
        data.day,
        int.parse(parts[0]),
        int.parse(parts[1]),
      );
    }

    bool isOccupied(List<String> slot) {
      final slotInizio = _parseOrarioConData(widget.data, slot[0]);
      final slotFine = _parseOrarioConData(widget.data, slot[1]);

      return widget.prenotazioniOccupate.any((pren) {
        final prenDataParts = pren.data.split('/');
        if (prenDataParts.length != 3) return false;

        final prenData = DateTime(
          int.parse(prenDataParts[2]),
          int.parse(prenDataParts[1]),
          int.parse(prenDataParts[0]),
        );

        if (prenData.year != widget.data.year ||
            prenData.month != widget.data.month ||
            prenData.day != widget.data.day) {
          return false;
        }

        final prenInizio = _parseOrarioConData(prenData, pren.orarioInizio);
        final prenFine = _parseOrarioConData(prenData, pren.orarioFine);

        return prenInizio.isBefore(slotFine) && prenFine.isAfter(slotInizio);
      });
    }

    return Dialog(
      backgroundColor: const Color(0xFF2B2B2B),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Seleziona orari disponibili:",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'LemonMilk', // Usa lo stesso font se disponibile
              ),
            ),
            const SizedBox(height: 12),

            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: slots.length,
                itemBuilder: (_, index) {
                  final slot = slots[index];
                  final selected = slotSelezionati.any((s) => s[0] == slot[0] && s[1] == slot[1]);
                  final occupied = isOccupied(slot);

                  Color bgColor = occupied
                      ? const Color(0xFFFF6B6B)
                      : selected
                      ? const Color(0xFFCFFF5E)
                      : const Color(0xFF444444);

                  Color textColor = occupied
                      ? Colors.white
                      : selected
                      ? Colors.black
                      : Colors.white;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ElevatedButton(
                      onPressed: occupied
                          ? null
                          : () {
                        setState(() {
                          if (selected) {
                            slotSelezionati.removeWhere((s) => s[0] == slot[0] && s[1] == slot[1]);
                          } else {
                            slotSelezionati.add(slot);
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: bgColor,
                        foregroundColor: textColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text("${slot[0]} - ${slot[1]}"),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () => widget.onOrariConfermati(slotSelezionati.toList()),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFCFFF5E),
              ),
              child: const Text(
                "Conferma",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
