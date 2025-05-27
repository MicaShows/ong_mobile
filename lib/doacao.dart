import 'package:flutter/material.dart';

class DoacaoItensPage extends StatelessWidget {
  final String nomeOng;

  const DoacaoItensPage({super.key, required this.nomeOng});

  @override
  Widget build(BuildContext context) {
    final Map<String, int> metas = {
      'Alimento': 5,
      'Limpeza': 10,
      'Higiene': 15,
      'Doméstico': 20,
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF005A2D),
        elevation: 0,
        title: const Text("ONGNET"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.account_circle),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Logo e nome da ONG

            const CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFFE6EFE9),
              child: Text(
                'VIVER\nMAIS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF005A2D),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Essa ONG está precisando de doações',
              style: TextStyle(
                color: Color(0xFF005A2D),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Veja alguns itens que você pode doar:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 20),

            // Lista de categorias e metas

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: metas.entries.map((entry) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Radio(
                      value: entry.key,

                      groupValue: 'Alimento', // pré-selecionado

                      onChanged: (_) {},

                      activeColor: Colors.black,
                    ),
                    title: Text(entry.key),
                    trailing: Text('${entry.value}/100'),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            // Botões

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF005A2D),
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text('Doar presencial'),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF005A2D),
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text('Doar por aqui'),
            ),
          ],
        ),
      ),
    );
  }
}
