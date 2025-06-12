import 'package:flutter/material.dart';
import 'Alterar_Senha.dart';

class CodigoVerificacaoPage extends StatelessWidget {
  const CodigoVerificacaoPage({super.key});

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
                'Código de verificação enviado!',
                style: TextStyle(
                    fontSize: 18,
                    color: primaryGreen,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Verifique sua caixa de entrada.',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              const Icon(Icons.check_circle, color: primaryGreen, size: 40),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 50,
                    child: TextField(
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        fillColor: Colors.grey[400],
                        border: OutlineInputBorder(),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AlterarSenhaPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text('Confirmar'),
              ),
              const SizedBox(height: 10),
              const Text('Não recebeu?'),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Reenviar código',
                  style: TextStyle(
                      color: primaryGreen, fontWeight: FontWeight.bold),
                ),
              ),
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
