import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/core/user_session.dart';
import 'package:progmobile_flutter/ui/components/mappa_strutture_con_filtri.dart';
import 'package:progmobile_flutter/viewmodels/giocatore_viewmodel.dart';

class GiocatorePrenotazioniScreen extends ConsumerStatefulWidget {
  const GiocatorePrenotazioniScreen({super.key});

  @override
  ConsumerState<GiocatorePrenotazioniScreen> createState() => _GiocatorePrenotazioniScreenState();
}

class _GiocatorePrenotazioniScreenState extends ConsumerState<GiocatorePrenotazioniScreen> {
  @override
  void initState() {
    super.initState();
    final userId = ref.read(userSessionProvider)?.userId;
    Future.microtask(() {
      ref.read(giocatorePrenotazioniViewModelProvider.notifier).init(userId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(giocatorePrenotazioniViewModelProvider);
    final vm = ref.read(giocatorePrenotazioniViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Le tue prenotazioni", style: TextStyle(color: Colors.white, fontSize: 20)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Filtra per",
                border: OutlineInputBorder(),
              ),
              value: viewModel.filtroSelezionato,
              items: vm.opzioniFiltro
                  .map((op) => DropdownMenuItem(value: op, child: Text(op)))
                  .toList(),
              onChanged: (val) => vm.setFiltro(val!),
            ),
            const SizedBox(height: 16),
            if (vm.prenotazioniFiltrate.isEmpty)
              const Text("Nessuna prenotazione trovata", style: TextStyle(color: Colors.white))
            else
              Expanded(
                child: ListView.separated(
                  itemCount: vm.prenotazioniFiltrate.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) {
                    final pren = vm.prenotazioniFiltrate[i];
                    final struttura = viewModel.strutture.firstWhere((s) => s.id == pren.strutturaId);
                    return Card(
                      color: const Color(0xFF1E1E1E),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Color(0xFFE36BE0), width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(struttura.nome, style: const TextStyle(color: Colors.white, fontSize: 18)),
                            const SizedBox(height: 4),
                            Text("Campo: ${pren.campoId}", style: const TextStyle(color: Colors.white70)),
                            Text("Data: ${pren.data}", style: const TextStyle(color: Colors.white70)),
                            Text("Orario: ${pren.orarioInizio} - ${pren.orarioFine}", style: const TextStyle(color: Colors.white70)),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    //Navigator.pushNamed(context, AppRoutes.strutturaDettaglio(struttura.id));
                                  },
                                  child: const Text("Dettagli", style: TextStyle(color: Color(0xFF69C9FF))),
                                ),
                                TextButton(
                                  onPressed: () => vm.confermaEliminazionePrenotazione(pren),
                                  child: const Text("Elimina", style: TextStyle(color: Colors.red)),
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
              onStrutturaSelezionata: (_) {
                //Navigator.pushNamed(context, AppRoutes.strutturaDettaglio(_.id));
              },
              height: 300,
            ),
          ],
        ),
      ),
      floatingActionButton: viewModel.showDialog
          ? AlertDialog(
              title: const Text("Conferma eliminazione"),
              content: const Text("Sei sicuro di voler annullare questa prenotazione?"),
              actions: [
                TextButton(
                  onPressed: vm.annullaDialog,
                  child: const Text("Annulla"),
                ),
                TextButton(
                  onPressed: vm.eliminaPrenotazione,
                  child: const Text("Conferma"),
                ),
              ],
            )
          : null,
    );
  }
}
