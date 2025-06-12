import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/collections/carta.dart';
import '../repositories/carta_repository.dart';
import '../data/collections/enums/card_provider.dart';

final cartaRepositoryProvider = Provider((ref) => CartaRepository());

final cartaViewModelProvider = StateNotifierProvider<CardViewModel, List<Carta>>(
      (ref) => CardViewModel(ref),
);

class CardViewModel extends StateNotifier<List<Carta>> {
  final Ref ref;
  late final CartaRepository _repository;

  CardViewModel(this.ref) : super([]) {
    _repository = ref.read(cartaRepositoryProvider);
    _init();
  }

  Future<void> _init() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
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
    final userId = FirebaseAuth.instance.currentUser?.uid;
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

    final savedCarta = await _repository.addCarta(carta);
    state = [...state, savedCarta];
  }

  Future<void> removeCard(int index) async {
    final removed = state[index];
    await _repository.removeCarta(removed.id);
    final updated = [...state]..removeAt(index);
    state = updated;
  }

  Future<Carta?> _trovaCartaInRepository(Carta card) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return null;
    final tutte = await _repository.fetchCarteForUser(userId);
    return tutte.firstWhere(
          (c) =>
      c.cardNumber == card.cardNumber &&
          c.cardHolderName == card.cardHolderName &&
          c.expirationMonth == card.expirationMonth &&
          c.expirationYear == card.expirationYear &&
          c.cvv == card.cvv,
    );
  }
}
