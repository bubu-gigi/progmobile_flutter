import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/core/providers.dart';
import 'package:progmobile_flutter/ui/components/user_form.dart';
import 'package:progmobile_flutter/viewmodels/state/register_state.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(editProfileViewModelProvider);
    final vm = ref.read(editProfileViewModelProvider.notifier);

    ref.listen<RegisterState>(editProfileViewModelProvider, (prev, next) {
      if (next.success && prev?.success != true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profilo aggiornato con successo')),
        );
        Navigator.pop(context);
      }

      if (next.error != null && next.error != prev?.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }
    });

    return UserForm(
      title: 'Modifica il tuo profilo',
      isLoading: state.isLoading,
      onSubmit: vm.submit,
      onNomeChanged: vm.setNome,
      onCognomeChanged: vm.setCognome,
      onEmailChanged: vm.setEmail,
      onCodiceFiscaleChanged: vm.setCodiceFiscale,
      initialNome: state.nome,
      initialCognome: state.cognome,
      initialEmail: state.email,
      initialCodiceFiscale: state.codiceFiscale,
      onPasswordChanged: vm.setPassword,
      initialPassword: state.password,
    );
  }
}
