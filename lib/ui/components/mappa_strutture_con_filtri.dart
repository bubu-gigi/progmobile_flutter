import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progmobile_flutter/data/collections/enums/sport.dart';
import 'package:progmobile_flutter/data/collections/struttura.dart';

import 'dropdown.dart';

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
      color: const Color(0xFF232323),
      child: Column(
        children: [
          Theme(
            data: Theme.of(context).copyWith(
              canvasColor: const Color(0xFF232323),
              inputDecorationTheme: InputDecorationTheme(
                labelStyle: const TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Color(0xFF6136FF), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Color(0xFF6136FF), width: 2),
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: CustomDropdown<String>(
                    label: 'Città',
                    value: cittaSelezionata,
                    items: cittaPrincipali,
                    labelBuilder: (c) => c,
                    onChanged: (val) => setState(() => cittaSelezionata = val),
                  )
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CustomDropdown<Sport>(
                    label: 'Sport',
                    value: sportSelezionato,
                    items: sportDisponibili,
                    labelBuilder: (s) => s.label,
                    onChanged: (val) => setState(() => sportSelezionato = val),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
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
          ),
        ],
      ),
    );
  }
}
