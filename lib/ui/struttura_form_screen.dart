import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:progmobile_flutter/data/collections/campo.dart';
import 'package:progmobile_flutter/data/collections/enums/sport.dart';
import 'package:progmobile_flutter/data/collections/struttura.dart';
import 'package:progmobile_flutter/repositories/campo_repository.dart';
import 'package:progmobile_flutter/ui/components/google_places_autocomplete.dart';
import 'package:progmobile_flutter/viewmodels/strutture_viewmodel.dart';
import 'package:progmobile_flutter/repositories/struttura_repository.dart';

import 'components/button.dart';
import 'components/campo_dialog.dart';

class StrutturaFormScreen extends StatefulWidget {
  final Struttura? strutturaDaModificare;
  final List<Campo>? campiEsistenti;

  const StrutturaFormScreen({
    super.key,
    this.strutturaDaModificare,
    this.campiEsistenti,
  });

  @override
  State<StrutturaFormScreen> createState() => _StrutturaFormScreenState();
}

class _StrutturaFormScreenState extends State<StrutturaFormScreen> {
  late final StruttureViewModel viewModel;

  late TextEditingController _nomeController;
  late TextEditingController _indirizzoController;

  List<Campo> campi = [];
  LatLng? latLng;
  String? citta;

  Campo? campoInModifica;

  @override
  void initState() {
    super.initState();

    viewModel = StruttureViewModel(StrutturaRepository(), CampoRepository());

    _nomeController = TextEditingController(
      text: widget.strutturaDaModificare?.nome ?? '',
    );

    _indirizzoController = TextEditingController(
      text: widget.strutturaDaModificare?.indirizzo ?? '',
    );

    campi = widget.campiEsistenti?.toList() ?? [];

    latLng = widget.strutturaDaModificare != null
        ? LatLng(
      widget.strutturaDaModificare!.latitudine,
      widget.strutturaDaModificare!.longitudine,
    )
        : null;

    citta = widget.strutturaDaModificare?.citta;
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _indirizzoController.dispose();
    super.dispose();
  }

  Future<String> _getCittaFromLatLng(double lat, double lng) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        lat,
        lng,
        localeIdentifier: "it_IT",
      );
      return placemarks.first.locality ?? '';
    } catch (_) {
      return '';
    }
  }

  Future<void> _salvaStruttura() async {
    print("prima del check");
    if (latLng == null || _nomeController.text.isEmpty) return;

    print("Check passato");
    final strutturaDaSalvare = widget.strutturaDaModificare != null
        ? widget.strutturaDaModificare!.copyWith(
      nome: _nomeController.text,
      indirizzo: _indirizzoController.text,
      citta: citta ?? '',
      latitudine: latLng!.latitude,
      longitudine: latLng!.longitude,
      sportPraticabili: campi.map((c) => c.sport).toSet().toList(),
    )
        : Struttura(
      id: '',
      nome: _nomeController.text,
      indirizzo: _indirizzoController.text,
      citta: citta ?? '',
      latitudine: latLng!.latitude,
      longitudine: latLng!.longitude,
      sportPraticabili: campi.map((c) => c.sport).toSet().toList(),
    );

    final strutturaSalvata = widget.strutturaDaModificare != null
        ? await viewModel.aggiornaStruttura(strutturaDaSalvare).then((_) => strutturaDaSalvare)
        : await viewModel.aggiungiStruttura(strutturaDaSalvare);

    await viewModel.sincronizzaCampi(strutturaSalvata.id, campi);

    Navigator.pop(context);
  }

  Future<void> _eliminaStruttura() async {
    if (widget.strutturaDaModificare == null) return;

    final conferma = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Conferma eliminazione"),
        content: const Text("Vuoi davvero eliminare questa struttura?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text("Annulla"),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text("Elimina", style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );

    if (conferma == true) {
      await viewModel.eliminaStruttura(widget.strutturaDaModificare!.id);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Struttura eliminata")),
      );
    }
  }


  void _aggiungiCampo() {
    showDialog(
      context: context,
      builder: (_) => CampoDialog(
        campo: null,
        onCampoSalvato: (c) => setState(() => campi.add(c)),
      ),
    );
  }

  void _modificaCampo(Campo campo) {
    showDialog(
      context: context,
      builder: (_) => CampoDialog(
        campo: campo,
        onCampoSalvato: (c) {
          setState(() {
            campi = campi.map((el) => el == campo ? c : el).toList();
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.strutturaDaModificare != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Modifica struttura' : 'Nuova struttura'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image1/sfondo1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              const SizedBox(height: 300),
              TextField(
                controller: _nomeController,
                style: TextStyle(color: Colors.white), // testo bianco
                decoration: InputDecoration(
                  labelText: 'Nome struttura',
                  labelStyle: TextStyle(color: Colors.white70), // label bianca semitrasparente
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6136FF), width: 3.0),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 3.0),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Theme(
                data: Theme.of(context).copyWith(
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: Colors.white,
                    selectionColor: Colors.white24,
                    selectionHandleColor: Colors.white,
                  ),
                  inputDecorationTheme: InputDecorationTheme(
                    hintStyle: TextStyle(color: Colors.white70),
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: Color(0xFF6136FF), width: 3.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: Colors.green, width: 3),
                    ),
                  ),
                  textTheme: TextTheme(
                    titleMedium: TextStyle(color: Colors.white),
                  ),
                ),
                child: GoogleAutocompleteField(
                  onAddressSelected: (address) =>
                      setState(() => _indirizzoController.text = address),
                  onCitySelected: (city) => setState(() => citta = city),
                  onLatLngSelected: (pos) => setState(() => latLng = pos),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _indirizzoController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Indirizzo completo',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6136FF), width: 3.0),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 3.0),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 50),
              Button(
                label: 'Aggiungi campo',
                onPressed: _aggiungiCampo,
              ),
              const SizedBox(height: 8),
              if (campi.isNotEmpty) ...[
                const Text(
                  'Campi aggiunti:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                for (final campo in campi)
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Color(0xFF6136FF), width: 2),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text(
                        campo.nomeCampo,
                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        campo.sport.label,
                        style: const TextStyle(color: Colors.black54),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.deepPurple),
                            onPressed: () => _modificaCampo(campo),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () async {
                              final conferma = await showDialog<bool>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text("Conferma eliminazione"),
                                  content: const Text("Vuoi davvero eliminare questo campo?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(ctx).pop(false),
                                      child: const Text("Annulla"),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.of(ctx).pop(true),
                                      child: const Text("Elimina", style: TextStyle(color: Colors.redAccent)),
                                    ),
                                  ],
                                ),
                              );

                              if (conferma == true) {
                                setState(() => campi.remove(campo));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Campo eliminato")),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
              const SizedBox(height: 16),
              Button(
                label: isEdit ? 'Aggiorna struttura' : 'Salva struttura',
                onPressed: _salvaStruttura,
              ),
              if (isEdit)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Button(
                    label: 'Elimina struttura',
                    onPressed: _eliminaStruttura,
                    backgroundColor: Colors.red,
                    borderSide: BorderSide.none,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}