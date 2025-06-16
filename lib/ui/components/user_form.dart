import 'package:flutter/material.dart';

class UserForm extends StatefulWidget {
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
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  late final TextEditingController nomeController;
  late final TextEditingController cognomeController;
  late final TextEditingController emailController;
  late final TextEditingController cfController;
  TextEditingController? passwordController;

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController(text: widget.initialNome);
    cognomeController = TextEditingController(text: widget.initialCognome);
    emailController = TextEditingController(text: widget.initialEmail);
    cfController = TextEditingController(text: widget.initialCodiceFiscale);

    if (widget.onPasswordChanged != null) {
      passwordController = TextEditingController(text: widget.initialPassword ?? '');
    }
  }

  @override
  void dispose() {
    nomeController.dispose();
    cognomeController.dispose();
    emailController.dispose();
    cfController.dispose();
    passwordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: nomeController,
              onChanged: widget.onNomeChanged,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: cognomeController,
              onChanged: widget.onCognomeChanged,
              decoration: const InputDecoration(labelText: 'Cognome'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailController,
              onChanged: widget.onEmailChanged,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: cfController,
              onChanged: widget.onCodiceFiscaleChanged,
              decoration: const InputDecoration(labelText: 'Codice Fiscale'),
            ),
            const SizedBox(height: 12),
            if (widget.onPasswordChanged != null && passwordController != null)
              TextField(
                controller: passwordController,
                onChanged: widget.onPasswordChanged,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            const SizedBox(height: 24),
            widget.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: widget.onSubmit,
                    child: Text(widget.title),
                  ),
          ],
        ),
      ),
    );
  }
}
