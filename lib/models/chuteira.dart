class Chuteira {
  final String nome;
  final String marca;
  final String tipo; // Campo, Society ou Futsal
  final double precoDiaria;
  int estoque; // quantos pares estão disponíveis na loja

  Chuteira({
    required this.nome,
    required this.marca,
    required this.tipo,
    required this.precoDiaria,
    required this.estoque,
  });
}
