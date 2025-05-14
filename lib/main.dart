import 'package:flutter/material.dart';
import 'doacao.dart';
import 'login.dart';

// Simula o estado de login
bool isLoggedIn = false;

void main() {
  runApp(const MaterialApp(
    title: 'Ongnet',
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          DrawerHeader(
            decoration: BoxDecoration(color: Color.fromARGB(255, 0, 91, 165)),
            child: Text(
              'ONGs por Estado',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(title: Text('AC')),
          ListTile(title: Text('AL')),
          ListTile(title: Text('AM')),
          ListTile(title: Text('BA')),
          ListTile(title: Text('CE')),
          ListTile(title: Text('GO')),
        ],
      ),
    );
  }

  Widget _buildOngCard(String nomeOng) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey,
                child: Icon(Icons.image, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Text(
                nomeOng,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: 'Endereço: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: 'Informações de localização'),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: 'Objetivo: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: 'Descrição da missão da ONG.'),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Atividades:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF00578A),
            ),
          ),
          const SizedBox(height: 4),
          const Text('- Atividade 1'),
          const Text('- Atividade 2'),
          const Text('- Atividade 3'),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () async {
                if (isLoggedIn) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DoacaoPage(nomeOng: nomeOng)),
                  );
                } else {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );

                  if (result == true) {
                    setState(() {
                      isLoggedIn = true;
                    });

                    Navigator.push(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                          builder: (context) => DoacaoPage(nomeOng: nomeOng)),
                    );
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Você precisa estar logado para doar.'),
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00578A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text('Doar'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 91, 165),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'ONGNET',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );

              if (result == true) {
                setState(() {
                  isLoggedIn = true;
                });
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Ex. Ong Viver Mais, SP',
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildOngCard('ONG Esperança'),
                  _buildOngCard('Ajuda Animal'),
                  _buildOngCard('Cuidar Mais'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
