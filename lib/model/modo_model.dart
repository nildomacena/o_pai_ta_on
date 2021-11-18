class Modo {
  String sigla;
  String nome;

  Modo({required this.sigla, required this.nome});

  Map<String, String> get toJson => {'sigla': sigla, 'nome': nome};

  @override
  String toString() {
    return '$sigla - $nome';
  }
}
