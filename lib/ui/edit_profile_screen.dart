import 'package:flutter/material.dart';
import 'package:progmobile_flutter/ui/components/user_form.dart';
import 'package:progmobile_flutter/viewmodels/edit_profile_viewmodel.dart';

import '../core/helpers.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final viewModel = EditProfileViewModel();

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nomeController;
  late final TextEditingController cognomeController;
  late final TextEditingController emailController;
  late final TextEditingController cfController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();

    nomeController = TextEditingController(text: viewModel.nome);
    cognomeController = TextEditingController(text: viewModel.cognome);
    emailController = TextEditingController(text: viewModel.email);
    cfController = TextEditingController(text: viewModel.codiceFiscale);
    passwordController = TextEditingController(text: viewModel.password);

    viewModel.addListener(_onStateChanged);
  }

  @override
  void dispose() {
    viewModel.removeListener(_onStateChanged);
    nomeController.dispose();
    cognomeController.dispose();
    emailController.dispose();
    cfController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onStateChanged() {
    if (mounted) {
      setState(() {
        nomeController.text = viewModel.nome;
        cognomeController.text = viewModel.cognome;
        emailController.text = viewModel.email;
        cfController.text = viewModel.codiceFiscale;
        passwordController.text = viewModel.password;
      });
    }

    if (viewModel.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profilo aggiornato con successo')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image1/sfondo3.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _formKey,
          child: UserForm(
            title: 'Modifica il tuo profilo',
            isLoading: viewModel.isLoading,
            onSubmit: () {
              if (_formKey.currentState!.validate()) {
                viewModel.submit();
              }
            },
            onNomeChanged: viewModel.setNome,
            onCognomeChanged: viewModel.setCognome,
            onEmailChanged: viewModel.setEmail,
            onCodiceFiscaleChanged: viewModel.setCodiceFiscale,
            onPasswordChanged: viewModel.setPassword,
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
        ),
      ),
    );
  }
}
