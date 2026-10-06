import 'package:flutteratividade/providers/aluguel_provider.dart';
import 'package:flutteratividade/providers/chuteira_provider.dart';
import 'package:flutteratividade/utils/formatar.dart';
import 'package:flutteratividade/widgets/chuteira_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReservaPage extends StatelessWidget {
  const ReservaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final aluguelProvider = context.watch<AluguelProvider>();
    final reserva = aluguelProvider.reserva;

    return Scaffold(
      appBar: AppBar(title: const Text('Minha reserva')),
      body: reserva.isEmpty
          ? const Center(
              child: Text('Nenhuma chuteira na reserva ainda.', style: TextStyle(fontSize: 16)),
            )
          : ListView.builder(
              itemCount: reserva.length,
              itemBuilder: (context, index) {
                final item = reserva[index];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: ChuteiraAvatar(tipo: item.chuteira.tipo),
                          title: Text(item.chuteira.nome),
                          subtitle: Text(
                            'Tamanho ${item.tamanho} • ${formatarPreco(item.chuteira.precoDiaria)} / dia',
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              // Tira da reserva e devolve o par para o estoque
                              aluguelProvider.removerDaReserva(item);
                              context.read<ChuteiraProvider>().devolverAoEstoque(item.chuteira);
                            },
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => aluguelProvider.diminuirDias(item),
                            ),
                            Text('${item.dias} dia(s)'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => aluguelProvider.aumentarDias(item),
                            ),
                            const Spacer(),
                            Text(
                              formatarPreco(item.total),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      // Fica fixo embaixo; o SnackBar aparece acima dele sem cobrir o botão
      bottomNavigationBar: reserva.isEmpty
          ? null
          : SafeArea(
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total:', style: TextStyle(fontSize: 20)),
                        Text(
                          formatarPreco(aluguelProvider.totalReserva),
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          aluguelProvider.confirmarAluguel();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Aluguel confirmado! Bom jogo! ⚽')),
                          );
                          Navigator.pop(context);
                        },
                        child: const Text('Confirmar aluguel'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
