import 'package:flutter/material.dart';

class DoacaoPage extends StatefulWidget {
  final String nomeOng;

  const DoacaoPage({required this.nomeOng, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DoacaoPageState createState() => _DoacaoPageState();
}

class _DoacaoPageState extends State<DoacaoPage> {
  final _nomeController = TextEditingController();
  final _valorController = TextEditingController();
  late String _ongSelecionada;

  @override
  void initState() {
    super.initState();
    _ongSelecionada = widget.nomeOng;
  }

  @override
  Widget build(BuildContext context) {
    const textInputType = const TextInputType.numberWithOptions(decimal: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doação'),
        backgroundColor: const Color.fromARGB(255, 0, 91, 165),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Seu nome'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _valorController,
              decoration: const InputDecoration(
                labelText: 'Valor da doação (R\$)',
                prefixIcon: Icon(Icons.monetization_on),
              ),
              keyboardType: newMethod(textInputType),
            ),
            const SizedBox(height: 16),
            Text('ONG Selecionada: $_ongSelecionada'),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00578A),
              ),
              onPressed: () {
                if (_nomeController.text.isNotEmpty &&
                    _valorController.text.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Doação realizada com sucesso!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Preencha todos os campos.')),
                  );
                }
              },
              child: const Text('Doar agora'),
            ),
          ],
        ),
      ),
    );
  }

  TextInputType newMethod(TextInputType textInputType) => textInputType;
}
