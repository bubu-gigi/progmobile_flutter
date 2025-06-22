import 'package:flutter/material.dart';
import 'package:progmobile_flutter/data/collections/campo.dart';
import 'package:progmobile_flutter/data/collections/enums/sport.dart';
import 'package:progmobile_flutter/data/collections/template_giornaliero.dart';
import 'orario_dialog.dart';

class CampoDialog extends StatefulWidget {
  final Campo? campo;
  final ValueChanged<Campo> onCampoSalvato;

  const CampoDialog({super.key, this.campo, required this.onCampoSalvato});

  @override
  State<CampoDialog> createState() => _CampoDialogState();
}

class _CampoDialogState extends State<CampoDialog> {
  late TextEditingController _nomeController;
  Sport? sportSelezionato;
  String terreno = "erbaSintetica";
  String prezzo = "20.0";
  String numGiocatori = "5";
  bool spogliatoi = false;
  List<TemplateGiornaliero> disponibilita = [];

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.campo?.nomeCampo ?? '');
    sportSelezionato = widget.campo?.sport;
    terreno = "erbaSintetica";
    prezzo = widget.campo?.prezzoOrario?.toString() ?? "20.0";
    numGiocatori = widget.campo?.numeroGiocatori?.toString() ?? "5";
    spogliatoi = widget.campo?.spogliatoi ?? false;
    disponibilita = List.from(widget.campo?.disponibilitaSettimanale ?? []);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  void _aggiungiOrario() {
    showDialog(
      context: context,
      builder: (_) => OrarioDialog(
        onOrarioAdded: (orario) => setState(() => disponibilita.add(orario)),
      ),
    );
  }

  void _salvaCampo() {
    if (_nomeController.text.isEmpty || sportSelezionato == null) return;

    final campo = Campo(
      id: widget.campo?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      nomeCampo: _nomeController.text,
      sport: sportSelezionato!,
      prezzoOrario: double.tryParse(prezzo) ?? 0.0,
      numeroGiocatori: int.tryParse(numGiocatori) ?? 0,
      spogliatoi: spogliatoi,
      disponibilitaSettimanale: disponibilita,
    );

    widget.onCampoSalvato(campo);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.campo != null ? 'Modifica campo' : 'Nuovo campo'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome campo'),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<Sport>(
              value: sportSelezionato,
              decoration: const InputDecoration(labelText: 'Sport'),
              items: Sport.values
                  .map((s) => DropdownMenuItem(
                value: s,
                child: Text(s.name),
              ))
                  .toList(),
              onChanged: (s) => setState(() => sportSelezionato = s),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: terreno,
              decoration: const InputDecoration(labelText: 'Terreno'),
              items: ["erbaSintetica", "erba", "terra"]
                  .map((t) => DropdownMenuItem(
                value: t,
                child: Text(t),
              ))
                  .toList(),
              onChanged: (t) => setState(() => terreno = t ?? terreno),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(labelText: 'Prezzo/ora'),
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: prezzo),
              onChanged: (v) => prezzo = v,
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(labelText: 'Num. giocatori'),
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: numGiocatori),
              onChanged: (v) => numGiocatori = v,
            ),
            Row(
              children: [
                Checkbox(
                  value: spogliatoi,
                  onChanged: (v) => setState(() => spogliatoi = v ?? false),
                ),
                const Text('Spogliatoi disponibili')
              ],
            ),
            const Divider(),
            Text('Orari settimanali', style: Theme.of(context).textTheme.titleSmall),
            ...disponibilita.map(
                  (o) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${o.giornoSettimana}: ${o.orarioApertura} - ${o.orarioChiusura}',
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => setState(() => disponibilita.remove(o)),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _aggiungiOrario,
              child: const Text('Aggiungi orario'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Annulla'),
        ),
        TextButton(
          onPressed: _salvaCampo,
          child: const Text('Salva'),
        ),
      ],
    );
  }
}
