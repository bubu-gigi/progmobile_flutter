import 'package:flutter/material.dart';
import 'package:progmobile_flutter/ui/edit_profile_screen.dart';
import 'package:progmobile_flutter/ui/giocatore_prenotazioni.dart';
import 'package:progmobile_flutter/ui/home_admin_screen.dart';
import 'package:progmobile_flutter/ui/home_giocatore_screen.dart';
import 'package:progmobile_flutter/ui/struttura_dettaglio.dart';
import '../ui/login_screen.dart';
import '../ui/register_screen.dart';
import '../ui/list_card_screen.dart';
import '../ui/add_card_screen.dart';
import '../ui/admin_prenotazioni.dart';

class AppRoutes {
  static const login = '/';
  static const register = '/register';
  static const cards = '/cards';
  static const addCard = '/cards/add';
  static const homeGiocatore = '/player-home';
  static const homeAdmin = '/admin-home';
  static const editProfile = '/edit-profile';
  static const giocatorePrenotazioni = '/player-reservations';
  static const adminPrenotazioni = '/admin-reservations';
  static const dettaglioStruttura = '/struttura-dettaglio';

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
      case editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case giocatorePrenotazioni:
        return MaterialPageRoute(builder: (_) => const GiocatorePrenotazioniScreen());
      case adminPrenotazioni:
        return MaterialPageRoute(builder: (_) => const GestisciPrenotazioniAdminScreen());
      case dettaglioStruttura:
        final strutturaId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => StrutturaDettaglioScreen(strutturaId: strutturaId),
        );
      case homeAdmin:
        return MaterialPageRoute(builder: (_) => const HomeAdminScreen());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
