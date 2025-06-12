import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/ui/add_card_screen.dart';
import '../viewmodels/carta_viewmodel.dart';

class CardListScreen extends ConsumerWidget {
  const CardListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = ref.watch(cartaViewModelProvider);
    final viewModel = ref.read(cartaViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Le tue carte')),
      body: cards.isEmpty
          ? const Center(child: Text('Nessuna carta disponibile'))
          : ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          final last4 = card.cardNumber.length >= 4
              ? card.cardNumber.substring(card.cardNumber.length - 4)
              : card.cardNumber;

          return ListTile(
            title: Text('**** **** **** $last4'),
            subtitle: Text(card.cardHolderName),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => viewModel.removeCard(index),
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Carta selezionata: **** **** **** $last4')),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddCardScreen()),
          );
        },
      ),
    );
  }
}
