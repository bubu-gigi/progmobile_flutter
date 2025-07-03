import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:progmobile_flutter/core/routes.dart';

import '../core/user_session.dart';
import '../viewmodels/login_viewmodel.dart';
import 'components/button.dart';

class HomeGiocatoreScreen extends StatelessWidget {
  const HomeGiocatoreScreen({super.key});

  void _logout(BuildContext context) {
    UserSessionManager().clear();
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  Future<void> _confermaEliminazione(BuildContext context) async {
    final confermato = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Conferma eliminazione'),
        content: const Text('Sei sicuro di voler eliminare il tuo account? L’azione è irreversibile.'),
        actions: [
          TextButton(
            child: const Text('Annulla'),
            onPressed: () => Navigator.of(ctx).pop(false),
          ),
          TextButton(
            child: const Text('Elimina', style: TextStyle(color: Colors.red)),
            onPressed: () => Navigator.of(ctx).pop(true),
          ),
        ],
      ),
    );

    if (confermato == true) {
      final vm = Provider.of<LoginViewModel>(context, listen: false);
      await vm.eliminaAccountCorrente();
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Benvenuto Giocatore'),
        backgroundColor: const Color(0xFF232323),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image1/sfondi4.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 410),
              const Text(
                'BENVENUTO!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              Button(
                label: 'Gestisci le tue carte',
                onPressed: () => Navigator.pushNamed(context, AppRoutes.cards),
              ),
              const SizedBox(height: 15),
              Button(
                label: 'Modifica il tuo profilo',
                onPressed: () => Navigator.pushNamed(context, AppRoutes.editProfile),
              ),
              const SizedBox(height: 15),
              Button(
                label: 'Gestisci prenotazioni',
                onPressed: () => Navigator.pushNamed(context, AppRoutes.giocatorePrenotazioni),
              ),
              const SizedBox(height: 15),
              Button(
                label: 'Logout',
                onPressed: () => _logout(context),
                backgroundColor: Colors.red[700],
              ),
              const SizedBox(height: 15),
              Button(
                label: 'Elimina account',
                onPressed: () => _confermaEliminazione(context),
                backgroundColor: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
