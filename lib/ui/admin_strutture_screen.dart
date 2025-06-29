import 'package:flutter/material.dart';
import 'package:progmobile_flutter/repositories/campo_repository.dart';
import 'package:progmobile_flutter/repositories/struttura_repository.dart';
import 'package:progmobile_flutter/ui/components/mappa_strutture_con_filtri.dart';
import 'package:progmobile_flutter/ui/struttura_form_screen.dart';
import 'package:progmobile_flutter/viewmodels/strutture_viewmodel.dart';

import 'components/button.dart';

class AdminStruttureScreen extends StatefulWidget {
  const AdminStruttureScreen({super.key});

  @override
  State<AdminStruttureScreen> createState() => _AdminStruttureScreenState();
}

class _AdminStruttureScreenState extends State<AdminStruttureScreen> {
  late final StruttureViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = StruttureViewModel(StrutturaRepository(), CampoRepository());
    viewModel.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    viewModel.removeListener(() => setState(() {}));
    super.dispose();
  }

  void _goToDettaglio(String id) async {
    final struttura = viewModel.strutture.firstWhere((s) => s.id == id);
    await viewModel.caricaCampi(struttura.id);
    final campi = viewModel.strutturaDettaglioCampi;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StrutturaFormScreen(
          strutturaDaModificare: struttura,
          campiEsistenti: campi,
        ),
      ),
    ).then((_) {
      viewModel.caricaStrutture();
    });
  }


  void _goToCreazione() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const StrutturaFormScreen(),
      ),
    ).then((_) {
      viewModel.caricaStrutture();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = viewModel;

    return Scaffold(
      appBar: AppBar(title: const Text('Gestisci Strutture')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: MappaStruttureConFiltri(
              strutture: state.strutture,
              onStrutturaSelezionata: (s) => _goToDettaglio(s.id),
              height: double.infinity,
            ),
          ),
          const SizedBox(height: 5),
          Button(
            label: 'Inserisci nuova struttura',
            onPressed: _goToCreazione,
            backgroundColor: const Color(0xFF6136FF),
            textColor: Colors.white,
            borderSide: const BorderSide(color: Color(0xFFCFFF5E), width: 3),
          ),
        ],
      ),
    );
  }
}
