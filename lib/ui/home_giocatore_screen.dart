import 'package:flutter/material.dart';
import 'package:progmobile_flutter/core/routes.dart';

class HomeGiocatoreScreen extends StatelessWidget {
  const HomeGiocatoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Benvenuto Giocatore')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.cards);
          },
          child: const Text('Gestisci le tue carte'),
        ),
      ),
    );
  }
}
