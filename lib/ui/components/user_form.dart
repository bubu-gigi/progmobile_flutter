import 'package:flutter/material.dart';

class UserForm extends StatelessWidget {
  final String title;
  final bool isLoading;
  final void Function() onSubmit;
  final void Function(String) onNomeChanged;
  final void Function(String) onCognomeChanged;
  final void Function(String) onEmailChanged;
  final void Function(String) onCodiceFiscaleChanged;
  final void Function(String)? onPasswordChanged;

  // 🆕 Aggiungiamo i controller come parametri
  final TextEditingController nomeController;
  final TextEditingController cognomeController;
  final TextEditingController emailController;
  final TextEditingController cfController;
  final TextEditingController? passwordController;

  const UserForm({
    super.key,
    required this.title,
    required this.isLoading,
    required this.onSubmit,
    required this.onNomeChanged,
    required this.onCognomeChanged,
    required this.onEmailChanged,
    required this.onCodiceFiscaleChanged,
    this.onPasswordChanged,
    required this.nomeController,
    required this.cognomeController,
    required this.emailController,
    required this.cfController,
    this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextFormField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
              onChanged: onNomeChanged,
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: cognomeController,
              decoration: const InputDecoration(labelText: 'Cognome'),
              onChanged: onCognomeChanged,
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              onChanged: onEmailChanged,
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: cfController,
              decoration: const InputDecoration(labelText: 'Codice Fiscale'),
              onChanged: onCodiceFiscaleChanged,
            ),
            const SizedBox(height: 12),

            if (onPasswordChanged != null && passwordController != null)
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                onChanged: onPasswordChanged,
              ),
            const SizedBox(height: 24),

            isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
              onPressed: onSubmit,
              child: Text(title),
            ),
          ],
        ),
      ),
    );
  }
}
