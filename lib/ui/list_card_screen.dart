import 'package:flutter/material.dart';
import 'package:progmobile_flutter/repositories/carta_repository.dart';
import 'package:progmobile_flutter/ui/add_card_screen.dart';
import 'package:progmobile_flutter/viewmodels/carta_viewmodel.dart';

class CardListScreen extends StatefulWidget {
  const CardListScreen({super.key});

  @override
  State<CardListScreen> createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  late final CardViewModel _viewModel;
  String? _selectedCardId;

  @override
  void initState() {
    super.initState();
    _viewModel = CardViewModel(CartaRepository())
      ..addListener(() {
        setState(() {
          if (_selectedCardId == null) {
            final defaultCard = _viewModel.carte.where(
                  (c) => c.isDefault,
            );
            if(defaultCard != null) {
              _selectedCardId = defaultCard.first.id;
            }
          }
        });
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
          : ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Per selezionare una carta per i pagamenti devi cliccarci sopra e si evidenzierà',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 12),
          ...cards.map((card) {
            final last4 = card.cardNumber.length >= 4
                ? card.cardNumber.substring(card.cardNumber.length - 4)
                : card.cardNumber;
            final isSelected = _selectedCardId == card.id;

            return Card(
              color: isSelected ? const Color(0xFF6136FF) : const Color(0xFF1E1E1E),
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: isSelected ? Colors.white : const Color(0xFF6136FF),
                  width: 2,
                ),
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
                              await _viewModel.removeCard(cards.indexOf(card));
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
                  setState(() {
                    _selectedCardId = card.id;
                  });
                   _viewModel.selezionaCarta(card.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Carta selezionata: **** **** **** $last4'),
                    ),
                  );
                },
              ),
            );
          }).toList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6136FF),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddCardScreen(viewModel: _viewModel),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
