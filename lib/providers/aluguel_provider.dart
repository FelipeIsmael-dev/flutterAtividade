import 'package:flutteratividade/models/aluguel.dart';
import 'package:flutteratividade/models/chuteira.dart';
import 'package:flutter/material.dart';

// Cuida da reserva (antes de confirmar) e dos aluguéis que já estão com o cliente
class AluguelProvider extends ChangeNotifier {
  final List<Aluguel> _reserva = [];
  final List<Aluguel> _ativos = [];

  List<Aluguel> get reserva => _reserva;
  List<Aluguel> get ativos => _ativos;

  int get quantidadeNaReserva => _reserva.length;

  double get totalReserva {
    return _reserva.fold(0, (soma, item) => soma + item.total);
  }

  void adicionarNaReserva(Chuteira chuteira, int tamanho, int dias) {
    _reserva.add(Aluguel(chuteira: chuteira, tamanho: tamanho, dias: dias));
    notifyListeners();
  }

  void removerDaReserva(Aluguel aluguel) {
    _reserva.remove(aluguel);
    notifyListeners();
  }

  void aumentarDias(Aluguel aluguel) {
    aluguel.dias++;
    notifyListeners();
  }

  void diminuirDias(Aluguel aluguel) {
    if (aluguel.dias > 1) {
      aluguel.dias--;
      notifyListeners();
    }
  }

  // Passa tudo da reserva para a lista de aluguéis ativos
  void confirmarAluguel() {
    _ativos.addAll(_reserva);
    _reserva.clear();
    notifyListeners();
  }

  void devolver(Aluguel aluguel) {
    _ativos.remove(aluguel);
    notifyListeners();
  }
}
