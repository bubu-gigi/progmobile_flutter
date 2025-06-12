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
  final String initialNome;
  final String initialCognome;
  final String initialEmail;
  final String initialCodiceFiscale;
  final String? initialPassword;
  

  const UserForm({
    required this.title,
    required this.isLoading,
    required this.onSubmit,
    required this.onNomeChanged,
    required this.onCognomeChanged,
    required this.onEmailChanged,
    required this.onCodiceFiscaleChanged,
    required this.initialNome,
    required this.initialCognome,
    required this.initialEmail,
    required this.initialCodiceFiscale,
    this.initialPassword,
    this.onPasswordChanged,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final nomeController = TextEditingController(text: initialNome);
    final cognomeController = TextEditingController(text: initialCognome);
    final emailController = TextEditingController(text: initialEmail);
    final cfController = TextEditingController(text: initialCodiceFiscale);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: nomeController,
              onChanged: onNomeChanged,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: cognomeController,
              onChanged: onCognomeChanged,
              decoration: const InputDecoration(labelText: 'Cognome'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailController,
              onChanged: onEmailChanged,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: cfController,
              onChanged: onCodiceFiscaleChanged,
              decoration: const InputDecoration(labelText: 'Codice Fiscale'),
            ),
            const SizedBox(height: 12),
            if (onPasswordChanged != null)
              TextField(
                controller: TextEditingController(text: initialPassword ?? ''),
                onChanged: onPasswordChanged,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
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
