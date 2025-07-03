import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;

class GoogleAutocompleteField extends StatefulWidget {
  final ValueChanged<String> onAddressSelected;
  final ValueChanged<String> onCitySelected;
  final ValueChanged<gmaps.LatLng> onLatLngSelected;

  const GoogleAutocompleteField({
    super.key,
    required this.onAddressSelected,
    required this.onCitySelected,
    required this.onLatLngSelected,
  });

  @override
  State<GoogleAutocompleteField> createState() => _GoogleAutocompleteFieldState();
}

class _GoogleAutocompleteFieldState extends State<GoogleAutocompleteField> {
  final _controller = TextEditingController();
  final _places = FlutterGooglePlacesSdk('AIzaSyBG5dhb3WhErCUEPCNloC4QLQP9x3vw6Mg');

  Future<void> _searchAddress(String input) async {
    if (input.length < 3) return;

    final resp = await _places.findAutocompletePredictions(
      input,
      countries: ['it'],
      placeTypesFilter: [PlaceTypeFilter.ADDRESS],
    );

    if (resp.predictions.isEmpty) return;

    final firstSuggestion = resp.predictions.first;
    final placeId = firstSuggestion.placeId;
    if (placeId == null) return;

    final details = await _places.fetchPlace(
      placeId,
      fields: [PlaceField.Location, PlaceField.Name],
    );

    final lat = details.place?.latLng?.lat;
    final lng = details.place?.latLng?.lng;

    if (lat != null && lng != null) {
      widget.onAddressSelected(firstSuggestion.fullText);

      final placemarks = await placemarkFromCoordinates(
        lat,
        lng,
        localeIdentifier: 'it_IT',
      );

      final city = placemarks.first.locality ?? '';
      widget.onCitySelected(city);

      widget.onLatLngSelected(gmaps.LatLng(lat, lng));
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: const InputDecoration(
        labelText: 'Cerca indirizzo',
        border: OutlineInputBorder(),
      ),
      onChanged: _searchAddress,
    );
  }
}
