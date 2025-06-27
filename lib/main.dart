import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'doacao_page.dart';
import 'login.dart';
import 'usuario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model/model_ong.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  List<Ong> ongs = [];
  List<Ong> filteredOngs = [];

  bool mostrandoEstado = false;

  Future<void> carregaOngs() async {
    final url = Uri.parse('http://localhost:8686/api/v1/doador/ong');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        setState(() {
          ongs = jsonData.map((data) => Ong.fromJson(data)).toList();
          filteredOngs = ongs;
        });
      } else {
        print('Erro na resposta: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao buscar ONGs: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    carregaOngs();
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
    final Map<String, String> estados = {
      'ACRE': 'AC',
      'ALAGOAS': 'AL',
      'AMAPÁ': 'AP',
      'AMAZONAS': 'AM',
      'BAHIA': 'BA',
      'CEARÁ': 'CE',
      'DISTRITO FEDERAL': 'DF',
      'ESPIRITO SANTO': 'ES',
      'GOIÁS': 'GO',
      'MARANHÃO': 'MA',
      'MATO GROSSO': 'MT',
      'MATO GROSSO DO SUL': 'MS',
      'MINAS GERAIS': 'MG',
      'PARÁ': 'PA',
      'PARAÍBA': 'PB',
      'PARANÁ': 'PR',
      'PERNAMBUCO': 'PE',
      'PIAUÍ': 'PI',
      'RIO DE JANEIRO': 'RJ',
      'RIO GRANDE DO NORTE': 'RN',
      'RIO GRANDE DO SUL': 'RS',
      'RONDÔNIA': 'RO',
      'RORAIMA': 'RR',
      'SANTA CATARINA': 'SC',
      'SÃO PAULO': 'SP',
      'SERGIPE': 'SE',
      'TOCANTINS': 'TO',
    };

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF028C3E)),
            child: Text(
              'ONGs por Estado',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            title: const Text('TODOS OS ESTADOS',
                style: TextStyle(fontWeight: FontWeight.bold)),
            leading: const Icon(Icons.public, color: Color(0xFF028C3E)),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                filteredOngs = ongs;
                _searchController.clear();
                mostrandoEstado = false;
              });
            },
          ),
          const Divider(),
          ...estados.entries.map((entry) => ListTile(
                title: Text(entry.key),
                onTap: () {
                  Navigator.pop(context);
                  final ufSelecionada = entry.value;

                  setState(() {
                    filteredOngs = ongs
                        .where((ong) =>
                            ong.uf.toUpperCase() == ufSelecionada.toUpperCase())
                        .toList();
                    _searchController.clear();
                    mostrandoEstado = true;
                  });
                },
              )),
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
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF028C3E)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('Endereço: ${ong.endereco}'),
          const SizedBox(height: 8),
          Text('Missão: ${ong.missao}'),
          const SizedBox(height: 8),
          const Text('Atividades:',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF028C3E))),
          Text(ong.atividades),
          const SizedBox(height: 10),
          const Text('Meios de Contato',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xFF028C3E))),
          const SizedBox(height: 4),
          Row(children: [
            const Icon(Icons.email, color: Color(0xFF028C3E)),
            const SizedBox(width: 5),
            Text(ong.email)
          ]),
          const SizedBox(height: 4),
          Row(children: [
            const Icon(Icons.phone, color: Color(0xFF028C3E)),
            const SizedBox(width: 5),
            Text(ong.telefone)
          ]),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () async {
              if (isLoggedIn) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DoacaoItensPage(nomeOng: ong.nome)),
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
                    MaterialPageRoute(
                        builder: (context) =>
                            DoacaoItensPage(nomeOng: ong.nome)),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Você precisa estar logado para doar.')),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF028C3E),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            icon: const Icon(Icons.volunteer_activism, color: Colors.white),
            label: const Text('QUERO DOAR',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
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
        title: const Text('ONGNET',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () async {
              if (isLoggedIn) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UsuarioPage()));
              } else {
                final result = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Login()));
                if (result == true) {
                  setState(() => isLoggedIn = true);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UsuarioPage()));
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
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF028C3E)),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  if (mostrandoEstado)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        '\u00a0\u00a0\u00a0\u00a0As ONGs (Organizações Não Governamentais) são entidades privadas da sociedade civil, sem fins lucrativos, que se dedicam à promoção de diversas causas, como direitos humanos, meio ambiente, educação, saúde, entre outras. Elas fazem parte do chamado terceiro setor, juntamente com associações de classe e instituições religiosas, e têm um papel relevante no fortalecimento da cidadania e da justiça social.\n\n'
                        '\u00a0\u00a0\u00a0\u00a0Essas organizações atuam de forma complementar ao poder público, buscando suprir lacunas deixadas pelo Estado na oferta de serviços essenciais à população. Por meio de projetos, campanhas e ações diretas, as ONGs contribuem para o desenvolvimento social, a inclusão de grupos vulneráveis e a promoção de políticas públicas mais justas e eficazes.\n\n'
                        '\u00a0\u00a0\u00a0\u00a0O funcionamento das ONGs é impulsionado pelo engajamento de pessoas comprometidas com a transformação social. Por não terem fins lucrativos, elas dependem do apoio financeiro de empresas, doações de pessoas físicas e, em alguns casos, de repasses governamentais. Esse apoio é essencial para a continuidade e o impacto de suas atividades.',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  if (filteredOngs.isNotEmpty)
                    ...filteredOngs.map(_buildOngCard).toList()
                  else
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 32.0),
                        child: Text('Nenhuma ONG encontrada.'),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // dummy função para manter compatibilidade
  OngsPorEstadoPage({required String estado}) {}
}
