class Empresa {
  final int? id;
  final String nome;
  final String segmento;
  final String email;
  final String telefone;
  final String descricao;

  Empresa({
    this.id,
    required this.nome,
    required this.segmento,
    required this.email,
    required this.telefone,
    required this.descricao
  });

  factory Empresa.fromMap(Map map) {
    return Empresa(
      id: map['id'], 
      nome: map['nome'], 
      segmento: map['segmento'],
      email: map['email'],
      telefone: map['telefone'],
      descricao: map['descricao']
    );
  }

  Map toMap() {
    Map<String, dynamic> map = {
      'nome': nome,
      'segmento': segmento,
      'email': email,
      'telefone': telefone,
      'descricao': descricao
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }
}