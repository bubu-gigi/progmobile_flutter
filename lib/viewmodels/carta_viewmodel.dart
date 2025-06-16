import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/core/providers.dart';
import '../data/collections/carta.dart';
import '../repositories/carta_repository.dart';
import '../data/collections/enums/card_provider.dart';

class CardViewModel extends Notifier<List<Carta>> {
  late final CartaRepository _repository;

  @override
  List<Carta> build() {
    _repository = ref.read(cartaRepositoryProvider);
    _init();
    return [];
  }

  Future<void> _init() async {
    final userId = _getUserId();
    if (userId == null) return;
    final carte = await _repository.fetchCarteForUser(userId);
    state = carte;
  }

  Future<void> addCard(
    String number,
    String holder, {
    required String expiry,
    required String cvv,
  }) async {
    final userId = _getUserId();
    if (userId == null) return;

    final match = RegExp(r'^(\d{2})/(\d{2})$').firstMatch(expiry);
    if (match == null) return;

    final month = int.tryParse(match.group(1)!);
    final year = int.tryParse('20${match.group(2)}');

    if (month == null || year == null) return;

    final carta = Carta(
      id: '',
      userId: userId,
      cardHolderName: holder,
      cardNumber: number,
      expirationMonth: month,
      expirationYear: year,
      cvv: cvv,
      provider: CardProvider.VISA,
    );

    final saved = await _repository.addCarta(carta);
    state = [...state, saved];
  }

  Future<void> removeCard(int index) async {
    final carta = state[index];
    await _repository.removeCarta(carta.id);
    state = [...state]..removeAt(index);
  }

  String? _getUserId() {
    final session = ref.read(userSessionProvider);
     if (session == null || session.userId.isEmpty) {
      throw StateError("User ID non disponibile nella sessione utente.");
    }
    return session.userId;
  }
}
