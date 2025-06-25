import 'package:flutter/material.dart';
import 'package:progmobile_flutter/core/routes.dart';

// Schermata principale dell'amministratore dopo il login
class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image1/sfondi4.png'),
            fit: BoxFit.cover, // Adatta l'immagine
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
                  fontSize: 30, // Scegli una dimensione maggiore
                  fontWeight: FontWeight.bold, // Imposta il grassetto
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              // Bottone per modificare il profilo dell'amministratore
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.editProfile);
                },
                child: const Text('Modifica il tuo profilo'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Color(0xFF6136FF),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Color(0xFFCFFF5E), // Colore del bordo
                      width: 2, // Spessore del bordo
                    ),
                  ),
              ),
              ),
              const SizedBox(height: 24),
              // Bottone per gestire le strutture
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.adminStrutture);
                },
                child: const Text('Gestisci strutture'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Color(0xFF6136FF),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Color(0xFFCFFF5E), // Colore del bordo
                      width: 2, // Spessore del bordo
                    ),
                  ),
              ),
              ),
              const SizedBox(height: 24),
              // Bottone per gestire prenotazioni
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.adminPrenotazioni);
                },
                child: const Text('Gestisci prenotazioni'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Color(0xFF6136FF),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Color(0xFFCFFF5E), // Colore del bordo
                      width: 2, // Spessore del bordo
                    ),
                  ),
              ),
              ),
            ],

          ),
        ),
      ),
    );
  }
}
