import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:ong_mobile/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cadastro.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

// ===============================================================
  @override
  void initState() {
    super.initState();
    // _emailController.text = 'casamariamaia@org.br';
    // _senhaController.text = 'qw1as1a@';
    _emailController.text = 'leomar@org.br';
    _senhaController.text = '123';
  }

  // Future<String?> _consultaApiSenha(String email, String senha) async {
  Future<bool?> _consultaApiSenha(String email, String senha) async {
    debugPrint('>>>>>>>>>>>> entrada');
    debugPrint('>>>>>>>>>>>> dados: $email - $senha');
    try {
      String url = 'http://localhost:8080/api/v1/auth/authenticate';

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': senha,
        }),
      );
      // >>>>>>>> DEBUG ANTES DO IF <<<<<<<<
      debugPrint('>>>>>>>>>>>> statusCode: ${response.statusCode}');
      debugPrint('>>>>>>>>>>>> body: ${response.body}');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final accessToken = json['acess_token'];

        final payload = parseJwt(accessToken);
        final emailUsuario = payload['sub'];
        final role = payload['role'];
        print('role:  $role');
        print('E½: $emailUsuario');

        return true;
      } else {
        print("Erro ao conectar-se à API!");
        return null;
      }
    } catch (e) {
      print("Erro inesperado: ${e.toString()}");
      return null;
    }
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Token JWT inválido');
    }

    final payload = parts[1];
    final normalized = base64Url.normalize(payload);
    final payloadMap = json.decode(utf8.decode(base64Url.decode(normalized)));

    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('Payload inválido');
    }

    return payloadMap;
  }

// ===============================================================☻

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
                  'images/logoprincipal.jpg', // Ajuste conforme seu logo
                  height: 200,
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

                // Email
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 5),

                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'exemplo@email.com',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o e-mail';
                    } else if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$')
                        .hasMatch(value)) {
                      return 'Insira um e-mail válido';
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Campos válidos!')),
                        );
                      }

                      bool? resultado = await _consultaApiSenha(
                        _emailController.text,
                        _senhaController.text,
                      );

                      if (resultado!) {
                        // Sucesso na autenticação
                        // Ex: Navegar para outra tela
                        print('Login bem-sucedido!');
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool(
                            'isLoggedIn', true); // <- Salva o estado de login
                        print('');

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      } else {
                        // Falha na autenticação
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Falha na autenticação.')),
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
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Botão "Continuar sem cadastro"
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                        context, false); // volta para a página inicial
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
