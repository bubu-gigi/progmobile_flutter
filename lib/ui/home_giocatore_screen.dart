import 'package:flutter/material.dart';
import 'package:progmobile_flutter/core/routes.dart';

import 'components/button.dart';

class HomeGiocatoreScreen extends StatelessWidget {
  const HomeGiocatoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Benvenuto Giocatore'),
        backgroundColor: const Color(0xFF232323),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
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
              const SizedBox(height: 30),
              Button(
                label: 'Gestisci le tue carte',
                onPressed: () => Navigator.pushNamed(context, AppRoutes.cards),
              ),
              const SizedBox(height: 16),
              Button(
                label: 'Modifica il tuo profilo',
                onPressed: () => Navigator.pushNamed(context, AppRoutes.editProfile),
              ),
              const SizedBox(height: 16),
              Button(
                label: 'Gestisci prenotazioni',
                onPressed: () => Navigator.pushNamed(context, AppRoutes.giocatorePrenotazioni),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
