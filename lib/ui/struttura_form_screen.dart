import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:progmobile_flutter/data/collections/campo.dart';
import 'package:progmobile_flutter/data/collections/struttura.dart';
import 'package:progmobile_flutter/repositories/campo_repository.dart';
import 'package:progmobile_flutter/ui/components/campo_dialog.dart';
import 'package:progmobile_flutter/ui/components/google_places_autocomplete.dart';
import 'package:progmobile_flutter/viewmodels/strutture_viewmodel.dart';
import 'package:progmobile_flutter/repositories/struttura_repository.dart';

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
    if (latLng == null || _nomeController.text.isEmpty) return;

    final struttura = widget.strutturaDaModificare != null
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

    if (widget.strutturaDaModificare != null) {
      await viewModel.aggiornaStruttura(struttura);
    } else {
      await viewModel.aggiungiStruttura(struttura);
    }

    Navigator.pop(context); // Torniamo alla lista
  }

  Future<void> _eliminaStruttura() async {
    if (widget.strutturaDaModificare == null) return;
    await viewModel.eliminaStruttura(widget.strutturaDaModificare!.id);
    Navigator.pop(context);
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
            image: AssetImage("assets/image1/sfondi4png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              TextField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome struttura',
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
              GoogleAutocompleteField(
                onAddressSelected: (address) =>
                    setState(() => _indirizzoController.text = address),
                onCitySelected: (city) => setState(() => citta = city),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _indirizzoController,
                decoration: InputDecoration(
                  labelText: 'Indirizzo completo',
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
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _aggiungiCampo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6136FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  side: BorderSide(
                    color: Color(0xFFCFFF5E),
                    width: 3,
                  ),
                ),
                child: const Text(
                  'Aggiungi campo',
                  style: TextStyle(
                    color: Colors.white, // Imposta il colore del testo in bianco
                  ),
                ),
              ),
              const SizedBox(height: 8),
              if (campi.isNotEmpty) ...[
                const Text(
                  'Campi aggiunti:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                for (final campo in campi)
                  ListTile(
                    title: Text('${campo.nomeCampo} (${campo.sport.name})'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _modificaCampo(campo),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                              setState(() => campi.remove(campo)),
                        ),
                      ],
                    ),
                  ),
              ],
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _salvaStruttura,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6136FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  side: BorderSide(
                    color: Color(0xFFCFFF5E),
                    width: 3,
                  ),
                ),
                child: Text(
                  isEdit ? 'Aggiorna struttura' : 'Salva struttura',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              if (isEdit)
                ElevatedButton(
                  style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: _eliminaStruttura,
                  child: const Text('Elimina struttura'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}