import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/data/collections/prenotazione.dart';
import 'package:progmobile_flutter/data/collections/struttura.dart';
import 'package:progmobile_flutter/ui/components/mappa_strutture_con_filtri.dart';
import '../core/providers.dart';

class GestisciPrenotazioniAdminScreen extends ConsumerStatefulWidget {
  const GestisciPrenotazioniAdminScreen({super.key});

  @override
  ConsumerState<GestisciPrenotazioniAdminScreen> createState() =>
      _GestisciPrenotazioniAdminScreenState();
}

class _GestisciPrenotazioniAdminScreenState extends ConsumerState<GestisciPrenotazioniAdminScreen> {
  String filtroCitta = '';
  String filtroSport = '';
  List<Prenotazione> tutteLePrenotazioni = [];
  List<Struttura> tutteLeStrutture = [];
  bool isLoading = true;

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
      isLoading = false;
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
            ? const Text('Nessuna prenotazione ancora.')
            : SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: prenStruttura.length,
            itemBuilder: (_, i) {
              final p = prenStruttura[i];
              return ListTile(
                title: Text("Campo: ${p.campoId}"),
                subtitle: Text(
                  "Data: ${p.data} - ${p.orarioInizio} → ${p.orarioFine}",
                ),
                onTap: () => _mostraDettaglioSingolaPrenotazione(p),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Chiudi'),
          ),
        ],
      ),
    );
  }

  void _mostraDettaglioSingolaPrenotazione(Prenotazione p) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Dettagli prenotazione'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Campo: ${p.campoId}'),
            Text('Data: ${p.data}'),
            Text('Orario: ${p.orarioInizio} → ${p.orarioFine}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Chiudi'),
          ),
          TextButton(
            onPressed: () async {
              await _eliminaPrenotazione(p);
              Navigator.pop(ctx); // Chiude il dialog di dettagli
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Elimina'),
          ),
        ],
      ),
    );
  }

  Future<void> _eliminaPrenotazione(Prenotazione p) async {
    final prenRepo = ref.read(prenotazioneRepositoryProvider);
    await prenRepo.eliminaPrenotazione(p.id);
    setState(() {
      tutteLePrenotazioni.removeWhere((el) => el.id == p.id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Prenotazione eliminata')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gestione Prenotazioni")),
      backgroundColor: Colors.black,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Tutte le prenotazioni",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 8),
            if (tutteLePrenotazioni.isEmpty)
              const Text(
                "Nessuna prenotazione registrata",
                style: TextStyle(color: Colors.white70),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: tutteLePrenotazioni.length,
                  itemBuilder: (_, i) {
                    final p = tutteLePrenotazioni[i];
                    return Card(
                      color: Colors.grey[900],
                      child: ListTile(
                        title: Text(
                          "Campo: ${p.campoId}",
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          "Data: ${p.data} • ${p.orarioInizio} - ${p.orarioFine}",
                          style: const TextStyle(color: Colors.white70),
                        ),
                        onTap: () => _mostraDettaglioSingolaPrenotazione(p),
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 16),
            const Divider(color: Colors.white54),
            const SizedBox(height: 16),
            const Text(
              "Filtra strutture",
              style: TextStyle(color: Colors.white, fontSize: 18),
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
