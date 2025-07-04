import 'package:flutter/material.dart';
import 'package:progmobile_flutter/core/routes.dart';
import 'package:progmobile_flutter/repositories/user_repository.dart';
import 'package:progmobile_flutter/viewmodels/login_viewmodel.dart';

import 'components/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = LoginViewModel(UserRepository());
    _viewModel.addListener(_onViewModelChanged);
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChanged);
    super.dispose();
  }

  void _onViewModelChanged() {
    setState(() {});
    if (_viewModel.success) {
      if (_viewModel.role == "Giocatore") {
        Navigator.pushReplacementNamed(context, AppRoutes.homeGiocatore);
      } else if (_viewModel.role == "Admin") {
        Navigator.pushReplacementNamed(context, AppRoutes.homeAdmin);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ruolo non riconosciuto')),
        );
      }
    }

    if (_viewModel.error != null && _viewModel.error!.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_viewModel.error!)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image1/sfondo1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: _viewModel.setEmail,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6136FF), width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6136FF), width: 2.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6136FF), width: 2.0),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6136FF), width: 2.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6136FF), width: 2.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6136FF), width: 2.0),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              TextField(
                onChanged: _viewModel.setPassword,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6136FF), width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6136FF), width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6136FF), width: 2.0),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6136FF), width: 2.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6136FF), width: 2.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6136FF), width: 2.0),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              _viewModel.isLoading
                  ? const CircularProgressIndicator()
                  : Button(
                label: 'Login',
                onPressed: _viewModel.login,
                borderSide: const BorderSide(color: Color(0xFFCFFF5E), width: 2),
                backgroundColor: const Color(0xFF6136FF),
                textColor: Colors.white,
              ),
              const SizedBox(height: 12),

              TextButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  AppRoutes.register,
                ),
                child: const Text(
                  'Non hai un account? Registrati',
                  style: TextStyle(color: Color(0xFF6136FF)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
