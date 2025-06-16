import 'package:flutter/material.dart';
import 'package:progmobile_flutter/core/routes.dart';

// Schermata principale del giocatore dopo il login
// Mostra 3 bottoni per navigare: carte, profilo, prenotazioni
// non si serve ref quindi StatelessWidget va bene
class HomeGiocatoreScreen extends StatelessWidget {
  const HomeGiocatoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar in alto con il titolo
      appBar: AppBar(title: const Text('Benvenuto Giocatore')),

      // Corpo della schermata, centrato verticalmente
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Fa sì che la colonna si adatti al contenuto
          children: [
            // Bottone per andare alla schermata delle carte
            ElevatedButton(
              onPressed: () {
                // Naviga alla pagina delle carte salvate
                Navigator.pushNamed(context, AppRoutes.cards);
              },
              child: const Text('Gestisci le tue carte'),
            ),

            const SizedBox(height: 16), // Spazio tra i bottoni

            // Bottone per modificare il profilo utente
            ElevatedButton(
              onPressed: () {
                // Naviga alla pagina per modificare il profilo
                Navigator.pushNamed(context, AppRoutes.editProfile);
              },
              child: const Text('Modifica il tuo profilo'),
            ),

            // Bottone per visualizzare e gestire le prenotazioni
            ElevatedButton(
              onPressed: () {
                // Naviga alla schermata delle prenotazioni
                Navigator.pushNamed(context, AppRoutes.giocatorePrenotazioni);
              },
              child: const Text('Gestisci prenotazioni'),
            ),
          ],
        ),
      ),
    );
  }
}
