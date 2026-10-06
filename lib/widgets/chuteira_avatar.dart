import 'package:flutter/material.dart';

// Bolinha colorida com ícone de bola. A cor muda de acordo com o tipo da chuteira.
class ChuteiraAvatar extends StatelessWidget {
  final String tipo;
  final double tamanho;

  const ChuteiraAvatar({super.key, required this.tipo, this.tamanho = 22});

  Color _corDoTipo() {
    if (tipo == 'Campo') return Colors.green;
    if (tipo == 'Society') return Colors.orange;
    return Colors.blue; // Futsal
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: tamanho,
      backgroundColor: _corDoTipo(),
      child: Icon(Icons.sports_soccer, color: Colors.white, size: tamanho),
    );
  }
}
