import 'package:flutter/material.dart';

import 'button.dart';

class UserForm extends StatelessWidget {
  final String title;
  final bool isLoading;
  final void Function() onSubmit;
  final void Function(String) onNomeChanged;
  final void Function(String) onCognomeChanged;
  final void Function(String) onEmailChanged;
  final void Function(String) onCodiceFiscaleChanged;
  final void Function(String)? onPasswordChanged;

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
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF232323),
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: const Color(0xFF232323),
        child: Padding(
          padding: const EdgeInsets.all(26),
          child: ListView(
            children: [
              const SizedBox(height: 14),
              _buildTextField(nomeController, 'Nome', onNomeChanged),
              _buildTextField(cognomeController, 'Cognome', onCognomeChanged),
              _buildTextField(emailController, 'Email', onEmailChanged,
                  keyboardType: TextInputType.emailAddress),
              _buildTextField(cfController, 'Codice Fiscale', onCodiceFiscaleChanged),
              if (onPasswordChanged != null && passwordController != null)
                _buildTextField(passwordController!, 'Password', onPasswordChanged!, obscureText: true),
              const SizedBox(height: 54),
              Button(
                label: title,
                onPressed: onSubmit,
                isLoading: isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String label,
      Function(String) onChanged, {
        TextInputType? keyboardType,
        bool obscureText = false,
      }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF6136FF)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
      ),
    );
  }
}
