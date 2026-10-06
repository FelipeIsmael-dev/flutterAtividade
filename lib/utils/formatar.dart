// Transforma 25.0 em "R$ 25,00"
String formatarPreco(double valor) {
  return 'R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';
}
