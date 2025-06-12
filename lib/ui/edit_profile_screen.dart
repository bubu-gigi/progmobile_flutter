import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/ui/components/user_form.dart';
import 'package:progmobile_flutter/viewmodels/state/register_state.dart';
import 'package:progmobile_flutter/viewmodels/edit_profile_viewmodel.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(editProfileViewModelProvider);
    final notifier = ref.read(editProfileViewModelProvider.notifier);

    ref.listen<RegisterState>(editProfileViewModelProvider, (prev, next) {
      if (next.success && prev?.success != true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profilo aggiornato con successo')),
        );
        Navigator.pop(context);
      }

      if (prev?.error != next.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore: ${next.error}')),
        );
      }
    });

    return UserForm(
      title: 'Modifica il tuo profilo',
      isLoading: vm.isLoading,
      onSubmit: notifier.submit,
      onNomeChanged: notifier.setNome,
      onCognomeChanged: notifier.setCognome,
      onEmailChanged: notifier.setEmail,
      onCodiceFiscaleChanged: notifier.setCodiceFiscale,
      initialNome: vm.nome,
      initialCognome: vm.cognome,
      initialEmail: vm.email,
      initialCodiceFiscale: vm.codiceFiscale,
      onPasswordChanged: notifier.setPassword,
      initialPassword: vm.password,
    );
  }
}
