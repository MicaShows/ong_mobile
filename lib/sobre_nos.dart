import 'package:flutter/material.dart';

// Exemplo de definição da cor primaryGreen, caso ainda não tenha
const greenColor = Color(0xFF028C3E);

class SobreNosPage extends StatelessWidget {
  const SobreNosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenColor,
        title: const Text('Sobre Nós', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('images/logoprincipal.jpg', height: 200),
            const SizedBox(height: 1), // Espaço entre a imagem e o texto
            const Text(
              '    As ONGs (Organizações Não Governamentais) são entidades privadas da sociedade civil, sem fins lucrativos, dedicadas à promoção de causas sociais diversas, como direitos humanos, meio ambiente, educação, entre outras.\n\n'
              '    Elas fazem parte do terceiro setor, atuando de maneira complementar ao poder público, ajudando a suprir demandas sociais que não são totalmente atendidas pelo Estado.\n\n'
              '    Por meio de suas ações, as ONGs promovem mudanças positivas e fortalecem a participação cidadã, contribuindo para uma sociedade mais justa e solidária.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
