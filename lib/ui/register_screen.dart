import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/core/routes.dart';
import 'package:progmobile_flutter/ui/components/user_form.dart';
import 'package:progmobile_flutter/viewmodels/state/register_state.dart';
import 'package:progmobile_flutter/viewmodels/register_viewmodel.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(registerViewModelProvider);
    final notifier = ref.read(registerViewModelProvider.notifier);

    ref.listen<RegisterState>(registerViewModelProvider, (prev, next) {
      if (next.success && prev?.success != true) {
        Navigator.pushReplacementNamed(context, AppRoutes.homeGiocatore);
      }
    });

    return UserForm(
      title: 'Registrati',
      isLoading: vm.isLoading,
      onSubmit: notifier.register,
      onNomeChanged: notifier.setNome,
      onCognomeChanged: notifier.setCognome,
      onEmailChanged: notifier.setEmail,
      onCodiceFiscaleChanged: notifier.setCodiceFiscale,
      onPasswordChanged: notifier.setPassword,
      initialNome:'',
      initialCognome: '',
      initialEmail: '',
      initialCodiceFiscale: '',
    );
  }
}
