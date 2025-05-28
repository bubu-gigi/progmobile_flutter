import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/card_viewmodel.dart';

class AddCardScreen extends ConsumerStatefulWidget {
  const AddCardScreen({super.key});

  @override
  ConsumerState<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends ConsumerState<AddCardScreen> {
  final _numberController = TextEditingController();
  final _holderController = TextEditingController();
  final _expiryController = TextEditingController(); // MM/AA
  final _cvvController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aggiungi carta')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _holderController,
                decoration: const InputDecoration(labelText: 'Nome intestatario'),
                validator: (value) => value == null || value.isEmpty ? 'Campo obbligatorio' : null,
              ),
              TextFormField(
                controller: _numberController,
                decoration: const InputDecoration(labelText: 'Numero carta'),
                keyboardType: TextInputType.number,
                maxLength: 16,
                validator: (value) =>
                value == null || value.length != 16 ? 'Numero non valido' : null,
              ),
              TextFormField(
                controller: _expiryController,
                decoration: const InputDecoration(labelText: 'Scadenza (MM/AA)'),
                keyboardType: TextInputType.datetime,
                maxLength: 5,
                validator: (value) {
                  if (value == null || !RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
                    return 'Formato MM/AA richiesto';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cvvController,
                decoration: const InputDecoration(labelText: 'CVV'),
                keyboardType: TextInputType.number,
                maxLength: 4,
                obscureText: true,
                validator: (value) =>
                value == null || value.length < 3 ? 'CVV non valido' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ref.read(cardViewModelProvider).addCard(
                      _numberController.text,
                      _holderController.text,
                      expiry: _expiryController.text,
                      cvv: _cvvController.text,
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Salva'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
