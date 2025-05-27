import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
 
import 'doacao.dart';

import 'login.dart';

import 'usuario.dart';
 
bool isLoggedIn = false;
 
void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
 
  runApp(const MaterialApp(

    title: 'Ongnet',

    home: HomePage(),

    debugShowCheckedModeBanner: false,

  ));

}
 
class Ong {

  final String nome;

  final String endereco;

  final String missao;

  final String atividades;

  final String email;

  final String telefone;
 
  Ong({

    required this.nome,

    required this.endereco,

    required this.missao,

    required this.atividades,

    required this.email,

    required this.telefone,

  });

}
 
class HomePage extends StatefulWidget {

  const HomePage({super.key});
 
  @override

  State<HomePage> createState() => _HomePageState();

}
 
class _HomePageState extends State<HomePage> {

  final TextEditingController _searchController = TextEditingController();
 
  List<Ong> ongs = [

    Ong(

      nome: 'ONG Viver Mais',

      endereco: 'Av. Itapuí, 325 - Jardim Belaura, Bauru - SP, 00034-210',

      missao: 'Acolher moradores de rua e pessoas em situação de vulnerabilidade socioeconômica.',

      atividades: '- Ações de Assistência Básica\n- Refeições, kits de higiene e roupas',

      email: 'ong.vivermais@gmail.com',

      telefone: '(11) 1234-6789',

    ),

    Ong(

      nome: 'Saúde Natureza',

      endereco: 'Jardins, SP, Centro, CEP 67854321',

      missao: 'Melhorar as condições do meio ambiente através de ações e medidas sustentáveis.',

      atividades: '- Educação Ambiental\n- Reflorestamento\n- Coleta seletiva e reciclagem',

      email: 'ong.vivernmais@gmail.com',

      telefone: '(11) 1234-6789',

    ),

    Ong(

      nome: 'Ajuda Animal',

      endereco: 'Rua das Flores, 123, São Paulo - SP',

      missao: 'Proteger animais em situação de risco.',

      atividades: '- Resgate\n- Adoção\n- Campanhas de conscientização',

      email: 'ajuda.animal@gmail.com',

      telefone: '(11) 9876-5432',

    ),

  ];
 
  List<Ong> filteredOngs = [];
 
  @override

  void initState() {

    super.initState();

    filteredOngs = ongs;

    _searchController.addListener(filterOngs);

  }
 
  void filterOngs() {

    final query = _searchController.text.toLowerCase();

    setState(() {

      filteredOngs = ongs.where((ong) {

        return ong.nome.toLowerCase().contains(query);

      }).toList();

    });

  }
 
  Drawer _buildDrawer() {

    return Drawer(

      child: ListView(

        padding: EdgeInsets.zero,

        children: const [

          DrawerHeader(

            decoration: BoxDecoration(color: Color(0xFF028C3E)),

            child: Text('ONGs por Estado', style: TextStyle(color: Colors.white, fontSize: 24)),

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
 
  Widget _buildOngCard(Ong ong) {

    return Container(

      margin: const EdgeInsets.symmetric(vertical: 10),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(12),

        boxShadow: [

          BoxShadow(

            color: Colors.grey.shade300,

            blurRadius: 5,

            offset: const Offset(0, 3),

          ),

        ],

      ),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Row(

            children: [

              const CircleAvatar(

                radius: 25,

                backgroundColor: Color(0xFF028C3E),

                child: Icon(Icons.emoji_nature, color: Colors.white),

              ),

              const SizedBox(width: 10),

              Expanded(

                child: Text(

                  ong.nome,

                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF028C3E)),

                ),

              ),

            ],

          ),

          const SizedBox(height: 8),

          Text('Endereço: ${ong.endereco}'),

          const SizedBox(height: 8),

          Text('Missão: ${ong.missao}'),

          const SizedBox(height: 8),

          const Text('Atividades:', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF028C3E))),

          Text(ong.atividades),

          const SizedBox(height: 10),

          const Text('Meios de Contato', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF028C3E))),

          const SizedBox(height: 4),

          Row(children: [const Icon(Icons.email, color: Color(0xFF028C3E)), const SizedBox(width: 5), Text(ong.email)]),

          const SizedBox(height: 4),

          Row(children: [const Icon(Icons.phone, color: Color(0xFF028C3E)), const SizedBox(width: 5), Text(ong.telefone)]),

          const SizedBox(height: 10),

          ElevatedButton.icon(

            onPressed: () async {

              if (isLoggedIn) {

                Navigator.push(

                  context,

                  MaterialPageRoute(builder: (context) => DoacaoItensPage(nomeOng: ong.nome)),

                );

              } else {

                final result = await Navigator.push(

                  context,

                  MaterialPageRoute(builder: (context) => const Login()),

                );
 
                if (result == true) {

                  setState(() => isLoggedIn = true);

                  Navigator.push(

                    context,

                    MaterialPageRoute(builder: (context) => DoacaoItensPage(nomeOng: ong.nome)),

                  );

                } else {

                  ScaffoldMessenger.of(context).showSnackBar(

                    const SnackBar(content: Text('Você precisa estar logado para doar.')),

                  );

                }

              }

            },

            style: ElevatedButton.styleFrom(

              backgroundColor: const Color(0xFF028C3E),

              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),

              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

            ),

            icon: const Icon(Icons.volunteer_activism, color: Colors.white),

            label: const Text('QUERO DOAR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),

          )

        ],

      ),

    );

  }
 
  @override

  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFEFF8F2),

      drawer: _buildDrawer(),

      appBar: AppBar(

        backgroundColor: const Color(0xFF028C3E),

        iconTheme: const IconThemeData(color: Colors.white),

        title: const Text('ONGNET', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),

        centerTitle: true,

        actions: [

          IconButton(

            icon: const Icon(Icons.person, color: Colors.white),

            onPressed: () async {

              if (isLoggedIn) {

                Navigator.push(context, MaterialPageRoute(builder: (context) => const UsuarioPage()));

              } else {

                final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));

                if (result == true) {

                  setState(() => isLoggedIn = true);

                  Navigator.push(context, MaterialPageRoute(builder: (context) => const UsuarioPage()));

                }

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

                hintText: 'Pesquise pelo nome da ONG que deseja ajudar!',

                filled: true,

                fillColor: Colors.white,

                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),

                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),

                prefixIcon: const Icon(Icons.search, color: Color(0xFF028C3E)),

              ),

            ),

            const SizedBox(height: 16),

            Expanded(

              child: filteredOngs.isNotEmpty

                  ? ListView.builder(

                      itemCount: filteredOngs.length,

                      itemBuilder: (context, index) => _buildOngCard(filteredOngs[index]),

                    )

                  : const Center(child: Text('Nenhuma ONG encontrada.')),

            ),

          ],

        ),

      ),

    );

  }

}

 