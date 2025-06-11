import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartaViewModelProvider = ChangeNotifierProvider((ref) => CardViewModel());

class PaymentCard {
  final String number;
  final String holder;
  final String expiry;
  final String cvv;

  PaymentCard({
    required this.number,
    required this.holder,
    required this.expiry,
    required this.cvv,
  });
}

class CardViewModel extends ChangeNotifier {
  final List<PaymentCard> _cards = [];

  List<PaymentCard> get cards => _cards;

  void addCard(String number, String holder, {required String expiry, required String cvv}) {
    _cards.add(PaymentCard(
      number: number,
      holder: holder,
      expiry: expiry,
      cvv: cvv,
    ));
    notifyListeners();
  }

  void removeCard(int index) {
    _cards.removeAt(index);
    notifyListeners();
  }
}
