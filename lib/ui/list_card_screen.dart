import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/ui/add_card_screen.dart';
import '../viewmodels/carta_viewmodel.dart';

class CardListScreen extends ConsumerWidget {
  const CardListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(cardViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Le tue carte')),
      body: ListView.builder(
        itemCount: viewModel.cards.length,
        itemBuilder: (context, index) {
          final card = viewModel.cards[index];
          return ListTile(
            title: Text('**** **** **** ${card.number.substring(card.number.length - 4)}'),
            subtitle: Text(card.holder),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => ref.read(cardViewModelProvider).removeCard(index),
            ),
            onTap: () {
              // Selezione della carta (potresti salvare l'indice o navigare)
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Carta selezionata: ${card.number}')));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddCardScreen()));
        },
      ),
    );
  }
}
