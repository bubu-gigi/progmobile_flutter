import 'package:flutter/material.dart';
import 'package:progmobile_flutter/repositories/carta_repository.dart';
import 'package:progmobile_flutter/core/user_session.dart';
import 'package:progmobile_flutter/ui/add_card_screen.dart';
import 'package:progmobile_flutter/viewmodels/carta_viewmodel.dart';

class CardListScreen extends StatefulWidget {
  const CardListScreen({super.key});

  @override
  State<CardListScreen> createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  late final CardViewModel _viewModel;
  final userSession = UserSessionManager().session;

  @override
  void initState() {
    super.initState();
    _viewModel = CardViewModel(CartaRepository())
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _viewModel.removeListener(() {
      setState(() {});
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cards = _viewModel.carte;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Le tue carte'),
        backgroundColor: const Color(0xFF232323),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFF232323),
      body: cards.isEmpty
          ? const Center(
        child: Text(
          'Nessuna carta disponibile',
          style: TextStyle(fontSize: 16, color: Colors.white70),
        ),
      )
          : ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          final last4 = card.cardNumber.length >= 4
              ? card.cardNumber.substring(card.cardNumber.length - 4)
              : card.cardNumber;

          return Card(
            color: const Color(0xFF1E1E1E),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Color(0xFF6136FF), width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                '**** **** **** $last4',
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                '${card.cardHolderName} ${card.expirationMonth}/${card.expirationYear}',
                style: const TextStyle(color: Colors.white70),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: const Color(0xFF1E1E1E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: Color(0xFF6136FF), width: 2),
                      ),
                      title: const Text(
                        'Conferma eliminazione',
                        style: TextStyle(color: Colors.white),
                      ),
                      content: const Text(
                        'Sei sicuro di voler eliminare questa carta?',
                        style: TextStyle(color: Colors.white70),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(),
                          child: const Text('Annulla'),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.of(ctx).pop();
                            await _viewModel.removeCard(index);
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Carta rimossa')),
                              );
                            }
                          },
                          child: const Text('Conferma', style: TextStyle(color: Colors.redAccent)),
                        ),
                      ],
                    ),
                  );
                },
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Carta selezionata: **** **** **** $last4'),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6136FF),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddCardScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
