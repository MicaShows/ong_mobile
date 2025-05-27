import 'package:flutter/material.dart';
 
class RevisaoDoacaoPage extends StatelessWidget {
  final String nomeOng;
  final Map<String, int> itens;
  final Map<String, double> precos;
 
  const RevisaoDoacaoPage({
    super.key,
    required this.nomeOng,
    required this.itens,
    required this.precos,
  });
 
  double get total {
    double soma = 0;
    itens.forEach((item, qtd) {
      soma += qtd * (precos[item] ?? 0);
    });
    return soma;
  }
 
  @override
  Widget build(BuildContext context) {
    final itensSelecionados = itens.entries.where((e) => e.value > 0).toList();
 
    return Scaffold(
      appBar: AppBar(
        title: const Text('Revisar Doação'),
        backgroundColor: const Color(0xFF005BA5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ONG: $nomeOng', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            const Text('Itens selecionados:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: itensSelecionados.map((e) {
                  return ListTile(
                    title: Text('${e.key} x${e.value}'),
                    trailing: Text('R\$ ${(precos[e.key]! * e.value).toStringAsFixed(2)}'),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),
            Text('Total: R\$ ${total.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
            const SizedBox(height: 20),
            if (total > 0) ...[
              const Center(child: Text('Escaneie o QR Code para doar via Pix')),
              const SizedBox(height: 10),
              Center(
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/QR_Code_example.png/220px-QR_Code_example.png',
                  height: 150,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.check_circle),
                  label: const Text('Confirmar Doação'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Doação finalizada com sucesso!')),
                    );
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: const Color(0xFF005BA5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
 