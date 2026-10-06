import 'package:flutteratividade/models/chuteira.dart';
import 'package:flutter/material.dart';

// Cuida do catálogo da loja: lista de chuteiras, estoque e filtro por tipo
class ChuteiraProvider extends ChangeNotifier {
  final List<Chuteira> _chuteiras = [
    Chuteira(nome: 'Mercurial Vapor', marca: 'Nike', tipo: 'Campo', precoDiaria: 25.00, estoque: 3),
    Chuteira(nome: 'Predator Accuracy', marca: 'Adidas', tipo: 'Campo', precoDiaria: 22.50, estoque: 2),
    Chuteira(nome: 'Future Play', marca: 'Puma', tipo: 'Campo', precoDiaria: 18.00, estoque: 1),
    Chuteira(nome: 'Phantom Society', marca: 'Nike', tipo: 'Society', precoDiaria: 15.00, estoque: 4),
    Chuteira(nome: 'Copa Pure Society', marca: 'Adidas', tipo: 'Society', precoDiaria: 14.00, estoque: 2),
    Chuteira(nome: 'Morelia Neo', marca: 'Mizuno', tipo: 'Society', precoDiaria: 16.50, estoque: 0),
    Chuteira(nome: 'Beco 2', marca: 'Nike', tipo: 'Futsal', precoDiaria: 12.00, estoque: 3),
    Chuteira(nome: 'Top Sala', marca: 'Penalty', tipo: 'Futsal', precoDiaria: 10.00, estoque: 5),
  ];

  String _filtro = 'Todos';

  String get filtro => _filtro;

  List<Chuteira> get chuteiras {
    if (_filtro == 'Todos') {
      return _chuteiras;
    }
    return _chuteiras.where((c) => c.tipo == _filtro).toList();
  }

  void mudarFiltro(String novoFiltro) {
    _filtro = novoFiltro;
    notifyListeners();
  }

  void retirarDoEstoque(Chuteira chuteira) {
    if (chuteira.estoque > 0) {
      chuteira.estoque--;
      notifyListeners();
    }
  }

  void devolverAoEstoque(Chuteira chuteira) {
    chuteira.estoque++;
    notifyListeners();
  }
}
