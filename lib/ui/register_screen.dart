import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/core/providers.dart';
import 'package:progmobile_flutter/core/routes.dart';
import 'package:progmobile_flutter/ui/components/user_form.dart';
import 'package:progmobile_flutter/viewmodels/state/register_state.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerState = ref.watch(registerViewModelProvider);
    final vm = ref.read(registerViewModelProvider.notifier);

    ref.listen<RegisterState>(registerViewModelProvider, (prev, next) {
      if (next.success && prev?.success != true) {
        Navigator.pushReplacementNamed(context, AppRoutes.homeGiocatore);
      }
    });

    return UserForm(
      title: 'Registrati',
      isLoading: registerState.isLoading,
      onSubmit: vm.register,
      onNomeChanged: vm.setNome,
      onCognomeChanged: vm.setCognome,
      onEmailChanged: vm.setEmail,
      onCodiceFiscaleChanged: vm.setCodiceFiscale,
      onPasswordChanged: vm.setPassword,
      initialNome: '',
      initialCognome: '',
      initialEmail: '',
      initialCodiceFiscale: '',
    );
  }
}
