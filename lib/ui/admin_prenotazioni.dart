import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/data/collections/prenotazione.dart';
import 'package:progmobile_flutter/data/collections/struttura.dart';
import 'package:progmobile_flutter/ui/components/mappa_strutture_con_filtri.dart';
import '../core/providers.dart';

class GestisciPrenotazioniAdminScreen extends ConsumerStatefulWidget {
  const GestisciPrenotazioniAdminScreen({super.key});

  @override
  ConsumerState<GestisciPrenotazioniAdminScreen> createState() => _GestisciPrenotazioniAdminScreenState();
}

class _GestisciPrenotazioniAdminScreenState extends ConsumerState<GestisciPrenotazioniAdminScreen> {
  String filtroCitta = '';
  String filtroSport = '';
  List<Prenotazione> tutteLePrenotazioni = []; // popolate via init()
  List<Struttura> tutteLeStrutture = [];

  @override
  void initState() {
    super.initState();
    _caricaDati();
  }

  Future<void> _caricaDati() async {
    final prenRepo = ref.read(prenotazioneRepositoryProvider);
    final strutturaRepo = ref.read(strutturaRepositoryProvider);
    final strutture = await strutturaRepo.caricaTutte();
    final prenotazioni = <Prenotazione>[];

    for (final s in strutture) {
      final pren = await prenRepo.prenotazioniStruttura(s.id);
      prenotazioni.addAll(pren);
    }

    setState(() {
      tutteLePrenotazioni = prenotazioni;
      tutteLeStrutture = strutture;
    });
  }

  List<Struttura> get struttureFiltrate {
    return tutteLeStrutture.where((s) {
      final cittaMatch = filtroCitta.isEmpty || s.citta.toLowerCase().contains(filtroCitta.toLowerCase());
      final sportMatch = filtroSport.isEmpty ||
          s.sportPraticabili.any(
                (sp) => sp.name.toLowerCase().contains(filtroSport.toLowerCase()),
          );
      return cittaMatch && sportMatch;
    }).toList();
  }

  void _mostraDettagliPrenotazioni(Struttura struttura) {
    final prenStruttura = tutteLePrenotazioni.where((p) => p.strutturaId == struttura.id).toList();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Prenotazioni - ${struttura.nome}'),
        content: prenStruttura.isEmpty
            ? const Text("Nessuna prenotazione ancora.")
            : SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: prenStruttura.length,
            itemBuilder: (_, i) {
              final p = prenStruttura[i];
              return ListTile(
                title: Text("Campo: ${p.campoId}"),
                subtitle: Text("Data: ${p.data} - ${p.orarioInizio} → ${p.orarioFine}"),
              );
            },
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Chiudi")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gestione Prenotazioni")),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Tutte le prenotazioni", style: TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 8),

            if (tutteLePrenotazioni.isEmpty)
              const Text("Nessuna prenotazione registrata",
                  style: TextStyle(color: Colors.white70))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: tutteLePrenotazioni.length,
                  itemBuilder: (_, i) {
                    final p = tutteLePrenotazioni[i];
                    return Card(
                      color: Colors.grey[900],
                      child: ListTile(
                        title: Text("Campo: ${p.campoId}", style: const TextStyle(color: Colors.white)),
                        subtitle: Text("Data: ${p.data} • ${p.orarioInizio} - ${p.orarioFine}",
                            style: const TextStyle(color: Colors.white70)),
                      ),
                    );
                  },
                ),
              ),

            const SizedBox(height: 16),
            const Divider(color: Colors.white54),
            const SizedBox(height: 16),

            const Text("Filtra strutture", style: TextStyle(color: Colors.white, fontSize: 18)),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (val) => setState(() => filtroCitta = val),
                    decoration: const InputDecoration(
                      labelText: "Città",
                      fillColor: Colors.white10,
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    onChanged: (val) => setState(() => filtroSport = val),
                    decoration: const InputDecoration(
                      labelText: "Sport",
                      fillColor: Colors.white10,
                      filled: true,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            MappaStruttureConFiltri(
              strutture: struttureFiltrate,
              onStrutturaSelezionata: _mostraDettagliPrenotazioni,
              height: 300,
            ),
          ],
        ),
      ),
    );
  }
}
