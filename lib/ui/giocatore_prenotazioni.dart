import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/core/providers.dart';
import 'package:progmobile_flutter/core/routes.dart';
import 'package:progmobile_flutter/ui/components/mappa_strutture_con_filtri.dart';

// Schermata che mostra le prenotazioni fatte dal giocatore.
// Usiamo ConsumerStatefulWidget perché serve sia il ref di Riverpod sia initState()
class GiocatorePrenotazioniScreen extends ConsumerStatefulWidget {
  const GiocatorePrenotazioniScreen({super.key});

  @override
  ConsumerState<GiocatorePrenotazioniScreen> createState() =>
      _GiocatorePrenotazioniScreenState();
}

class _GiocatorePrenotazioniScreenState
    extends ConsumerState<GiocatorePrenotazioniScreen> {
  @override
  void initState() {
    super.initState();
    
    // Recuperiamo l'id dell'utente loggato dalla sessione
    final userId = ref.read(userSessionProvider)?.userId;

    // Se è presente, inizializziamo il ViewModel con quell'utente
    if (userId != null) {
      // Usiamo microtask per aspettare che initState finisca prima di eseguire init()
      Future.microtask(() {
        ref.read(giocatorePrenotazioniViewModelProvider.notifier).init(userId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Otteniamo lo stato (prenotazioni, strutture, loading...) dal provider
    final state = ref.watch(giocatorePrenotazioniViewModelProvider);

    // Otteniamo il ViewModel per accedere ai metodi (setFiltro, eliminaPrenotazione, ecc.)
    final vm = ref.read(giocatorePrenotazioniViewModelProvider.notifier);

    // Se è attivo lo stato showDialog, apriamo il dialog di conferma per eliminare la prenotazione
    if (state.showDialog) {
      Future.microtask(() {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Conferma eliminazione"),
            content:
                const Text("Sei sicuro di voler annullare questa prenotazione?"),
            actions: [
              // Bottone Annulla → chiude il dialog e resetta lo stato
              TextButton(
                onPressed: () {
                  vm.annullaDialog();
                  Navigator.pop(ctx);
                },
                child: const Text("Annulla"),
              ),
              // Bottone Conferma → chiama la funzione di eliminazione
              TextButton(
                onPressed: () async {
                  await vm.eliminaPrenotazione();
                  Navigator.pop(ctx);
                },
                child: const Text("Conferma"),
              ),
            ],
          ),
        );
      });
    }

    // UI principale
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Titolo della sezione
            const Text("Le tue prenotazioni",
                style: TextStyle(color: Colors.white, fontSize: 20)),

            const SizedBox(height: 8),

            // Filtro per tipo di prenotazione (es: tutte, future, passate...)
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Filtra per",
                border: OutlineInputBorder(),
              ),
              dropdownColor: Colors.grey[900],
              style: const TextStyle(color: Colors.white),
              value: state.filtroSelezionato, // Valore attuale del filtro
              items: vm.opzioniFiltro
                  .map((op) =>
                      DropdownMenuItem(value: op, child: Text(op)))
                  .toList(),
              onChanged: (val) => vm.setFiltro(val!), // Cambio filtro
            ),

            const SizedBox(height: 16),

            // Se non ci sono prenotazioni da mostrare
            if (vm.prenotazioniFiltrate.isEmpty)
              const Text("Nessuna prenotazione trovata",
                  style: TextStyle(color: Colors.white))

            // Altrimenti mostriamo la lista
            else
              Expanded(
                child: ListView.separated(
                  itemCount: vm.prenotazioniFiltrate.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) {
                    final pren = vm.prenotazioniFiltrate[i];

                    // Troviamo la struttura collegata a questa prenotazione
                    final struttura = state.strutture
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
                            // Nome della struttura
                            Text(struttura.nome,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18)),

                            const SizedBox(height: 4),

                            // Info campo, data, orario
                            Text("Campo: ${pren.campoId}",
                                style: const TextStyle(color: Colors.white70)),
                            Text("Data: ${pren.data}",
                                style: const TextStyle(color: Colors.white70)),
                            Text("Orario: ${pren.orarioInizio} - ${pren.orarioFine}",
                                style: const TextStyle(color: Colors.white70)),

                            const SizedBox(height: 8),

                            // Bottoni: Dettagli (non attivo) ed Elimina
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // Qui puoi aggiungere navigazione a dettagli
                                  },
                                  child: const Text("Dettagli",
                                      style: TextStyle(
                                          color: Color(0xFF69C9FF))),
                                ),
                                TextButton(
                                  onPressed: () => vm.confermaEliminazionePrenotazione(pren),
                                  child: const Text("Elimina",
                                      style: TextStyle(color: Colors.red)),
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

            // Mostra la mappa delle strutture sotto la lista
            MappaStruttureConFiltri(
              strutture: state.strutture,
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
