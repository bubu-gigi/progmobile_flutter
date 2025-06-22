import 'package:flutter/material.dart';
import 'package:progmobile_flutter/ui/components/user_form.dart';
import 'package:progmobile_flutter/viewmodels/edit_profile_viewmodel.dart';

class EditProfileScreen extends StatefulWidget {

  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}
class _EditProfileScreenState extends State<EditProfileScreen> {
  final viewModel = EditProfileViewModel();

  late final TextEditingController nomeController;
  late final TextEditingController cognomeController;
  late final TextEditingController emailController;
  late final TextEditingController cfController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();

    // 🆕 Inizializzo i controller inizialmente vuoti
    nomeController = TextEditingController();
    cognomeController = TextEditingController();
    emailController = TextEditingController();
    cfController = TextEditingController();
    passwordController = TextEditingController();

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
        // 🆕 Aggiorniamo i controller quando cambia la viewModel
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
    return UserForm(
      title: 'Modifica il tuo profilo',
      isLoading: viewModel.isLoading,
      onSubmit: viewModel.submit,
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
    );
  }
}
