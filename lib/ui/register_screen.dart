import 'package:flutter/material.dart';
import 'package:progmobile_flutter/core/routes.dart';
import 'package:progmobile_flutter/repositories/user_repository.dart';
import 'package:progmobile_flutter/ui/components/user_form.dart';
import 'package:progmobile_flutter/viewmodels/register_viewmodel.dart';

import '../core/helpers.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final RegisterViewModel _viewModel;

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nomeController;
  late final TextEditingController cognomeController;
  late final TextEditingController emailController;
  late final TextEditingController cfController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();

    _viewModel = RegisterViewModel(UserRepository());
    _viewModel.addListener(_onStateChanged);

    nomeController = TextEditingController();
    cognomeController = TextEditingController();
    emailController = TextEditingController();
    cfController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onStateChanged);
    nomeController.dispose();
    cognomeController.dispose();
    emailController.dispose();
    cfController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onStateChanged() {
    if (_viewModel.success) {
      Navigator.pushReplacementNamed(context, AppRoutes.homeGiocatore);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: UserForm(
        title: 'Registrati',
        isLoading: _viewModel.isLoading,
        onSubmit: () {
          if (_formKey.currentState!.validate()) {
            _viewModel.register();
          }
        },
        onNomeChanged: _viewModel.setNome,
        onCognomeChanged: _viewModel.setCognome,
        onEmailChanged: _viewModel.setEmail,
        onCodiceFiscaleChanged: _viewModel.setCodiceFiscale,
        onPasswordChanged: _viewModel.setPassword,
        nomeController: nomeController,
        cognomeController: cognomeController,
        emailController: emailController,
        cfController: cfController,
        passwordController: passwordController,
        nomeValidator: validateNome,
        cognomeValidator: validateCognome,
        emailValidator: validateEmail,
        cfValidator: validateCodiceFiscale,
        passwordValidator: validatePassword,
      ),
    );
  }
}
