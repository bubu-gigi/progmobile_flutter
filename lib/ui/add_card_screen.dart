import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/core/providers.dart';

class AddCardScreen extends ConsumerStatefulWidget {
  const AddCardScreen({super.key});

  @override
  ConsumerState<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends ConsumerState<AddCardScreen> {
  final _numberController = TextEditingController();
  final _holderController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isSaving = false;

  @override
  void dispose() {
    _numberController.dispose();
    _holderController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      await ref.read(cartaViewModelProvider.notifier).addCard(
            _numberController.text.trim(),
            _holderController.text.trim(),
            expiry: _expiryController.text.trim(),
            cvv: _cvvController.text.trim(),
          );
      if (mounted) Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Errore salvataggio carta: $e')),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aggiungi carta')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _holderController,
                decoration: const InputDecoration(labelText: 'Nome intestatario'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo obbligatorio' : null,
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
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isSaving ? null : _onSubmit,
                child: _isSaving
                    ? const CircularProgressIndicator()
                    : const Text('Salva'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
