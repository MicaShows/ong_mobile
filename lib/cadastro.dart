import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import "package:mask_text_input_formatter/mask_text_input_formatter.dart";

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();

  final TextEditingController _cpfController = TextEditingController();

  final TextEditingController _cepController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _senhaController = TextEditingController();

  final TextEditingController _confirmarSenhaController =
      TextEditingController();

  // Máscara para o CEP: 123456-789

  final MaskTextInputFormatter cepMaskFormatter = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {"#": RegExp(r'[0-8]')},
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF8F2),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(
                'images/logo.jpg',
                height: 80,
              ),
              const SizedBox(height: 8),
              const Text(
                'Dados pessoais',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF028C3E),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Precisamos de algumas informações sobre você.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              _campoComLabelHint(
                  'Nome completo', 'Fulano de Tal', _nomeController),
              _campoComLabelHint(
                'CPF',
                '12345678910',
                _cpfController,
                tipo: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
              ),
              _campoComLabelHint(
                'CEP',
                '12345-890',
                _cepController,
                tipo: TextInputType.number,
                inputFormatters: [cepMaskFormatter],
              ),
              _campoComLabelHint(
                  'E-mail', 'fulanodetal@gmail.com', _emailController,
                  tipo: TextInputType.emailAddress),
              _campoComLabelHint(
                  'Crie uma senha', '***********', _senhaController,
                  isSenha: true),
              _campoComLabelHint('Confirmar nova senha', '***********',
                  _confirmarSenhaController,
                  isSenha: true),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_senhaController.text !=
                          _confirmarSenhaController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('As senhas não coincidem.')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Cadastro realizado com sucesso!')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF028C3E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Cadastrar',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  '< Voltar para o login',
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

  Widget _campoComLabelHint(
    String label,
    String hint,
    TextEditingController controller, {
    TextInputType tipo = TextInputType.text,
    bool isSenha = false,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            keyboardType: tipo,
            obscureText: isSenha,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1.5,
                  color: Color(0xFF007C3A),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Color(0xFF005F2D),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, preencha este campo';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}
