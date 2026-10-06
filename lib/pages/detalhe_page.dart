import 'package:flutteratividade/models/chuteira.dart';
import 'package:flutteratividade/providers/aluguel_provider.dart';
import 'package:flutteratividade/providers/chuteira_provider.dart';
import 'package:flutteratividade/utils/formatar.dart';
import 'package:flutteratividade/widgets/chuteira_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetalhePage extends StatefulWidget {
  final Chuteira chuteira;

  const DetalhePage({super.key, required this.chuteira});

  @override
  State<DetalhePage> createState() => _DetalhePageState();
}

class _DetalhePageState extends State<DetalhePage> {
  final List<int> tamanhos = [36, 37, 38, 39, 40, 41, 42, 43, 44];

  // Estado local: só importa para esta tela, então não precisa de Provider
  int? tamanhoEscolhido;
  int dias = 1;

  void adicionarNaReserva() {
    context.read<AluguelProvider>().adicionarNaReserva(widget.chuteira, tamanhoEscolhido!, dias);
    context.read<ChuteiraProvider>().retirarDoEstoque(widget.chuteira);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.chuteira.nome} adicionada à reserva!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // watch para a tela atualizar se o estoque mudar
    context.watch<ChuteiraProvider>();
    final chuteira = widget.chuteira;
    final podeAdicionar = chuteira.estoque > 0 && tamanhoEscolhido != null;

    return Scaffold(
      appBar: AppBar(title: Text(chuteira.nome)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: ChuteiraAvatar(tipo: chuteira.tipo, tamanho: 60)),
            const SizedBox(height: 16),
            Center(
              child: Text(
                chuteira.nome,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Center(child: Text('${chuteira.marca} • ${chuteira.tipo}')),
            const SizedBox(height: 8),
            Center(
              child: Text(
                '${formatarPreco(chuteira.precoDiaria)} por dia',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Center(
              child: Text(
                chuteira.estoque > 0
                    ? '${chuteira.estoque} par(es) disponível(is)'
                    : 'Sem estoque no momento',
                style: TextStyle(color: chuteira.estoque > 0 ? Colors.green[700] : Colors.red),
              ),
            ),
            const Divider(height: 32),

            const Text('Escolha o tamanho:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: tamanhos.map((t) {
                return ChoiceChip(
                  label: Text('$t'),
                  selected: tamanhoEscolhido == t,
                  onSelected: (_) {
                    setState(() {
                      tamanhoEscolhido = t;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            const Text('Por quantos dias?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: dias > 1
                      ? () {
                          setState(() {
                            dias--;
                          });
                        }
                      : null,
                ),
                Text('$dias', style: const TextStyle(fontSize: 20)),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {
                    setState(() {
                      dias++;
                    });
                  },
                ),
                const Spacer(),
                Text(
                  'Total: ${formatarPreco(chuteira.precoDiaria * dias)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add_shopping_cart),
                label: Text(chuteira.estoque > 0 ? 'Adicionar à reserva' : 'Esgotada'),
                onPressed: podeAdicionar ? adicionarNaReserva : null,
              ),
            ),
            if (tamanhoEscolhido == null && chuteira.estoque > 0)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Center(child: Text('Selecione um tamanho para continuar')),
              ),
          ],
        ),
      ),
    );
  }
}
