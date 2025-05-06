import 'package:flutter/material.dart';
import 'package:ong_mobile/login.dart';
// ignore: unused_import
import 'package:ong_mobile/cadastro.dart';


void main() {
  //função com retorno nulo criada para executar a aplicação
  runApp(
    const MaterialApp(
      title: 'Ongnet', //nome interno da aplicação (visível somente no sistema)
      home: Login(), //Home chama a classe Login
      debugShowCheckedModeBanner: false,
    ),
  );
}
