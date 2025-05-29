import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'cadastro.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _cpfController = TextEditingController();

  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFFAF0), // Fundo verde claro

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  'images/logongnet.jpg', // Ajuste conforme seu logo

                  height: 80,
                ),

                const SizedBox(height: 20),

                const Text(
                  'Bem-vindo (a) de volta.',
                  style: TextStyle(
                    color: Color(0xFF028C3E), // Verde escuro

                    fontWeight: FontWeight.bold,

                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Preencha seus dados para continuar.',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 30),

                // CPF

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'CPF',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 5),

                TextFormField(
                  controller: _cpfController,
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    counterText: "", // Oculta o contador de caracteres

                    hintText: '123.456.789-10',

                    filled: true,

                    fillColor: Colors.white,

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o CPF';
                    } else if (value.length != 11) {
                      return 'O CPF deve ter 11 números';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Senha

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Senha',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 5),

                TextFormField(
                  controller: _senhaController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: '***********',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a senha';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      // Ação de esqueci a senha
                    },
                    child: const Text(
                      'Esqueceu a senha?',
                      style: TextStyle(
                        color: Color(0xFF065A26),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Botão "Entrar"

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Campos válidos!')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF028C3E),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Entrar',
                      style: TextStyle(
                        color: Colors.white, // Texto branco

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                const Text('ou'),

                const SizedBox(height: 10),

                // Botão "Cadastre-se"

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Cadastro()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF028C3E),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Cadastre-se',
                      style: TextStyle(
                        color: Colors.white, // Texto branco

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Botão "Continuar sem cadastro"
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false); // volta para a página inicial
                  },
                  child: const Text(
                    'Continuar sem cadastro',
                    style: TextStyle(
                      color: Color(0xFF028C3E),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
