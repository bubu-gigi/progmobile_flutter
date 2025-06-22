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
  @override
  void initState() {
    super.initState();
    viewModel.addListener(_onStateChanged);
  }

  @override
  void dispose() {
    viewModel.removeListener(_onStateChanged);
    super.dispose();
  }

  void _onStateChanged() {
    if (mounted) setState(() {});

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
      initialNome: viewModel.nome,
      initialCognome: viewModel.cognome,
      initialEmail: viewModel.email,
      initialCodiceFiscale: viewModel.codiceFiscale,
      initialPassword: viewModel.password,
    );
  }
}
