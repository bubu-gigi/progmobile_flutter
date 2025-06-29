import 'package:flutter/material.dart';
import 'package:progmobile_flutter/ui/components/text_field.dart';

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
              CustomTextField(
                controller: nomeController,
                label: 'Nome',
                onChanged: onNomeChanged,
              ),
              CustomTextField(
                controller: cognomeController,
                label: 'Cognome',
                onChanged: onCognomeChanged,
              ),
              CustomTextField(
                controller: emailController,
                label: 'Email',
                onChanged: onEmailChanged,
                keyboardType: TextInputType.emailAddress,
              ),
              CustomTextField(
                controller: cfController,
                label: 'Codice Fiscale',
                onChanged: onCodiceFiscaleChanged,
              ),
              if (onPasswordChanged != null && passwordController != null)
                CustomTextField(
                  controller: passwordController!,
                  label: 'Password',
                  onChanged: onPasswordChanged!,
                  obscureText: true,
                ),
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
}
