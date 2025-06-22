import 'package:progmobile_flutter/data/collections/struttura.dart';

class StruttureState {
  final List<Struttura> strutture;
  final bool isLoading;

  const StruttureState({this.strutture = const [], this.isLoading = false});

  StruttureState copyWith({List<Struttura>? strutture, bool? isLoading}) {
    return StruttureState(
      strutture: strutture ?? this.strutture,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
