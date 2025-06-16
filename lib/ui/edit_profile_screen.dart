import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/core/providers.dart';
import 'package:progmobile_flutter/ui/components/user_form.dart';
import 'package:progmobile_flutter/viewmodels/state/register_state.dart';

// Schermata per modificare il profilo utente
// Usiamo ConsumerWidget perché non serve stato locale (niente setState o controller qui)
class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Otteniamo lo stato attuale del form (con i dati: nome, email, ecc.)
    final state = ref.watch(editProfileViewModelProvider);

    // Otteniamo il ViewModel (cioè la classe che contiene le funzioni come submit, setNome...)
    final vm = ref.read(editProfileViewModelProvider.notifier);

    // Ascoltiamo i cambiamenti nello stato del form
    ref.listen<RegisterState>(editProfileViewModelProvider, (prev, next) {
      // Se il profilo è stato salvato con successo (success == true)
      // e prima non lo era → mostriamo un messaggio e torniamo indietro
      if (next.success && prev?.success != true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profilo aggiornato con successo')),
        );
        Navigator.pop(context); // Torniamo alla schermata precedente
      }

      // Se c'è un errore nuovo, lo mostriamo
      if (next.error != prev?.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error)),
        );
      }
    });

    // Costruiamo il form riutilizzabile, passando i dati e le funzioni
    return UserForm(
      title: 'Modifica il tuo profilo', // Titolo in alto e nel bottone
      isLoading: state.isLoading, // Se true → mostra lo spinner
      onSubmit: vm.submit, // Funzione chiamata quando si preme il bottone

      // Ogni campo ha il suo valore iniziale e la funzione che aggiorna il valore nel ViewModel
      onNomeChanged: vm.setNome,
      onCognomeChanged: vm.setCognome,
      onEmailChanged: vm.setEmail,
      onCodiceFiscaleChanged: vm.setCodiceFiscale,
      initialNome: state.nome,
      initialCognome: state.cognome,
      initialEmail: state.email,
      initialCodiceFiscale: state.codiceFiscale,

      // Campo password (opzionale)
      onPasswordChanged: vm.setPassword,
      initialPassword: state.password,
    );
  }
}
