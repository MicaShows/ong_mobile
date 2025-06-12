import 'package:flutter/material.dart';

class DoacoesPage extends StatelessWidget {
  const DoacoesPage({super.key});

  // Simulação de histórico de ONGs doadas
  final List<String> historico = const [
    'ONG Esperança Viva',
    'Projeto Alimenta Brasil',
    'Associação Luz do Bem',
  ];

  @override
  Widget build(BuildContext context) {
    const greenColor = Color(0xFF028C3E);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title:
            const Text('Minhas Doações', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Histórico de Ongs Doadas:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: historico.isEmpty
                  ? const Center(child: Text('Nenhuma doação registrada.'))
                  : ListView.builder(
                      itemCount: historico.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.green[50],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.volunteer_activism,
                                color: Color(0xFF028C3E)),
                            title: Text(historico[index]),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Retorna à tela principal
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: Color(0xFF028C3E)),
                  ),
                ),
                child: const Text(
                  'Fazer nova doação',
                  style: TextStyle(color: Color(0xFF028C3E), fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
