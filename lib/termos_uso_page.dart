import 'package:flutter/material.dart';

class TermosUsoPage extends StatelessWidget {
  const TermosUsoPage({super.key});

  @override
  Widget build(BuildContext context) {
    const greenColor = Color(0xFF028C3E);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenColor,
        title:
            const Text('Termo de Uso', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: const Text(
            'Este aplicativo é fornecido pela ONGNET com o objetivo de conectar doadores a ONGs confiáveis. '
            'Ao utilizar este aplicativo, você concorda com os seguintes termos de uso:\n\n'
            '\u00a0\u00a0\u00a0\u00a01. Suas informações pessoais serão protegidas conforme nossa política de privacidade.\n\n'
            '\u00a0\u00a0\u00a0\u00a02. As doações realizadas são de responsabilidade do usuário e da ONG receptora.\n\n'
            '\u00a0\u00a0\u00a0\u00a03. Reservamo-nos o direito de modificar os termos a qualquer momento.\n\n'
            '\u00a0\u00a0\u00a0\u00a04. O uso indevido da plataforma pode resultar em suspensão da conta.\n\n'
            '\u00a0\u00a0\u00a0\u00a0Para mais informações, entre em contato com nosso suporte.\n\n'
            '\u00a0\u00a0\u00a0\u00a0Última atualização: Junho de 2025.',
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      ),
    );
  }
}
