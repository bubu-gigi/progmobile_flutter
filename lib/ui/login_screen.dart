import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/core/providers.dart';
import 'package:progmobile_flutter/core/routes.dart';
import 'package:progmobile_flutter/viewmodels/state/login_state.dart';

// Schermata di login per l'utente (giocatore)
// Estende ConsumerWidget per usare Riverpod (ref.watch, ref.read, ref.listen)
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Stato attuale del form di login (contiene isLoading, error, success)
    final state = ref.watch(loginViewModelProvider);

    // ViewModel per chiamare i metodi tipo setEmail, setPassword, login
    final vm = ref.read(loginViewModelProvider.notifier);

    // Ascoltiamo i cambiamenti di stato per fare navigazione o mostrare errori
    ref.listen<LoginState>(loginViewModelProvider, (prev, next) {
      // Se il login ha avuto successo (success == true), navighiamo alla home
      if (next.success && prev?.success != true) {
        Navigator.pushReplacementNamed(context, AppRoutes.homeGiocatore);
      }

      // Se c'è un errore nuovo, lo mostriamo con uno SnackBar
      else if (next.error != null && next.error != prev?.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),

      // Padding attorno al form
      body: Padding(
        padding: const EdgeInsets.all(16),

        // Colonna centrata verticalmente con i campi e i bottoni
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Campo email
            TextField(
              onChanged: vm.setEmail, // aggiorna lo stato nel ViewModel
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 16),

            // Campo password
            TextField(
              onChanged: vm.setPassword, // aggiorna lo stato nel ViewModel
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true, // nasconde i caratteri digitati
            ),

            const SizedBox(height: 24),

            // Se è in caricamento, mostra spinner
            state.isLoading
                ? const CircularProgressIndicator()

                // Altrimenti mostra il bottone di login
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: vm.login, // chiama la funzione login del ViewModel
                      child: const Text('Login'),
                    ),
                  ),

            const SizedBox(height: 12),

            // Link per andare alla schermata di registrazione
            TextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.register),
              child: const Text("Non hai un account? Registrati"),
            ),
          ],
        ),
      ),
    );
  }
}
