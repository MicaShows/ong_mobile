// ignore: file_names
import 'package:flutter/material.dart';

class SuportePage extends StatefulWidget {
  const SuportePage({super.key});

  @override
  State<SuportePage> createState() => _SuportePageState();
}

class _SuportePageState extends State<SuportePage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();

  String assuntoSelecionado = '';
  String destinatarioSelecionado = '';

  static const Color primaryGreen = Color(0xFF028C3E);

  final List<String> assuntos = [
    'Erro no aplicativo',
    'Sugestão de melhoria',
    'Problemas com doação',
    'Outro',
  ];

  final List<String> emailsAdms = [
    'rm96124@estudante.fieb.edu.br',
    'rm95896@estudante.fieb.edu.br',
  ];

  void _enviarFormulario() {
    if (emailController.text.isEmpty ||
        assuntoSelecionado.isEmpty ||
        descricaoController.text.isEmpty ||
        destinatarioSelecionado.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Por favor, preencha todos os campos.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Mensagem enviada para $destinatarioSelecionado com sucesso!',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
      );
      emailController.clear();
      descricaoController.clear();
      setState(() {
        assuntoSelecionado = '';
        destinatarioSelecionado = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryGreen,
        title: const Text('Suporte', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text(
              'Administradores disponíveis:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ...emailsAdms.map((email) => Text(
                  email,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                )),
            const SizedBox(height: 20),

            const Text(
              'Envie-nos um e-mail preenchendo os campos abaixo, e logo retornaremos o seu contato.',
              style: TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // Campo: E-mail do usuário
            _buildInputContainer(
              child: TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Seu endereço de e-mail'),
              ),
            ),

            // Campo: Escolher destinatário
            _buildInputContainer(
              child: DropdownButtonFormField<String>(
                decoration: _inputDecoration('Escolha o destinatário'),
                dropdownColor: primaryGreen,
                style: const TextStyle(color: Colors.white),
                value: destinatarioSelecionado.isNotEmpty
                    ? destinatarioSelecionado
                    : null,
                items: emailsAdms
                    .map((email) => DropdownMenuItem<String>(
                          value: email,
                          child: Text(email,
                              style: const TextStyle(color: Colors.white)),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() => destinatarioSelecionado = value ?? '');
                },
              ),
            ),

            // Campo: Assunto
            _buildInputContainer(
              child: DropdownButtonFormField<String>(
                decoration: _inputDecoration(
                    'Sobre qual desses assuntos podemos te ajudar?'),
                dropdownColor: primaryGreen,
                style: const TextStyle(color: Colors.white),
                value:
                    assuntoSelecionado.isNotEmpty ? assuntoSelecionado : null,
                items: assuntos
                    .map((assunto) => DropdownMenuItem<String>(
                          value: assunto,
                          child: Text(assunto,
                              style: const TextStyle(color: Colors.white)),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() => assuntoSelecionado = value ?? '');
                },
              ),
            ),

            // Campo: Descrição
            _buildInputContainer(
              child: TextField(
                controller: descricaoController,
                maxLines: 6,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration(
                    'Descrição (Descreva aqui, detalhadamente sua solicitação)'),
              ),
            ),

            const SizedBox(height: 30),

            // Botão Enviar
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _enviarFormulario,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Enviar',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Container estilizado para os campos
  Widget _buildInputContainer({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: primaryGreen,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: child,
      ),
    );
  }

  /// Estilo dos campos
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      border: InputBorder.none,
    );
  }
}
