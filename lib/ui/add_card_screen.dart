import 'package:flutter/material.dart';
import 'package:progmobile_flutter/viewmodels/carta_viewmodel.dart';
import 'package:progmobile_flutter/core/user_session.dart';
import '../data/collections/enums/card_provider.dart';
import 'components/button.dart';
import 'components/dropdown.dart';
import 'components/text_field.dart';

class AddCardScreen extends StatefulWidget {
  final CardViewModel viewModel;

  const AddCardScreen({super.key, required this.viewModel});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
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

    _holderController = TextEditingController(text: userSession?.nameAndSurname);
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
      await widget.viewModel.addCard(
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
      appBar: AppBar(
        title: const Text('Aggiungi carta'),
        backgroundColor: const Color(0xFF232323),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFF232323),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextField(
                controller: _holderController,
                label: 'Nome intestatario',
                onChanged: (_) {},
                validator: (value) =>
                value == null || value.isEmpty ? 'Campo obbligatorio' : null,
              ),
              CustomTextField(
                controller: _numberController,
                label: 'Numero carta',
                keyboardType: TextInputType.number,
                maxLength: 16,
                onChanged: (_) {},
                validator: (value) =>
                value == null || value.length != 16 ? 'Numero non valido' : null,
              ),
              CustomTextField(
                controller: _expiryController,
                label: 'Scadenza (MM/AA)',
                keyboardType: TextInputType.datetime,
                maxLength: 5,
                onChanged: (_) {},
                validator: (value) {
                  if (value == null || !RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
                    return 'Formato MM/AA richiesto';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: _cvvController,
                label: 'CVV',
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 4,
                onChanged: (_) {},
                validator: (value) =>
                value == null || value.length < 3 ? 'CVV non valido' : null,
              ),
              CustomDropdown<CardProvider>(
                label: 'Tipo carta',
                value: _selectedProvider,
                items: CardProvider.values,
                labelBuilder: (p) => p.label,
                onChanged: (prov) => setState(() => _selectedProvider = prov),
                validator: (prov) => prov == null ? 'Seleziona tipo carta' : null,
              ),
              const SizedBox(height: 24),
              Button(
                label: 'Salva',
                onPressed: _onSubmit,
                isLoading: _isSaving,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
