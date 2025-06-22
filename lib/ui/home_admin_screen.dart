import 'package:flutter/material.dart';
import 'package:progmobile_flutter/core/routes.dart';

// Schermata principale dell'amministratore dopo il login
// Mostra 3 bottoni: modifica profilo, gestisci strutture, gestisci prenotazioni
class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Benvenuto Amministratore')),

      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Bottone per modificare il profilo dell'amministratore
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.editProfile);
              },
              child: const Text('Modifica il tuo profilo'),
            ),

            const SizedBox(height: 16),

            // Bottone per gestire le strutture
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.adminStrutture);
              },
              child: const Text('Gestisci strutture'),
            ),

            const SizedBox(height: 16),

            // Bottone per gestire prenotazioni
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.adminPrenotazioni);
              },
              child: const Text('Gestisci prenotazioni'),
            ),
          ],
        ),
      ),
    );
  }
}
