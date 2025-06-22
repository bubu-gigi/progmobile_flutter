import 'package:flutter/foundation.dart';
import '../data/collections/carta.dart';
import '../repositories/carta_repository.dart';
import '../data/collections/enums/card_provider.dart';
import '../core/user_session.dart';

class CardViewModel extends ChangeNotifier {
  final CartaRepository _repository;
  final _userSession = UserSessionManager().session;

  // Stato semplice
  List<Carta> carte = [];

  CardViewModel(this._repository) {
    _init();
  }

  Future<void> _init() async {
    final userId = _userSession?.userId;
    if (userId == null || userId.isEmpty) return;

    carte = await _repository.fetchCarteForUser(userId);
    notifyListeners();
  }

  Future<void> addCard(String number, String holder, String expiry, String cvv, CardProvider provider) async {
    final userId = _userSession?.userId;
    if (userId == null || userId.isEmpty) return;

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
      provider: provider,
    );

    final saved = await _repository.addCarta(carta);
    carte.add(saved);
    notifyListeners();
  }

  Future<void> removeCard(int index) async {
    final carta = carte[index];
    await _repository.removeCarta(carta.id);
    carte.removeAt(index);
    notifyListeners();
  }
}
