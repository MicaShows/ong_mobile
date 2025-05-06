import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(
                'images/logongnet.jpg',
                height: 100,
              ),

              const SizedBox(height: 10),

              const Text(
                'Dados pessoais',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const Text(
                'Precisamos de algumas informações sobre você.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              _campoComLabelHint(
                  'Nome completo', 'Digite seu nome completo', _nomeController),

              _campoComLabelHint('CPF', 'Digite seu CPF', _cpfController,
                  tipo: TextInputType.number),

              _campoComLabelHint('CEP', 'Digite seu CEP', _cepController,
                  tipo: TextInputType.number),

              _campoComLabelHint(
                  'E-mail', 'Digite seu e-mail', _emailController,
                  tipo: TextInputType.emailAddress),

              _campoComLabelHint(
                  'Crie uma senha', 'Digite uma nova senha', _senhaController,
                  tipo: TextInputType.visiblePassword, isSenha: true),

              _campoComLabelHint('Confirmar nova senha', 'Repita a nova senha',
                  _confirmarSenhaController,
                  tipo: TextInputType.visiblePassword, isSenha: true),

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
                    backgroundColor: const Color.fromARGB(255, 0, 67, 122),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Cadastrar'),
                ),
              ),

              const SizedBox(height: 20),

              // Botão "Voltar para Login"

              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Retorna para a tela anterior
                },
                child: const Text(
                  'Voltar para Login',
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

  Widget _campoComLabelHint(
      String label, String hint, TextEditingController controller,
      {TextInputType tipo = TextInputType.text, bool isSenha = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            keyboardType: tipo,
            obscureText: isSenha,
            decoration: InputDecoration(
              hintText: hint,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Color.fromARGB(255, 0, 67, 122),
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Color.fromARGB(255, 0, 91, 165),
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
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
