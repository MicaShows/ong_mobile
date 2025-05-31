import 'package:flutter/material.dart';
import 'main.dart';

class Ong {
  final String nome;
  final String cidade;
  final String descricao;
  final String estado;

  Ong(
      {required this.nome,
      required this.cidade,
      required this.descricao,
      required this.estado});
}

class ListaOngsScreen extends StatelessWidget {
  final String estado;

  ListaOngsScreen({super.key, required this.estado});

  final List<Ong> todasAsOngs = [
    Ong(
        nome: 'Projeto Esperança',
        cidade: 'Rio Branco',
        descricao: 'Ajuda alimentar.',
        estado: 'AC'),
    Ong(
        nome: 'Amor Animal',
        cidade: 'Maceió',
        descricao: 'Resgate de animais.',
        estado: 'AL'),
    Ong(
        nome: 'Coração Solidário',
        cidade: 'Campinas',
        descricao: 'Ajuda famílias.',
        estado: 'SP'),
    // Adicione mais ONGs aqui...
  ];

  @override
  Widget build(BuildContext context) {
    List<Ong> ongsDoEstado =
        todasAsOngs.where((ong) => ong.estado == estado).toList();

    return Scaffold(
      appBar:
          AppBar(title: Text('ONGs em $estado'), backgroundColor: Colors.green),
      body: ongsDoEstado.isEmpty
          ? Center(child: Text('Nenhuma ONG encontrada para $estado'))
          : ListView.builder(
              itemCount: ongsDoEstado.length,
              itemBuilder: (context, index) {
                final ong = ongsDoEstado[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(ong.nome),
                    subtitle: Text('${ong.cidade} - ${ong.descricao}'),
                  ),
                );
              },
            ),
    );
  }
}
