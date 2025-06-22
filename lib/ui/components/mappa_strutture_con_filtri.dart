import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progmobile_flutter/data/collections/enums/sport.dart';
import 'package:progmobile_flutter/data/collections/struttura.dart';

class MappaStruttureConFiltri extends StatefulWidget {
  final List<Struttura> strutture;
  final void Function(Struttura) onStrutturaSelezionata;
  final double? width;
  final double? height;

  const MappaStruttureConFiltri({
    super.key,
    required this.strutture,
    required this.onStrutturaSelezionata,
    this.width,
    this.height,
  });

  @override
  State<MappaStruttureConFiltri> createState() => _MappaStruttureConFiltriState();
}

class _MappaStruttureConFiltriState extends State<MappaStruttureConFiltri> {
  String? cittaSelezionata;
  Sport? sportSelezionato;
  late GoogleMapController _mapController;
  bool locationGranted = false;

  List<String> get cittaPrincipali => widget.strutture
      .map((s) => s.citta)
      .where((c) => c.trim().isNotEmpty)
      .toSet()
      .toList()
    ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

  List<Sport> get sportDisponibili => widget.strutture
      .expand((s) => s.sportPraticabili)
      .toSet()
      .toList();

  List<Struttura> get struttureFiltrate {
    return widget.strutture.where((s) {
      final matchCitta = cittaSelezionata == null ||
          s.citta.toLowerCase() == cittaSelezionata!.toLowerCase();
      final matchSport = sportSelezionato == null ||
          s.sportPraticabili.contains(sportSelezionato);
      return matchCitta && matchSport;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      status = await Permission.location.request();
    }
    setState(() {
      locationGranted = status.isGranted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _dropdownFiltro("Città", cittaPrincipali, cittaSelezionata,
                    (val) => setState(() => cittaSelezionata = val)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButtonFormField<Sport>(
                  value: sportSelezionato,
                  decoration: const InputDecoration(
                    labelText: "Sport",
                    border: OutlineInputBorder(),
                  ),
                  isExpanded: true,
                  hint: const Text('Tutti'),
                  items: [
                    const DropdownMenuItem<Sport>(value: null, child: Text('Tutti')),
                    ...sportDisponibili.map((sport) => DropdownMenuItem(
                      value: sport,
                      child: Text(sport.label),
                    )),
                  ],
                  onChanged: (val) => setState(() => sportSelezionato = val),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: widget.strutture.isNotEmpty
                    ? LatLng(widget.strutture.first.latitudine, widget.strutture.first.longitudine)
                    : const LatLng(41.9028, 12.4964),
                zoom: 10,
              ),
              onMapCreated: (controller) => _mapController = controller,
              myLocationEnabled: locationGranted,
              myLocationButtonEnabled: locationGranted,
              markers: struttureFiltrate.map((s) {
                return Marker(
                  markerId: MarkerId(s.id),
                  position: LatLng(s.latitudine, s.longitudine),
                  infoWindow: InfoWindow(title: s.nome, snippet: s.indirizzo),
                  onTap: () => widget.onStrutturaSelezionata(s),
                );
              }).toSet(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dropdownFiltro(String label, List<String> items, String? selected, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: selected,
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      isExpanded: true,
      hint: const Text('Tutte'),
      items: [
        const DropdownMenuItem<String>(value: null, child: Text('Tutte')),
        ...items.map((item) => DropdownMenuItem(value: item, child: Text(item)))
      ],
      onChanged: onChanged,
    );
  }
}
