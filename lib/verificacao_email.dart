import 'package:flutter/material.dart';

class VerificacaoEmailPage extends StatelessWidget {
  const VerificacaoEmailPage({super.key});

  static const Color primaryGreen = Color(0xFF028C3E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FFFA),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png', height: 100), // sua logo
              const SizedBox(height: 20),
              const Text(
                'Nós precisamos do seu e-mail',
                style: TextStyle(
                    fontSize: 18,
                    color: primaryGreen,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Vamos enviar um código de verificação para você\nNos informe seu endereço de e-mail:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Ex: fulano@gmail.com',
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // ação de envio
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                ),
                child: const Text(
                  'Enviar',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Voltar',
                  style: TextStyle(
                      color: primaryGreen, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
