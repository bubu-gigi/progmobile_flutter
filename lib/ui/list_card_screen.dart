import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/core/providers.dart';
import 'package:progmobile_flutter/ui/add_card_screen.dart';

// Schermata che mostra l'elenco delle carte dell'utente
// Usiamo ConsumerWidget per leggere i dati dal provider
class CardListScreen extends ConsumerWidget {
  const CardListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Otteniamo la lista delle carte salvate (dallo stato del ViewModel)
    final cards = ref.watch(cartaViewModelProvider);

    // Otteniamo il ViewModel per chiamare le funzioni (es. removeCard)
    final viewModel = ref.read(cartaViewModelProvider.notifier);

    return Scaffold(
      // Barra in alto con titolo
      appBar: AppBar(title: const Text('Le tue carte')),

      // Corpo della schermata: se la lista è vuota, mostra un messaggio
      body: cards.isEmpty
          ? const Center(
              child: Text(
                'Nessuna carta disponibile',
                style: TextStyle(fontSize: 16),
              ),
            )

          // Altrimenti mostra la lista delle carte
          : ListView.builder(
              itemCount: cards.length,
              itemBuilder: (context, index) {
                final card = cards[index];

                // Prendiamo le ultime 4 cifre del numero carta da mostrare
                final last4 = card.cardNumber.length >= 4
                    ? card.cardNumber.substring(card.cardNumber.length - 4)
                    : card.cardNumber;

                // Ogni carta viene mostrata come una "Card" grafica con info e bottone delete
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text('**** **** **** $last4'), // Mostra solo le ultime 4 cifre
                    subtitle: Text(card.cardHolderName), // Nome dell'intestatario
                    trailing: IconButton(
                      icon: const Icon(Icons.delete), // Icona per eliminare
                      onPressed: () async {
                        // Rimuove la carta dalla lista usando il ViewModel
                        await viewModel.removeCard(index);

                        // Mostra un messaggio di conferma
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Carta rimossa')),
                        );
                      },
                    ),
                    onTap: () {
                      // Quando tocchi la carta, mostra un messaggio (può diventare un dettaglio)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Carta selezionata: **** **** **** $last4')),
                      );
                    },
                  ),
                );
              },
            ),

      // Bottone "più" in basso a destra per aggiungere una nuova carta
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Naviga alla schermata per aggiungere una nuova carta
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddCardScreen()),
          );
        },
      ),
    );
  }
}
