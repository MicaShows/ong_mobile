import 'package:flutter/material.dart';

class DoarPresencialPage extends StatelessWidget {
  final String nomeOng;

  const DoarPresencialPage({super.key, required this.nomeOng});

  @override
  Widget build(BuildContext context) {
    const endereco = "Av. Itaqui, 325 - Jardim Belval, Barueri - SP, 06420-210";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF005A2D),
        title: const Text(
          'ONGNET',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFFE6EFE9),
                child: Text(
                  'VIVER\nMAIS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF005A2D),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'A ONG se encontra nesse endereço!!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Endereço:\n$endereco",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF005A2D),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
