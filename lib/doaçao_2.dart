import 'package:flutter/material.dart';


class DoacaoOnlinePage extends StatefulWidget {
  const DoacaoOnlinePage({super.key});

  @override
  State<DoacaoOnlinePage> createState() => _DoacaoOnlinePageState();
}

class _DoacaoOnlinePageState extends State<DoacaoOnlinePage> {
  final Map<String, Map<String, dynamic>> itens = {
    'Arroz': {'preco': 12.0, 'quantidade': 2},
    'Feijão': {'preco': 8.0, 'quantidade': 0},
    'Macarrão': {'preco': 5.0, 'quantidade': 3},
    'Óleo': {'preco': 8.0, 'quantidade': 5},
  };

  double get total {
    double total = 0;

    itens.forEach((nome, dados) {
      total += dados['preco'] * dados['quantidade'];
    });

    return total;
  }

  void atualizarQuantidade(String item, int delta) {
    setState(() {
      int novaQuantidade = itens[item]!['quantidade'] + delta;

      if (novaQuantidade >= 0) {
        itens[item]!['quantidade'] = novaQuantidade;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF005A2D),
        title: const Text("ONGNET"),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.account_circle, color: Colors.white),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF005A2D)),
              child: Text('Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Início'),
              onTap: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFFE6EFE9),
              child: Text(
                "VIVER\nMAIS",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF005A2D),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Itens de Alimentos que você pode doar:',
              style: TextStyle(
                color: Color(0xFF005A2D),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Escolha os itens que você irá doar e sua quantidade.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: itens.entries.map((entry) {
                  final nome = entry.key;

                  final preco = entry.value['preco'];

                  final quantidade = entry.value['quantidade'];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(nome,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        Text('R\$${(preco * quantidade).toStringAsFixed(2)}'),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => atualizarQuantidade(nome, -1),
                            ),
                            Text('$quantidade'),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () => atualizarQuantidade(nome, 1),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const Divider(thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("TOTAL:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text("R\$${total.toStringAsFixed(2)}",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Próxima ação
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF005A2D),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'PRÓXIMO PASSO',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
