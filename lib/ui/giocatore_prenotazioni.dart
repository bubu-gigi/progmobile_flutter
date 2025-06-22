import 'package:flutter/material.dart';
import 'package:progmobile_flutter/core/routes.dart';
import 'package:progmobile_flutter/core/user_session.dart';
import 'package:progmobile_flutter/ui/components/mappa_strutture_con_filtri.dart';
import 'package:progmobile_flutter/viewmodels/giocatore_prenotazioni_viewmodel.dart';

class GiocatorePrenotazioniScreen extends StatefulWidget {

  const GiocatorePrenotazioniScreen({super.key});

  @override
  State<GiocatorePrenotazioniScreen> createState() =>
      _GiocatorePrenotazioniScreenState();
}

class _GiocatorePrenotazioniScreenState
    extends State<GiocatorePrenotazioniScreen> {

  final userSession = UserSessionManager().session;
  final viewModel = GiocatorePrenotazioniViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.addListener(_onStateChanged);

    viewModel.init(userSession!.userId);
  }

  @override
  void dispose() {
    viewModel.removeListener(_onStateChanged);
    super.dispose();
  }

  void _onStateChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (viewModel.showDialog) {
      Future.microtask(() {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Conferma eliminazione"),
            content: const Text(
              "Sei sicuro di voler annullare questa prenotazione?",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  viewModel.annullaDialog();
                  Navigator.pop(ctx);
                },
                child: const Text("Annulla"),
              ),
              TextButton(
                onPressed: () async {
                  await viewModel.eliminaPrenotazione();
                  Navigator.pop(ctx);
                },
                child: const Text("Conferma"),
              ),
            ],
          ),
        );
      });
    }

    return Scaffold(
      backgroundColor: Colors.white10,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Le tue prenotazioni",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Filtra per",
                border: OutlineInputBorder(),
              ),
              dropdownColor: Colors.grey[900],
              style: const TextStyle(color: Colors.white),
              value: viewModel.filtroSelezionato,
              items: viewModel.opzioniFiltro
                  .map((op) => DropdownMenuItem(
                value: op,
                child: Text(op),
              ))
                  .toList(),
              onChanged: (val) => viewModel.setFiltro(val!),
            ),
            const SizedBox(height: 16),
            if (viewModel.prenotazioniFiltrate.isEmpty)
              const Text(
                "Nessuna prenotazione trovata",
                style: TextStyle(color: Colors.white),
              )
            else
              Expanded(
                child: ListView.separated(
                  itemCount: viewModel.prenotazioniFiltrate.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) {
                    final pren = viewModel.prenotazioniFiltrate[i];
                    final struttura = viewModel.strutture
                        .firstWhere((s) => s.id == pren.strutturaId);

                    return Card(
                      color: const Color(0xFF1E1E1E),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Color(0xFFE36BE0), width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              struttura.nome,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Campo: ${pren.campoId}",
                              style: const TextStyle(color: Colors.white70),
                            ),
                            Text(
                              "Data: ${pren.data}",
                              style: const TextStyle(color: Colors.white70),
                            ),
                            Text(
                              "Orario: ${pren.orarioInizio} - ${pren.orarioFine}",
                              style: const TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // aggiungi navigazione dettagli
                                  },
                                  child: const Text(
                                    "Dettagli",
                                    style:
                                    TextStyle(color: Color(0xFF69C9FF)),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => viewModel
                                      .confermaEliminazionePrenotazione(pren),
                                  child: const Text(
                                    "Elimina",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 8),
            MappaStruttureConFiltri(
              strutture: viewModel.strutture,
              onStrutturaSelezionata: (struttura) {
                Navigator.pushNamed(
                  context,
                  AppRoutes.dettaglioStruttura,
                  arguments: struttura.id,
                );
              },
              height: 300,
            ),
          ],
        ),
      ),
    );
  }
}
