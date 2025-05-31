import 'package:flutter/material.dart';
import 'main.dart';

class OngsPorEstadoPage extends StatefulWidget {
  final String estado;

  const OngsPorEstadoPage({super.key, required this.estado});

  @override
  State<OngsPorEstadoPage> createState() => _OngsPorEstadoPageState();
}

class _OngsPorEstadoPageState extends State<OngsPorEstadoPage> {
  final TextEditingController _cepController = TextEditingController();
  List<Ong> ongsFiltradas = [];

  void buscarOngsPorCep() {
    final cepDigitado = _cepController.text.trim();

    if (cepDigitado.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Digite um CEP para buscar.')),
      );
      return;
    }

    setState(() {
      ongsFiltradas = allOngs.where((ong) {
        final endereco = ong.endereco
            .replaceAll(RegExp(r'\D'), ''); // remove caracteres não numéricos
        return endereco.contains(cepDigitado);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ONGs em ${widget.estado}',
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF028C3E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _cepController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Digite o CEP',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon:
                    const Icon(Icons.location_on, color: Color(0xFF028C3E)),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: buscarOngsPorCep,
              icon: const Icon(Icons.search),
              label: const Text('Buscar ONGs próximas'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF028C3E),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ongsFiltradas.isEmpty
                  ? const Center(child: Text('Nenhuma ONG encontrada.'))
                  : ListView.builder(
                      itemCount: ongsFiltradas.length,
                      itemBuilder: (context, index) {
                        final ong = ongsFiltradas[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(ong.nome,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF028C3E))),
                                const SizedBox(height: 8),
                                Text('Endereço: ${ong.endereco}'),
                                const SizedBox(height: 4),
                                Text('Missão: ${ong.missao}'),
                                const SizedBox(height: 4),
                                Text('Atividades: ${ong.atividades}'),
                                const SizedBox(height: 4),
                                Text('Email: ${ong.email}'),
                                Text('Telefone: ${ong.telefone}'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}