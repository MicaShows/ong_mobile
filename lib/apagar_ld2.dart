// Future<String?> _consultaApiSenha(String email, String senha) async {
//     debugPrint('>>>>>>>>>>>> entrada');
//     try {
//       //String url = 'http://localhost:8080/api/v1/auth/authenticate';
//       //final response = await http.post(Uri.parse(url)
     
     
//       //);
 
//       String url = 'http://localhost:8080/api/v1/auth/authenticate';
 
//   final response = await http.post(
//     Uri.parse(url),
//     headers: {
//       'Content-Type': 'application/json',
//     },
//     body: jsonEncode({
//       'email': email,
//       'password': senha,
//     }),
//   );
//         // >>>>>>>> DEBUG ANTES DO IF <<<<<<<<
//     debugPrint('>>>>>>>>>>>> statusCode: ${response.statusCode}');
//     debugPrint('>>>>>>>>>>>> body: ${response.body}');
 
//       if (response.statusCode == 200) {
//         //final List<dynamic> usuarios =
//           //  json.decode(utf8.decode(response.bodyBytes));
 
//         // Procura o usuário com email extraído do JWT + senha correta
//        /* final usuario = usuarios.firstWhere(
//           (user) {
//             try {
//               final token = user['email']; // aqui 'email' é na verdade o JWT
//               final payload = parseJwt(token);
//               final emailExtraido = payload['sub'];
//               debugPrint('>>>>>>>>>>>> $emailExtraido');
//               return emailExtraido == email && user['password'] == senha;
//             } catch (_) {
//               return false;
//             }
//           },
//           orElse: () => null,
//         );
 
//         if (usuario != null) {
//           return usuario['email'];
//         } else {
//           return null;
//         } */
 
//      final json = jsonDecode(response.body);
//         final accessToken = json['access_token'];
 
 
//         final payload = parseJwt(accessToken);
//         final emailUsuario = payload['sub'];
//          final role = payload['role'];
//         print('role:  $role');
 
//         return role;
 
//       } else {
//         _showAlert("Erro ao conectar-se à API!");
//         return null;
//       }
//     } catch (e) {
//       _showAlert("Erro inesperado: ${e.toString()}");
//       return null;
//     }
//   }
 




//   Map<String, dynamic> parseJwt(String token) {
//     final parts = token.split('.');
//     if (parts.length != 3) {
//       throw Exception('Token JWT inválido');
//     }
 
//     final payload = parts[1];
//     final normalized = base64Url.normalize(payload);
//     final payloadMap = json.decode(utf8.decode(base64Url.decode(normalized)));
 
//     if (payloadMap is! Map<String, dynamic>) {
//       throw Exception('Payload inválido');
//     }
 
//     return payloadMap;
//   }
 
