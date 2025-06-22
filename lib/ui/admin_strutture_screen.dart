import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/ui/components/mappa_strutture_con_filtri.dart';
import 'package:progmobile_flutter/ui/struttura_form_screen.dart';
import '../core/providers.dart';

class AdminStruttureScreen extends ConsumerStatefulWidget {
  const AdminStruttureScreen({super.key});

  @override
  ConsumerState<AdminStruttureScreen> createState() => _AdminStruttureScreenState();
}

class _AdminStruttureScreenState extends ConsumerState<AdminStruttureScreen> {
  void _goToDettaglio(String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const StrutturaFormScreen(),
      ),
    ).then((_) {
      ref.read(struttureViewModelProvider.notifier).caricaStrutture();
    });
  }

  void _goToCreazione() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const StrutturaFormScreen(),
      ),
    ).then((_) {
      ref.read(struttureViewModelProvider.notifier).caricaStrutture();
    });
  }


  @override
  Widget build(BuildContext context) {
    // Osserviamo lo stato del viewmodel
    final state = ref.watch(struttureViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Gestisci Strutture')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          // Mappa filtrata
          Expanded(
            child: MappaStruttureConFiltri(
              strutture: state.strutture,
              onStrutturaSelezionata: (s) => _goToDettaglio(s.id),
              height: double.infinity,
            ),
          ),
          const SizedBox(height: 8),
          // Bottone per aggiungere nuova struttura
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _goToCreazione,
              child: const Text('Inserisci nuova struttura'),
            ),
          ),
        ],
      ),
    );
  }
}
