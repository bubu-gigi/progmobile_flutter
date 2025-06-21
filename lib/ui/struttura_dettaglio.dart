import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/core/providers.dart';
import 'package:intl/intl.dart';
import 'package:progmobile_flutter/data/collections/prenotazione.dart';

class StrutturaDettaglioScreen extends ConsumerStatefulWidget {
  final String strutturaId;
  const StrutturaDettaglioScreen({super.key, required this.strutturaId});

  @override
  ConsumerState<StrutturaDettaglioScreen> createState() => _StrutturaDettaglioScreenState();
}

class _StrutturaDettaglioScreenState extends ConsumerState<StrutturaDettaglioScreen> {
  DateTime? dataSelezionata;
  final Set<String> orariSelezionati = {};

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(strutturaDettaglioViewModelProvider.notifier).fetchDettagli(widget.strutturaId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userSession = ref.watch(userSessionProvider);
    final userId = userSession?.userId;
    final state = ref.watch(strutturaDettaglioViewModelProvider);
    final vm = ref.read(strutturaDettaglioViewModelProvider.notifier);
    final struttura = state.struttura;
    final campi = state.campi;

    if (state.isLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (struttura == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: Text("Struttura non trovata", style: TextStyle(color: Colors.white))),
      );
    }

    final giorniDisponibili = campi
        .expand((campo) => campo.disponibilitaSettimanale)
        .map((g) => g.giornoSettimana)
        .toSet();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(struttura.nome)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text("Città: ${struttura.citta}", style: const TextStyle(color: Colors.white)),
            Text("Indirizzo: ${struttura.indirizzo}", style: const TextStyle(color: Colors.white)),
            Text("Sport: ${struttura.sportPraticabili.join(', ')}", style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 20),

            const Text("Scegli una data", style: TextStyle(color: Colors.white)),
            ElevatedButton(
              onPressed: () async {
                final primaData = _trovaPrimaDataValida(giorniDisponibili);
                final picked = await showDatePicker(
                  context: context,
                  initialDate: primaData,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 30)),
                  selectableDayPredicate: (day) {
                    final dow = day.weekday == DateTime.sunday ? 7 : day.weekday;
                    return giorniDisponibili.contains(dow);
                  },
                );

                if (picked != null) {
                  setState(() {
                    dataSelezionata = picked;
                    orariSelezionati.clear();
                  });
                }
              },
              child: const Text("Calendario"),
            ),

            if (dataSelezionata != null) ...[
              const SizedBox(height: 12),
              Text("Data selezionata: ${DateFormat('dd/MM/yyyy').format(dataSelezionata!)}",
                  style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 12),

              const Text("Campi disponibili", style: TextStyle(color: Colors.white, fontSize: 18)),

              for (final campo in campi) ...[
                const SizedBox(height: 16),
                Card(
                  color: Colors.grey[900],
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(campo.nomeCampo, style: const TextStyle(color: Colors.white, fontSize: 16)),
                        Text("Sport: ${campo.sport}", style: const TextStyle(color: Colors.white70)),
                        Text("Terreno: ${campo.tipologiaTerreno}", style: const TextStyle(color: Colors.white70)),
                        const SizedBox(height: 8),
                        Text("Orari disponibili:", style: const TextStyle(color: Colors.white)),

                        for (final giorno in campo.disponibilitaSettimanale)
                          if (_matchDayOfWeek(dataSelezionata!, giorno.giornoSettimana))
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: _generaOrari(giorno.orarioApertura, giorno.orarioChiusura).map((orario) {
                                final key = "${campo.id}-$orario";
                                final selezionato = orariSelezionati.contains(key);
                                return ChoiceChip(
                                  label: Text(orario),
                                  selected: selezionato,
                                  onSelected: (_) {
                                    setState(() {
                                      if (selezionato) {
                                        orariSelezionati.remove(key);
                                      } else {
                                        orariSelezionati.add(key);
                                      }
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

              ElevatedButton(
                onPressed: orariSelezionati.isEmpty || userId == null
                    ? null
                    : () async {
                  final struttura = state.struttura!;
                  final dataString = DateFormat('dd/MM/yyyy').format(dataSelezionata!);

                  for (final entry in orariSelezionati) {
                    final parts = entry.split('-');
                    if (parts.length < 3) continue;

                    final campoId = parts[0];
                    final orarioInizio = parts[1];
                    final orarioFine = parts[2];

                    final campoObj = state.campi.firstWhere(
                          (c) => c.id == campoId,
                      orElse: () => throw Exception("Campo non trovato"),
                    );

                    final conferma = await showDialog<bool>(
                      context: context,
                      builder: (context) =>
                          AlertDialog(
                            title: const Text("Conferma prenotazione"),
                            content: Text(
                              "Stai prenotando per il campo ${campoObj
                                  .nomeCampo} "
                                  "in data $dataString dalle $orarioInizio alle $orarioFine "
                                  "al costo di ${campoObj
                                  .prezzoOrario}€. Sei sicuro?", // TODO: fix
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text("No"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text("Sì"),
                              ),
                            ],
                          ),
                    );

                    if (conferma == true) {
                      final prenotazione = Prenotazione(
                        id: "",
                        userId: userId,
                        strutturaId: struttura.id,
                        campoId: campoObj.id,
                        data: dataString,
                        orarioInizio: orarioInizio,
                        orarioFine: orarioFine,
                        pubblica: false,
                      );

                      await vm.creaPrenotazione(prenotazione);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text(
                            "Prenotazione effettuata")),
                      );

                      setState(() {
                        orariSelezionati.clear();
                        dataSelezionata = null;
                      });
                    }
                  }
                },
                child: const Text("Prenota"),
              )
            ]
          ],
        ),
      ),
    );
  }

  List<String> _generaOrari(String inizio, String fine) {
    final orari = <String>[];
    final startHour = int.parse(inizio.split(":")[0]);
    final endHour = int.parse(fine.split(":")[0]);
    for (int h = startHour; h < endHour; h++) {
      final orarioInizio = "${h.toString().padLeft(2, '0')}:00";
      final orarioFine = "${(h + 1).toString().padLeft(2, '0')}:00";
      orari.add("$orarioInizio - $orarioFine");
    }
    return orari;
  }

  DateTime _trovaPrimaDataValida(Set<int> giorniAbilitati) {
    final oggi = DateTime.now();
    for (int i = 0; i < 30; i++) {
      final candidato = oggi.add(Duration(days: i));
      final dow = candidato.weekday == DateTime.sunday ? 7 : candidato.weekday;
      if (giorniAbilitati.contains(dow)) return candidato;
    }
    return oggi;
  }

  bool _matchDayOfWeek(DateTime date, int giornoFirebase) {
    final weekday = date.weekday == DateTime.sunday ? 7 : date.weekday;
    return weekday == giornoFirebase;
  }
}
