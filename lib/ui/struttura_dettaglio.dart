import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progmobile_flutter/data/collections/prenotazione.dart';
import '../core/user_session.dart';
import '../viewmodels/struttura_dettaglio_viewmodel.dart';
import 'components/button.dart';

class StrutturaDettaglioScreen extends StatefulWidget {
  final String strutturaId;

  const StrutturaDettaglioScreen({
    super.key,
    required this.strutturaId,
  });

  @override
  State<StrutturaDettaglioScreen> createState() =>
      _StrutturaDettaglioScreenState();
}

class _StrutturaDettaglioScreenState extends State<StrutturaDettaglioScreen> {
  late final StrutturaDettaglioViewModel viewModel;
  final userSession = UserSessionManager().session;

  DateTime? dataSelezionata;
  final Set<String> orariSelezionati = {};

  @override
  void initState() {
    super.initState();

    viewModel = StrutturaDettaglioViewModel();
    viewModel.addListener(() => setState(() {}));
    viewModel.fetchDettagli(widget.strutturaId);
  }

  @override
  void dispose() {
    viewModel.removeListener(() => setState(() {}));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final struttura = viewModel.struttura;
    final campi = viewModel.campi;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(struttura?.nome ?? '')),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : struttura == null
          ? const Center(
        child: Text(
          "Struttura non trovata",
          style: TextStyle(color: Colors.white),
        ),
      )
          : Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/image1/sfondi4.png',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                Text(
                  "Città: ${struttura!.citta}",
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 12),
                Button(
                  label: "Scegli data",
                  onPressed: () async {
                    final primaData = DateTime.now();
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: primaData,
                      firstDate: primaData,
                      lastDate:
                      primaData.add(const Duration(days: 30)),
                    );

                    if (picked != null) {
                      setState(() {
                        dataSelezionata = picked;
                        orariSelezionati.clear();
                      });
                    }
                  },
                ),
                if (dataSelezionata != null) ...[
                  Text(
                    "Data: ${DateFormat('dd/MM/yyyy').format(dataSelezionata!)}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  for (final campo in campi) ...[
                    const SizedBox(height: 16),
                    Card(
                      color: Colors.grey[900]?.withOpacity(0.8),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              campo.nomeCampo,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Wrap(
                              spacing: 8,
                              children: ['10:00 - 11:00', '11:00 - 12:00']
                                  .map((orario) {
                                final key = "${campo.id}-$orario";
                                final selezionato =
                                orariSelezionati.contains(key);
                                return ChoiceChip(
                                  label: Text(orario),
                                  selected: selezionato,
                                  onSelected: (_) {
                                    setState(() {
                                      selezionato
                                          ? orariSelezionati
                                          .remove(key)
                                          : orariSelezionati
                                          .add(key);
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  Button(
                    label: "Prenota selezionati",
                    onPressed: orariSelezionati.isEmpty
                        ? null
                        : () async {
                      for (final entry in orariSelezionati) {
                        final parts = entry.split('-');
                        final campoId = parts[0];
                        final fasciaOraria =
                        parts.sublist(1).join('-');
                        final orarioParts = fasciaOraria
                            .trim()
                            .split(' - ');
                        final orarioInizio = orarioParts[0];
                        final orarioFine = orarioParts[1];

                        final campo = campi.firstWhere(
                                (c) => c.id == campoId);

                        final pren = Prenotazione(
                          id: "",
                          userId: userSession!.userId,
                          strutturaId: struttura.id,
                          campoId: campoId,
                          strutturaNome: struttura.nome,
                          campoNome: campo.nomeCampo,
                          data: DateFormat('dd/MM/yyyy')
                              .format(dataSelezionata!),
                          orarioInizio: orarioInizio,
                          orarioFine: orarioFine,
                          pubblica: false,
                        );

                        await viewModel.creaPrenotazione(pren);
                      }

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                            content: Text(
                                "Prenotazioni effettuate!")),
                      );

                      setState(() {
                        dataSelezionata = null;
                        orariSelezionati.clear();
                      });
                    },
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
