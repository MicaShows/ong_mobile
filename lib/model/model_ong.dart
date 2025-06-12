class Ong {
  final String nome;
  final String endereco;
  final String missao;
  final String atividades;
  final String email;
  final String telefone;
  final String uf;

  Ong({
    required this.nome,
    required this.endereco,
    required this.missao,
    required this.atividades,
    required this.email,
    required this.telefone,
    required this.uf,
  });

  factory Ong.fromJson(Map<String, dynamic> json) {
    return Ong(
      nome: (json['nome'] ?? '').toString().trim().isNotEmpty
          ? json['nome']
          : 'Nome não informado',
      endereco: (json['endereco'] ?? '').toString().trim().isNotEmpty
          ? json['endereco']
          : 'Endereço não informado',
      missao: (json['missao'] ?? '').toString().trim().isNotEmpty
          ? json['missao']
          : 'Missão não informada',
      atividades: (json['atividades'] ?? '').toString().trim().isNotEmpty
          ? json['atividades']
          : 'Atividades não informadas',
      email: (json['email'] ?? '').toString().trim().isNotEmpty
          ? json['email']
          : 'Email não informado',
      telefone: (json['telefone'] ?? '').toString().trim().isNotEmpty
          ? json['telefone']
          : 'Telefone não informado',
      uf: (json['UF'] ?? '').toString().trim().isNotEmpty
          ? json['UF']
          : 'UF não informado',
    );
  }

  // Como estava
  // factory Ong.fromJson(Map<String, dynamic> json) {
  //   return Ong(
  //     nome: json['nome'],
  //     endereco: json['endereco'],
  //     missao: json['missao'],
  //     atividades: json['atividades'],
  //     email: json['email'],
  //     telefone: json['telefone'],
  //   );
  // }
}
