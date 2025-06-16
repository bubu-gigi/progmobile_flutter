import 'package:flutter/material.dart';

// Questa è una schermata riutilizzabile con un form per inserire/modificare i dati dell'utente.
// È uno StatefulWidget perché dobbiamo gestire controller che vanno creati e distrutti.
class UserForm extends StatefulWidget {
  // Titolo della schermata e del bottone (es: "Modifica profilo" o "Registrati")
  final String title;

  // Se true mostra uno spinner e disattiva il bottone (serve per il caricamento)
  final bool isLoading;

  // Funzione che viene chiamata quando premi il bottone
  final void Function() onSubmit;

  // Callback che si attiva quando cambia il valore nei rispettivi campi
  final void Function(String) onNomeChanged;
  final void Function(String) onCognomeChanged;
  final void Function(String) onEmailChanged;
  final void Function(String) onCodiceFiscaleChanged;

  // Callback opzionale per la password (può non servire)
  final void Function(String)? onPasswordChanged;

  // Valori iniziali da mostrare nei campi
  final String initialNome;
  final String initialCognome;
  final String initialEmail;
  final String initialCodiceFiscale;
  final String? initialPassword; // anche questo è opzionale

  // Costruttore: qui riceviamo tutti i dati che servono per costruire il form
  const UserForm({
    required this.title,
    required this.isLoading,
    required this.onSubmit,
    required this.onNomeChanged,
    required this.onCognomeChanged,
    required this.onEmailChanged,
    required this.onCodiceFiscaleChanged,
    required this.initialNome,
    required this.initialCognome,
    required this.initialEmail,
    required this.initialCodiceFiscale,
    this.initialPassword,
    this.onPasswordChanged,
    super.key,
  });

  // Flutter chiama questo metodo per creare lo "stato" associato a questo widget
  @override
  State<UserForm> createState() => _UserFormState();
}

// Qui c'è la parte "dinamica": gestiamo i controller e cosa succede quando cambia qualcosa
class _UserFormState extends State<UserForm> {
  // Questi controller servono per gestire il testo nei campi input
  late final TextEditingController nomeController;
  late final TextEditingController cognomeController;
  late final TextEditingController emailController;
  late final TextEditingController cfController;

  // Controller per la password (opzionale)
  TextEditingController? passwordController;

  // Questo metodo viene chiamato all'inizio, quando il widget viene creato
  @override
  void initState() {
    super.initState();

    // Inizializziamo i controller con i valori iniziali che ci ha passato il padre (widget)
    nomeController = TextEditingController(text: widget.initialNome);
    cognomeController = TextEditingController(text: widget.initialCognome);
    emailController = TextEditingController(text: widget.initialEmail);
    cfController = TextEditingController(text: widget.initialCodiceFiscale);

    // Se la password serve (cioè se è stato passato il callback), inizializziamo anche il suo controller
    if (widget.onPasswordChanged != null) {
      passwordController = TextEditingController(text: widget.initialPassword ?? '');
    }
  }

  // Questo metodo viene chiamato quando il widget viene distrutto
  // Serve per liberare memoria ed evitare problemi
  @override
  void dispose() {
    nomeController.dispose();
    cognomeController.dispose();
    emailController.dispose();
    cfController.dispose();
    passwordController?.dispose(); // con il ? evitiamo errori se era null
    super.dispose();
  }

  // Qui costruiamo la vera e propria interfaccia
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)), // Mostriamo il titolo in alto
      body: Padding(
        padding: const EdgeInsets.all(16), // Spazio attorno ai bordi
        child: ListView(
          children: [
            // Campo Nome
            TextField(
              controller: nomeController,
              onChanged: widget.onNomeChanged,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            const SizedBox(height: 12),

            // Campo Cognome
            TextField(
              controller: cognomeController,
              onChanged: widget.onCognomeChanged,
              decoration: const InputDecoration(labelText: 'Cognome'),
            ),
            const SizedBox(height: 12),

            // Campo Email
            TextField(
              controller: emailController,
              onChanged: widget.onEmailChanged,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),

            // Campo Codice Fiscale
            TextField(
              controller: cfController,
              onChanged: widget.onCodiceFiscaleChanged,
              decoration: const InputDecoration(labelText: 'Codice Fiscale'),
            ),
            const SizedBox(height: 12),

            // Campo Password (solo se serve)
            if (widget.onPasswordChanged != null && passwordController != null)
              TextField(
                controller: passwordController,
                onChanged: widget.onPasswordChanged,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true, // nasconde i caratteri digitati
              ),
            const SizedBox(height: 24),

            // Se stiamo caricando mostriamo lo spinner, altrimenti il bottone
            widget.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: widget.onSubmit,
                    child: Text(widget.title), // Testo del bottone = stesso del titolo
                  ),
          ],
        ),
      ),
    );
  }
}
