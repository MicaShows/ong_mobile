import 'package:flutter/material.dart';
import 'cadastro.dart'; // Importa a tela de cadastro

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Chave que identifica o formulário e permite validar
  final _formKey = GlobalKey<FormState>();
  // Controladores para pegar o texto digitado nos campos
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90, // Altura maior da AppBar
        backgroundColor: const Color.fromARGB(255, 0, 91, 165),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        title: const Text("ONGNET"),
        centerTitle: true, // Centraliza o título
      ),
      body: SingleChildScrollView(
        // Evita erro de overflow quando o teclado aparece
        child: Form(
          key: _formKey, // Associa o formulário à chave
          child: Column(
            children: [
              const SizedBox(height: 30),
              // Logo da ONG
              Image.asset(
                'images/logongnet.jpg', // Ajuste o caminho se necessário
                height: 120,
              ),
              const SizedBox(height: 20),
              // Campo CPF
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CPF',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: _cpfController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'CPF',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 0, 67, 122),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 0, 91, 165),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o CPF';
                        }

                        return null;
                      },
                    ),
                  ],
                ),
              ),
              // Campo Senha
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Senha',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: _senhaController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 0, 67, 122),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 0, 91, 165),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira a senha';
                        }

                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Botão "Entrar"
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    // Verifica se todos os campos estão validados
                    if (_formKey.currentState!.validate()) {
                      // Mostra uma mensagem de sucesso
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Campos válidos!')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 67, 122),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Entrar'),
                ),
              ),
              const SizedBox(height: 10),
              // Texto "OU"
              const Text('OU', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              // Botão "Cadastre-se"
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Cadastro()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 67, 122),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Cadastre-se'),
                ),
              ),
              const SizedBox(height: 20),
              // Botão "Continuar sem cadastro"
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false); // volta para a página inicial
                },
                child: const Text(
                  'Continuar sem cadastro',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 67, 122),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
