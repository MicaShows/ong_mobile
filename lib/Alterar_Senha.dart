import 'package:flutter/material.dart';

class AlterarSenhaPage extends StatefulWidget {
  const AlterarSenhaPage({super.key});

  @override
  State<AlterarSenhaPage> createState() => _AlterarSenhaPageState();
}

class _AlterarSenhaPageState extends State<AlterarSenhaPage> {
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _repetirSenhaController = TextEditingController();

  String _mensagemErroSenha = '';
  String _mensagemErroRepetir = '';

  static const Color primaryGreen = Color(0xFF028C3E);

  bool _validarSenha(String senha) {
    final regex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~%])[A-Za-z\d!@#\$&*~%]{8,}$',
    );
    return regex.hasMatch(senha);
  }

  void _alterarSenha() {
    setState(() {
      _mensagemErroSenha = '';
      _mensagemErroRepetir = '';

      final senha = _senhaController.text;
      final repetirSenha = _repetirSenhaController.text;

      if (!_validarSenha(senha)) {
        _mensagemErroSenha = 'A senha não atende aos requisitos mínimos.';
      } else {
        _mensagemErroSenha = 'Senha atende os requisitos';
      }

      if (repetirSenha != senha) {
        _mensagemErroRepetir = 'As senhas não coincidem.';
      } else if (_mensagemErroSenha == 'Senha atende os requisitos') {
        _mensagemErroRepetir = 'Senha atende os requisitos';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FFF4),
      appBar: AppBar(
        backgroundColor: primaryGreen,
        iconTheme: const IconThemeData(color: Colors.white),
        title:
            const Text('Alterar Senha', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Image.asset('images/logoprincipal.jpg', height: 80),
            const SizedBox(height: 20),
            const Text(
              'Defina uma nova senha',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryGreen,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• Deve ter, no mínimo, 8 caracteres'),
                  Text(
                      '• Deve incluir letras maiúsculas e minúsculas (a-z e A-Z)'),
                  Text('• Deve incluir um número (0-9)'),
                  Text(
                      '• Deve incluir um caractere especial (!, @, #, %, etc.)'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _senhaController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Nova senha',
                fillColor: Colors.grey,
                filled: true,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              _mensagemErroSenha,
              style: TextStyle(
                color: _mensagemErroSenha.contains('atende')
                    ? Colors.green
                    : Colors.red,
              ),
            ),
            const SizedBox(height: 15),
            const Text('Repita sua senha'),
            const SizedBox(height: 5),
            TextField(
              controller: _repetirSenhaController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Repetir senha',
                fillColor: Colors.grey,
                filled: true,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              _mensagemErroRepetir,
              style: TextStyle(
                color: _mensagemErroRepetir.contains('atende')
                    ? Colors.green
                    : Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: _alterarSenha,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text('Alterar',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Voltar',
                style: TextStyle(
                  color: primaryGreen,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
