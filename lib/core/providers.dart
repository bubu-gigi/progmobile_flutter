import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/core/user_session.dart';
import 'package:progmobile_flutter/data/collections/carta.dart';
import 'package:progmobile_flutter/repositories/campo_repository.dart';
import 'package:progmobile_flutter/repositories/carta_repository.dart';
import 'package:progmobile_flutter/repositories/prenotazione_repository.dart';
import 'package:progmobile_flutter/repositories/struttura_repository.dart';
import 'package:progmobile_flutter/repositories/user_repository.dart';
import 'package:progmobile_flutter/viewmodels/carta_viewmodel.dart';
import 'package:progmobile_flutter/viewmodels/edit_profile_viewmodel.dart';
import 'package:progmobile_flutter/viewmodels/giocatore_prenotazioni_viewmodel.dart';
import 'package:progmobile_flutter/viewmodels/login_viewmodel.dart';
import 'package:progmobile_flutter/viewmodels/register_viewmodel.dart';
import 'package:progmobile_flutter/viewmodels/state/giocatore_prenotazioni_state.dart';
import 'package:progmobile_flutter/viewmodels/state/login_state.dart';
import 'package:progmobile_flutter/viewmodels/state/register_state.dart';

import '../viewmodels/state/struttura_dettaglio_state.dart';
import '../viewmodels/state/strutture_state.dart';
import '../viewmodels/struttura_dettaglio_viewmodel.dart';
import '../viewmodels/strutture_viewmodel.dart';

final userRepositoryProvider = Provider((ref) => UserRepository());
final campoRepositoryProvider = Provider((ref) => CampoRepository());
final cartaRepositoryProvider = Provider((ref) => CartaRepository());
final prenotazioneRepositoryProvider = Provider((ref) => PrenotazioneRepository());
final strutturaRepositoryProvider = Provider((ref) => StrutturaRepository());
final userSessionProvider = StateProvider<UserSession?>((ref) => null);

final loginViewModelProvider =
    NotifierProvider<LoginViewModel, LoginState>(() => LoginViewModel());

final registerViewModelProvider =
    NotifierProvider<RegisterViewModel, RegisterState>(() => RegisterViewModel());

final giocatorePrenotazioniViewModelProvider =
    NotifierProvider<GiocatorePrenotazioniViewModel, GiocatorePrenotazioniState>(
  () => GiocatorePrenotazioniViewModel(),
);

final editProfileViewModelProvider =
    NotifierProvider<EditProfileViewModel, RegisterState>(
  () => EditProfileViewModel(),
);

final cartaViewModelProvider =
    NotifierProvider<CardViewModel, List<Carta>>(() => CardViewModel());

final strutturaDettaglioViewModelProvider =
NotifierProvider<StrutturaDettaglioViewModel, StrutturaDettaglioState>(
        () => StrutturaDettaglioViewModel(),
);

final struttureViewModelProvider =
NotifierProvider<StruttureViewModel, StruttureState>(() => StruttureViewModel(),);
