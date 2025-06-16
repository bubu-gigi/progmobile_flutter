import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/core/providers.dart';

// Usiamo ConsumerStatefulWidget per combinare lo stato locale (setState, controller...)
// con la possibilità di accedere ai provider tramite ref (Riverpod)
class AddCardScreen extends ConsumerStatefulWidget {
  //ottimiziamo flutter con questa cosa
  const AddCardScreen({super.key});

  //aggiungiamo il nostro stato a questo widget 
  @override
  ConsumerState<AddCardScreen> createState() => _AddCardScreenState();
}

//la classe che gestisce il nostro stato e ci aggianciamo lo screen
class _AddCardScreenState extends ConsumerState<AddCardScreen> {
  //controllers che gestiscono la validazione del form
  final _numberController = TextEditingController();
  final _holderController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  // Chiave per identificare il Form e validarlo (formKey.currentState!.validate())
  final _formKey = GlobalKey<FormState>();
  //operazioni asincrone gestisce il salvataggio -> spinner possiamo inserirli
  bool _isSaving = false;
  // alla distruzione/ricostruzione del widget resetta tutti i controller e libera memoria
  @override
  void dispose() {
    _numberController.dispose();
    _holderController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }
  //funzione che gestisce il salvataggio
  Future<void> _onSubmit() async {
    //validiamo prima la form
    if (!_formKey.currentState!.validate()) return;
    //siamo in salvataggio -> bloccheremo il bottone
    setState(() => _isSaving = true);
    //ovviamente try-catch per gestire il tutto
    try {
      // ref.read(...).notifier ci restituisce l'istanza del ViewModel (CartaViewModel)
      // da cui possiamo chiamare i metodi come addCard. read = lettura non reattiva
      await ref.read(cartaViewModelProvider.notifier).addCard(
            _numberController.text.trim(),
            _holderController.text.trim(),
            expiry: _expiryController.text.trim(),
            cvv: _cvvController.text.trim(),
          );
          //mounted dice se il widget è ancora visibile
      if (mounted) Navigator.pop(context);
    } catch (e) {
    // context rappresenta il punto nell'albero dei widget. Serve per accedere a Navigator, Theme, SnackBar, ecc.
    // mounted = true se il widget è ancora attivo. Evita errori quando usi setState dopo un'operazione async.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Errore salvataggio carta: $e')),
      );
      //in qualsiasi caso resettiamo _isSavig a false
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
