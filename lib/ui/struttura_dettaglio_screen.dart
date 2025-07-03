
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progmobile_flutter/data/collections/enums/sport.dart';
import 'package:progmobile_flutter/data/collections/prenotazione.dart';
import 'package:progmobile_flutter/viewmodels/struttura_dettaglio_viewmodel.dart';
import 'package:progmobile_flutter/core/user_session.dart';
import 'package:progmobile_flutter/ui/components/button.dart';
import 'package:progmobile_flutter/ui/components/campo_date_picker.dart';

import '../core/helpers.dart';
import 'components/orari_dialog.dart';

class StrutturaDettaglioScreen extends StatefulWidget {
  final String strutturaId;
  final Prenotazione? prenotazioneDaModificare;

  const StrutturaDettaglioScreen({
    super.key,
    required this.strutturaId,
    this.prenotazioneDaModificare,
  });

  @override
  State<StrutturaDettaglioScreen> createState() => _StrutturaDettaglioScreenState();
}

class _StrutturaDettaglioScreenState extends State<StrutturaDettaglioScreen> {
  final viewModel = StrutturaDettaglioViewModel();
  final userSession = UserSessionManager().getCurrentUser();

  DateTime? dataSelezionata;
  Map<String, List<List<String>>> slotPerCampo = {};

  @override
  void initState() {
    super.initState();
    viewModel.addListener(() => setState(() {}));
    viewModel.fetchDettagli(widget.strutturaId);
    if (widget.prenotazioneDaModificare != null) {
      dataSelezionata = DateFormat('dd/MM/yyyy').parse(widget.prenotazioneDaModificare!.data);
      slotPerCampo[widget.prenotazioneDaModificare!.campoId] = [
        [widget.prenotazioneDaModificare!.orarioInizio, widget.prenotazioneDaModificare!.orarioFine]
      ];
    }
  }

  @override
  void dispose() {
    viewModel.removeListener(() => setState(() {}));
    super.dispose();
  }

  void _selezionaSlot(String campoId, List<List<String>> slots) {
    setState(() {
      slotPerCampo[campoId] = slots;
    });
  }

  Future<void> _prenota() async {
    for (final entry in slotPerCampo.entries) {
      final campoId = entry.key;
      final slotsAccorpati = raggruppaSlotConsecutivi(entry.value);

      for (final slot in slotsAccorpati) {
        final pren = Prenotazione(
          id: '',
          userId: userSession!.id,
          strutturaId: viewModel.struttura!.id,
          campoId: campoId,
          strutturaNome: viewModel.struttura!.nome,
          campoNome: viewModel.campi.firstWhere((c) => c.id == campoId).nomeCampo,
          data: DateFormat('dd/MM/yyyy').format(dataSelezionata!),
          orarioInizio: slot[0],
          orarioFine: slot[1],
        );
        await viewModel.creaPrenotazione(pren);
      }
    }

    if (widget.prenotazioneDaModificare != null) {
      await viewModel.eliminaPrenotazione(widget.prenotazioneDaModificare!.id);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Prenotazione completata!")),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final struttura = viewModel.struttura;
    final campi = viewModel.campi;

    final isPreferito = struttura != null &&
        (UserSessionManager().getCurrentUser()?.preferiti.contains(struttura.id) ?? false);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(child: Text(struttura?.nome ?? "")),
            if (struttura != null)
              IconButton(
                icon: Icon(
                  isPreferito ? Icons.star : Icons.star_border,
                  color: isPreferito ? Colors.yellow : Colors.white,
                ),
                onPressed: () async {
                  await viewModel.togglePreferito(struttura.id);
                  setState(() {});
                },
              ),
          ],
        ),
        backgroundColor: const Color(0xFF232323),
        foregroundColor: Colors.white,
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : struttura == null
          ? const Center(child: Text("Struttura non trovata", style: TextStyle(color: Colors.white)))
          : ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(struttura.nome, style: const TextStyle(color: Colors.white, fontSize: 20)),
          const SizedBox(height: 6),
          Text(struttura.indirizzo, style: const TextStyle(color: Colors.white70)),
          Text("Città: ${struttura.citta}", style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 20),
          if (campi.isEmpty)
            const Center(
              child: Text(
                "Nessun campo disponibile per questa struttura",
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ...campi.map((campo) {
            final hasData = dataSelezionata != null;
            final hasSlot = slotPerCampo[campo.id]?.isNotEmpty == true;

            return Card(
              color: Colors.grey[900],
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(campo.nomeCampo, style: const TextStyle(color: Colors.white, fontSize: 18)),
                    const SizedBox(height: 6),
                    Text("Sport: ${campo.sport.label}", style: const TextStyle(color: Colors.white70)),
                    Text("Giocatori: ${campo.numeroGiocatori}", style: const TextStyle(color: Colors.white70)),
                    Text("Terreno: ${campo.tipologiaTerreno}", style: const TextStyle(color: Colors.white70)),
                    Text("Prezzo: €${campo.prezzoOrario}", style: const TextStyle(color: Colors.white70)),
                    const SizedBox(height: 10),
                    CampoDatePicker(
                      disponibilita: campo.disponibilitaSettimanale,
                      label: "Seleziona data",
                      onDateSelected: (date) {
                        setState(() {
                          dataSelezionata = date;
                          slotPerCampo.remove(campo.id);
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    if (hasData)
                      Button(
                        label: "🕑 Seleziona orari disponibili",
                        onPressed: () async {
                          final selezionati = await showDialog<List<List<String>>>(
                            context: context,
                            builder: (ctx) => OrariDialog(
                              campo: campo,
                              data: dataSelezionata!,
                              prenotazioniOccupate: viewModel.prenotazioni,
                              onDismiss: () => Navigator.pop(context),
                              onOrariConfermati: (slots) => Navigator.pop(ctx, slots),
                            ),
                          );
                          if (selezionati != null) {
                            _selezionaSlot(campo.id, selezionati);
                          }
                        },
                        backgroundColor: const Color(0xFF6136FF),
                      ),
                    if (hasSlot)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: slotPerCampo[campo.id]!
                            .map((s) => Text("${s[0]} → ${s[1]}", style: const TextStyle(color: Colors.white70)))
                            .toList(),
                      ),
                    if (hasData && hasSlot)
                      Button(
                        label: "Prenota",
                        onPressed: _prenota,
                        backgroundColor: const Color(0xFFCFFF5E),
                      ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
