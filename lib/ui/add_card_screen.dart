import 'package:flutter/material.dart';
import 'package:progmobile_flutter/repositories/carta_repository.dart';
import 'package:progmobile_flutter/viewmodels/carta_viewmodel.dart';
import 'package:progmobile_flutter/core/user_session.dart';
import '../data/collections/enums/card_provider.dart';
import 'components/button.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  late final CardViewModel _viewModel;
  final userSession = UserSessionManager().session;

  late final TextEditingController _holderController;
  late final TextEditingController _numberController;
  late final TextEditingController _expiryController;
  late final TextEditingController _cvvController;

  CardProvider? _selectedProvider;

  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _viewModel = CardViewModel(
      CartaRepository(),
    );

    _holderController = TextEditingController(
      text: userSession?.nameAndSurname,
    );

    _numberController = TextEditingController();
    _expiryController = TextEditingController();
    _cvvController = TextEditingController();
  }

  @override
  void dispose() {
    _numberController.dispose();
    _holderController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate() || _selectedProvider == null) return;

    setState(() => _isSaving = true);

    try {
      await _viewModel.addCard(
        _numberController.text.trim(),
        _holderController.text.trim(),
        _expiryController.text.trim(),
        _cvvController.text.trim(),
        _selectedProvider!,
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
              const SizedBox(height: 12),
              TextFormField(
                controller: _numberController,
                decoration: const InputDecoration(labelText: 'Numero carta'),
                keyboardType: TextInputType.number,
                maxLength: 16,
                validator: (value) =>
                value == null || value.length != 16 ? 'Numero non valido' : null,
              ),
              const SizedBox(height: 12),
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
              const SizedBox(height: 12),
              TextFormField(
                controller: _cvvController,
                decoration: const InputDecoration(labelText: 'CVV'),
                keyboardType: TextInputType.number,
                maxLength: 4,
                obscureText: true,
                validator: (value) =>
                value == null || value.length < 3 ? 'CVV non valido' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<CardProvider>(
                value: _selectedProvider,
                decoration: const InputDecoration(
                  labelText: 'Tipo carta',
                  border: OutlineInputBorder(),
                ),
                items: CardProvider.values.map((prov) {
                  return DropdownMenuItem(
                    value: prov,
                    child: Text(prov.label),
                  );
                }).toList(),
                onChanged: (prov) => setState(() => _selectedProvider = prov),
                validator: (prov) => prov == null ? 'Seleziona tipo carta' : null,
              ),
              const SizedBox(height: 24),
              Button(
                label: 'Salva',
                onPressed: _onSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
