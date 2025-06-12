import 'package:flutter/material.dart';
import 'suportepage.dart';
import 'termos_uso_page.dart';

class OutrasOpcoesPage extends StatelessWidget {
  const OutrasOpcoesPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color greenColor = Color(0xFF028C3E);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Outras Opções'),
        backgroundColor: greenColor,
        leading: const BackButton(color: Colors.white),
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.info, color: Colors.green),
            title: const Text('Sobre o Aplicativo'),
            subtitle: const Text(
                'Versão 1.0.0\nONGNET - Conectando doadores e ONGs.'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.description, color: Colors.green),
            title: const Text('Termos de uso e política de privacidade'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TermosUsoPage()),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.support_agent, color: Colors.green),
            title: const Text('Fale conosco / Suporte'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SuportePage()),
            ),
          ),
        ],
      ),
    );
  }
}
