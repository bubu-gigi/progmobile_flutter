import 'package:flutter/material.dart';
import 'package:progmobile_flutter/core/routes.dart';
import 'package:progmobile_flutter/repositories/user_repository.dart';
import 'package:progmobile_flutter/ui/components/user_form.dart';
import 'package:progmobile_flutter/viewmodels/register_viewmodel.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final RegisterViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = RegisterViewModel(UserRepository());
    _viewModel.addListener(_onStateChanged);
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onStateChanged);
    super.dispose();
  }

  void _onStateChanged() {
    if (_viewModel.success) {
      Navigator.pushReplacementNamed(context, AppRoutes.homeGiocatore);
    }

    if (_viewModel.error.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_viewModel.error)),
      );
    }

    setState(() {}); // Aggiorna l’interfaccia quando cambia qualcosa
  }

  @override
  Widget build(BuildContext context) {
    return UserForm(
      title: 'Registrati',
      isLoading: _viewModel.isLoading,
      onSubmit: _viewModel.register,
      onNomeChanged: _viewModel.setNome,
      onCognomeChanged: _viewModel.setCognome,
      onEmailChanged: _viewModel.setEmail,
      onCodiceFiscaleChanged: _viewModel.setCodiceFiscale,
      onPasswordChanged: _viewModel.setPassword,
      initialNome: _viewModel.nome,
      initialCognome: _viewModel.cognome,
      initialEmail: _viewModel.email,
      initialCodiceFiscale: _viewModel.codiceFiscale,
    );
  }
}
