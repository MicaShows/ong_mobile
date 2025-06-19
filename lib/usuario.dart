import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'info_usuario.dart';
import 'doacoes_usuario.dart';
import 'seguranca.dart';
import 'outras_opcoes.dart';
import 'sobre_nos.dart';

class UsuarioPage extends StatelessWidget {
  const UsuarioPage({super.key});

  // ignore: unused_element
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    if (context.mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF028C3E);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryGreen,
        title: const Text('ONGNET', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme:
            const IconThemeData(color: Colors.white), // seta de voltar branca
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Image.asset(
              'images/logoprincipal.jpg',
              height: 200,
            ),
            const SizedBox(height: 30),
            buildButton(context, 'Informações do Usuário', primaryGreen,
                const InfoUsuarioPage()),
            buildButton(context, 'Doações', primaryGreen, const DoacoesPage()),
            buildButton(context, 'Segurança e Conta', primaryGreen,
                const SegurancaPage()),
            buildButton(context, 'Outras Opções', primaryGreen,
                const OutrasOpcoesPage()),
            buildButton(
                context, 'Sobre Nós', primaryGreen, const SobreNosPage()),
            const SizedBox(height: 30),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget buildButton(
      BuildContext context, String text, Color color, Widget page) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: SizedBox(
        width: 500,
        height: 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => page));
          },
          child: Text(text, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
