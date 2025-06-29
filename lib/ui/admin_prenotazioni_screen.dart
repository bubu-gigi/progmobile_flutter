import 'package:flutter/material.dart';
import 'package:progmobile_flutter/data/collections/prenotazione.dart';
import 'package:progmobile_flutter/data/collections/struttura.dart';
import 'package:progmobile_flutter/repositories/prenotazione_repository.dart';
import 'package:progmobile_flutter/repositories/struttura_repository.dart';
import 'package:progmobile_flutter/data/collections/enums/sport.dart';

import 'components/dropdown.dart';

class GestionePrenotazioniAdminScreen extends StatefulWidget {
  const GestionePrenotazioniAdminScreen({super.key});

  @override
  State<GestionePrenotazioniAdminScreen> createState() => _GestionePrenotazioniAdminScreenState();
}

class _GestionePrenotazioniAdminScreenState extends State<GestionePrenotazioniAdminScreen> {
  final _prenRepo = PrenotazioneRepository();
  final _strutturaRepo = StrutturaRepository();

  List<Prenotazione> prenotazioni = [];
  List<Struttura> strutture = [];

  String? filtroCitta;
  Sport? filtroSport;
  String? filtroStrutturaId;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _caricaDati();
  }

  Future<void> _caricaDati() async {
    final allStrutture = await _strutturaRepo.caricaTutte();
    final allPren = <Prenotazione>[];

    for (final struttura in allStrutture) {
      final pren = await _prenRepo.prenotazioniStruttura(struttura.id);
      allPren.addAll(pren);
    }

    setState(() {
      strutture = allStrutture;
      prenotazioni = allPren;
      isLoading = false;
    });
  }

  List<Prenotazione> get prenotazioniFiltrate {
    return prenotazioni.where((p) {
      final struttura = strutture.firstWhere(
            (s) => s.id == p.strutturaId
      );
      final matchCitta = filtroCitta == null || struttura.citta == filtroCitta;
      final matchSport = filtroSport == null || struttura.sportPraticabili.contains(filtroSport);
      final matchStruttura = filtroStrutturaId == null || struttura.id == filtroStrutturaId;
      return matchCitta && matchSport && matchStruttura;
    }).toList();
  }

  Set<String> get tutteLeCitta => strutture.map((s) => s.citta).toSet();
  Set<Sport> get tuttiGliSport => strutture.expand((s) => s.sportPraticabili).toSet();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232323),
      appBar: AppBar(
        title: const Text('Gestione Prenotazioni'),
        backgroundColor: const Color(0xFF232323),
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF6136FF)))
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Filtra prenotazioni", style: TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: CustomDropdown<String>(
                    label: 'Città',
                    value: filtroCitta,
                    items: tutteLeCitta.toList(),
                    labelBuilder: (c) => c,
                    onChanged: (val) => setState(() => filtroCitta = val),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CustomDropdown<Sport>(
                    label: 'Sport',
                    value: filtroSport,
                    items: tuttiGliSport.toList(),
                    labelBuilder: (s) => s.label,
                    onChanged: (val) => setState(() => filtroSport = val),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            CustomDropdown<String>(
              label: 'Struttura',
              value: filtroStrutturaId,
              items: strutture.map((s) => s.id).toList(),
              labelBuilder: (id) => strutture.firstWhere((s) => s.id == id).nome,
              onChanged: (val) => setState(() => filtroStrutturaId = val),
            ),
            const SizedBox(height: 20),
            Row(
              children: const [
                Expanded(
                  child: Divider(
                    color: Colors.white24,
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Risultati",
                    style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.white24,
                    thickness: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: prenotazioniFiltrate.isEmpty
                  ? const Center(
                child: Text("Nessuna prenotazione trovata", style: TextStyle(color: Colors.white70)),
              )
                  : ListView.separated(
                itemCount: prenotazioniFiltrate.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) {
                  final p = prenotazioniFiltrate[i];
                  final struttura = strutture.firstWhere((s) => s.id == p.strutturaId);

                  return Card(
                    color: const Color(0xFF1E1E1E),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Color(0xFF6136FF), width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(
                        struttura.nome,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        "Campo: ${p.campoId}\nData: ${p.data} - ${p.orarioInizio} → ${p.orarioFine}",
                        style: const TextStyle(color: Colors.white70),
                      ),
                      onTap: () => _mostraDettaglio(p, struttura),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _mostraDettaglio(Prenotazione pren, Struttura struttura) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFF6136FF), width: 2),
        ),
        title: const Text("Dettagli prenotazione", style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Struttura: ${struttura.nome}", style: const TextStyle(color: Colors.white70)),
            Text("Campo: ${pren.campoId}", style: const TextStyle(color: Colors.white70)),
            Text("Data: ${pren.data}", style: const TextStyle(color: Colors.white70)),
            Text("Orario: ${pren.orarioInizio} - ${pren.orarioFine}", style: const TextStyle(color: Colors.white70)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Chiudi", style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () async {
              await _prenRepo.eliminaPrenotazione(pren.id);
              setState(() {
                prenotazioni.removeWhere((p) => p.id == pren.id);
              });
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Prenotazione eliminata")));
            },
            child: const Text("Elimina", style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }
}
