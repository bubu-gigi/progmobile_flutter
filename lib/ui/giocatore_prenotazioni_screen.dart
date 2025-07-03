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
  final userSession = UserSessionManager().getCurrentUser();
  final viewModel = GiocatorePrenotazioniViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.addListener(_onStateChanged);
    viewModel.init(userSession!.id);
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
    return Scaffold(
      backgroundColor: const Color(0xFF232323),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Le tue prenotazioni",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 8),
            Theme(
              data: Theme.of(context).copyWith(
                canvasColor: const Color(0xFF232323),
                inputDecorationTheme: InputDecorationTheme(
                  labelStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                    const BorderSide(color: Color(0xFF6136FF), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                    const BorderSide(color: Color(0xFF6136FF), width: 2),
                  ),
                ),
              ),
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Filtra per"),
                dropdownColor: const Color(0xFF232323),
                style: const TextStyle(color: Colors.white),
                value: viewModel.filtroSelezionato,
                items: viewModel.opzioniFiltro
                    .map((op) => DropdownMenuItem(
                  value: op,
                  child: Text(op,
                      style: const TextStyle(color: Colors.white)),
                ))
                    .toList(),
                onChanged: (val) => viewModel.setFiltro(val!),
              ),
            ),
            if (viewModel.prenotazioniFiltrate.isEmpty)
              const Text(
                "Nessuna prenotazione trovata",
                style: TextStyle(color: Colors.white70),
              )
            else
              Expanded(
                child: ListView.separated(
                  itemCount: viewModel.prenotazioniFiltrate.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, i) {
                    final pren = viewModel.prenotazioniFiltrate[i];
                    final struttura = viewModel.strutture
                        .firstWhere((s) => s.id == pren.strutturaId);

                    return Card(
                      color: const Color(0xFF1E1E1E),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Color(0xFF6136FF), width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              struttura.nome,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                            Text("Campo: ${pren.campoNome}",
                                style:
                                const TextStyle(color: Colors.white70)),
                            Text("Data: ${pren.data}",
                                style:
                                const TextStyle(color: Colors.white70)),
                            Text(
                                "Orario: ${pren.orarioInizio} - ${pren.orarioFine}",
                                style:
                                const TextStyle(color: Colors.white70)),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () =>
                                      _showDettagliDialog(pren, struttura),
                                  child: const Text("Dettagli",
                                      style: TextStyle(
                                          color: Color(0xFF69C9FF))),
                                ),
                                if (_isPrenotazioneFutura(pren))
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.redAccent),
                                    tooltip: "Elimina prenotazione",
                                    onPressed: () =>
                                        _showConfermaEliminazione(pren),
                                  )
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
              onStrutturaSelezionata: (struttura) async {
                final result = await Navigator.pushNamed(
                  context,
                  AppRoutes.dettaglioStruttura,
                  arguments: struttura.id,
                );

                if (result == true) {
                  final userId = userSession!.id;
                  viewModel.init(userId);
                }
              },
              height: 300,
            ),
          ],
        ),
      ),
    );
  }

  void _showDettagliDialog(pren, struttura) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFF6136FF), width: 2),
        ),
        title: const Text("Dettagli prenotazione",
            style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Struttura: ${struttura.nome}",
                style: const TextStyle(color: Colors.white70)),
            Text("Campo: ${pren.campoNome}",
                style: const TextStyle(color: Colors.white70)),
            Text("Data: ${pren.data}",
                style: const TextStyle(color: Colors.white70)),
            Text("Orario: ${pren.orarioInizio} - ${pren.orarioFine}",
                style: const TextStyle(color: Colors.white70)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Chiudi", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showConfermaEliminazione(pren) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFF6136FF), width: 2),
        ),
        title: const Text("Conferma eliminazione",
            style: TextStyle(color: Colors.white)),
        content: const Text("Sei sicuro di voler eliminare questa prenotazione?",
            style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Annulla", style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              await viewModel.eliminaPrenotazione(pren);
            },
            child: const Text("Elimina",
                style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  bool _isPrenotazioneFutura(pren) {
    try {
      final dataParts = pren.data.split('/');
      if (dataParts.length != 3) return false;

      final giorno = int.parse(dataParts[0]);
      final mese = int.parse(dataParts[1]);
      final anno = int.parse(dataParts[2]);

      final partsInizio = pren.orarioInizio.split(":");
      if (partsInizio.length < 2) return false;

      final inizio = DateTime(
        anno,
        mese,
        giorno,
        int.tryParse(partsInizio[0]) ?? 0,
        int.tryParse(partsInizio[1]) ?? 0,
      );

      return inizio.isAfter(DateTime.now());
    } catch (e) {
      debugPrint("Errore parsing data/orario: $e");
      return false;
    }
  }

}
