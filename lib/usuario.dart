import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class UsuarioPage extends StatelessWidget {
  const UsuarioPage({super.key});

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isLoggedIn', false);

    Navigator.pop(context); // volta à tela anterior
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF028C3E);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryGreen,
        title: const Text('ONGNET', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.black,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 10),
            const Text('Editar Foto',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 30),
            buildButton('Informações do Usuário', primaryGreen),
            buildButton('Doações', primaryGreen),
            buildButton('Segurança e Conta', primaryGreen),
            buildButton('Outras Opções', primaryGreen),
            buildButton('Sobre Nós', primaryGreen),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _logout(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text('Sair', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 40),
            Image.asset(
              'assets/logo.png',
              height: 80,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: SizedBox(
        width: 250,
        height: 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          onPressed: () {},
          child: Text(text, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
