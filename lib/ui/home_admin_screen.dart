import 'package:flutter/material.dart';
import 'package:progmobile_flutter/core/routes.dart';

import 'components/button.dart';

class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.editProfile);
                },
                label: 'Modifica il tuo profilo',
              ),
              const SizedBox(height: 24),
              Button(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.adminStrutture);
                },
                label: 'Gestisci Strutture',
              ),
              const SizedBox(height: 24),
              Button(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.adminPrenotazioni);
                },
                label: 'Gestisci Prenotazioni',
              ),
            ],

          ),
        ),
      ),
    );
  }
}
