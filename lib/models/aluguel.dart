import 'package:flutteratividade/models/chuteira.dart';

class Aluguel {
  final Chuteira chuteira;
  final int tamanho;
  int dias;

  Aluguel({
    required this.chuteira,
    required this.tamanho,
    this.dias = 1,
  });

  double get total => chuteira.precoDiaria * dias;
}
