import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/core/routes.dart';

void main() {
  runApp(const ProviderScope(child: GameOnApp()));
}

class GameOnApp extends StatelessWidget {
  const GameOnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GameOn Login',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoutes.login,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
