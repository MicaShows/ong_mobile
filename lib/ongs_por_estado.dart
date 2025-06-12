import 'package:flutter/material.dart';
import 'package:ong_mobile/model/model_ong.dart';

class OngsPorEstadoPage extends StatefulWidget {
  final String estado;
  final List<Ong> todasOngs;

  const OngsPorEstadoPage({
    super.key,
    required this.estado,
    required this.todasOngs,
  });

  @override
  State<OngsPorEstadoPage> createState() => _OngsPorEstadoPageState();
}

class _OngsPorEstadoPageState extends State<OngsPorEstadoPage> {
  final TextEditingController _searchController = TextEditingController();
  late List<Ong> ongsDoEstado;
  late List<Ong> ongsFiltradas;

  @override
  void initState() {
    super.initState();

    // Filtra as ONGs pelo estado selecionado
    ongsDoEstado = widget.todasOngs.where((ong) {
      return ong.endereco.toUpperCase().contains(widget.estado.toUpperCase());
    }).toList();

    ongsFiltradas = List.from(ongsDoEstado);

    _searchController.addListener(() {
      final query = _searchController.text.toLowerCase();
      setState(() {
        ongsFiltradas = ongsDoEstado.where((ong) {
          return ong.nome.toLowerCase().contains(query);
        }).toList();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ONGs em ${widget.estado}'),
        backgroundColor: const Color(0xFF028C3E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Digite o nome da ONG',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF028C3E)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              '\u00a0\u00a0\u00a0\u00a0As ONGs (Organizações Não Governamentais) são entidades privadas da sociedade civil, sem fins lucrativos, que se dedicam à promoção de diversas causas, como direitos humanos, meio ambiente, educação, saúde, entre outras. Elas fazem parte do chamado terceiro setor, juntamente com associações de classe e instituições religiosas, e têm um papel relevante no fortalecimento da cidadania e da justiça social.\n\n'
              '\u00a0\u00a0\u00a0\u00a0Essas organizações atuam de forma complementar ao poder público, buscando suprir lacunas deixadas pelo Estado na oferta de serviços essenciais à população. Por meio de projetos, campanhas e ações diretas, as ONGs contribuem para o desenvolvimento social, a inclusão de grupos vulneráveis e a promoção de políticas públicas mais justas e eficazes.\n\n'
              '\u00a0\u00a0\u00a0\u00a0O funcionamento das ONGs é impulsionado pelo engajamento de pessoas comprometidas com a transformação social. Por não terem fins lucrativos, elas dependem do apoio financeiro de empresas, doações de pessoas físicas e, em alguns casos, de repasses governamentais. Esse apoio é essencial para a continuidade e o impacto de suas atividades.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
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
                                Text(
                                  ong.nome,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF028C3E),
                                  ),
                                ),
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
