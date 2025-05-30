import 'package:flutter/material.dart';
import 'package:progmobile_flutter/ui/home_giocatore_screen.dart';
import '../ui/login_screen.dart';
import '../ui/register_screen.dart';
import '../ui/list_card_screen.dart';
import '../ui/add_card_screen.dart';

class AppRoutes {
  static const login = '/';
  static const register = '/register';
  static const cards = '/cards';
  static const addCard = '/cards/add';
  static const homeGiocatore = '/home';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case cards:
        return MaterialPageRoute(builder: (_) => const CardListScreen());
      case addCard:
        return MaterialPageRoute(builder: (_) => const AddCardScreen());
      case homeGiocatore:
        return MaterialPageRoute(builder: (_) => const HomeGiocatoreScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
