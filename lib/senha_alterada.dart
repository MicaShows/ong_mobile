import 'package:flutter/material.dart';
import 'cadastro.dart';
import 'main.dart';

class SenhaAlteradaPage extends StatelessWidget {
  const SenhaAlteradaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF8F2),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/logo.jpg', height: 100),
              const SizedBox(height: 30),
              const Icon(Icons.lock_open, size: 60, color: Color(0xFF028C3E)),
              const SizedBox(height: 20),
              const Text(
                'Senha alterada com sucesso!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF028C3E),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Você pode usar sua nova senha para fazer login.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF028C3E),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text(
                  'Ir para o início',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Cadastro()),
                    (route) => false,
                  );
                },
                child: const Text(
                  'Fazer cadastro com nova senha',
                  style: TextStyle(
                    color: Color(0xFF028C3E),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
