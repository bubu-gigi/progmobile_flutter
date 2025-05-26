// lib/view/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/login_viewmodel.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(loginViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              onChanged: ref.read(loginViewModelProvider.notifier).setEmail,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),
            TextField(
              onChanged: ref.read(loginViewModelProvider.notifier).setPassword,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            vm.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () => ref.read(loginViewModelProvider.notifier).login(),
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/register'),
              child: const Text("Don't have an account? Register"),
            ),
          ],
        ),
      ),
    );
  }
}
