import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/core/routes.dart';
import 'package:progmobile_flutter/viewmodels/state/register_state.dart';
import '../viewmodels/register_viewmodel.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(registerViewModelProvider);
    final notifier = ref.read(registerViewModelProvider.notifier);

     ref.listen<RegisterState>(registerViewModelProvider, (prev, next) {
        if (next.success && prev?.success != true) {
          Navigator.pushReplacementNamed(context, AppRoutes.homeGiocatore);
        }
      });

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              onChanged: notifier.setNome,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            const SizedBox(height: 12),
            TextField(
              onChanged: notifier.setCognome,
              decoration: const InputDecoration(labelText: 'Cognome'),
            ),
            const SizedBox(height: 12),
            TextField(
              onChanged: notifier.setEmail,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),
            TextField(
              onChanged: notifier.setCodiceFiscale,
              decoration: const InputDecoration(labelText: 'Codice Fiscale'),
            ),
            const SizedBox(height: 12),
            TextField(
              onChanged: notifier.setPassword,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
              onPressed: notifier.register,
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
