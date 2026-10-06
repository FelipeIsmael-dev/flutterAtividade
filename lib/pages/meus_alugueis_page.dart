import 'package:flutteratividade/providers/aluguel_provider.dart';
import 'package:flutteratividade/providers/chuteira_provider.dart';
import 'package:flutteratividade/utils/formatar.dart';
import 'package:flutteratividade/widgets/chuteira_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MeusAlugueisPage extends StatelessWidget {
  const MeusAlugueisPage({super.key});

  @override
  Widget build(BuildContext context) {
    final aluguelProvider = context.watch<AluguelProvider>();
    final ativos = aluguelProvider.ativos;

    return Scaffold(
      appBar: AppBar(title: const Text('Meus aluguéis')),
      body: ativos.isEmpty
          ? const Center(
              child: Text('Você não tem chuteiras alugadas.', style: TextStyle(fontSize: 16)),
            )
          : ListView.builder(
              itemCount: ativos.length,
              itemBuilder: (context, index) {
                final aluguel = ativos[index];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: ChuteiraAvatar(tipo: aluguel.chuteira.tipo),
                    title: Text(aluguel.chuteira.nome),
                    subtitle: Text(
                      'Tamanho ${aluguel.tamanho} • ${aluguel.dias} dia(s)\n'
                      'Valor: ${formatarPreco(aluguel.total)}',
                    ),
                    isThreeLine: true,
                    trailing: OutlinedButton(
                      child: const Text('Devolver'),
                      onPressed: () {
                        aluguelProvider.devolver(aluguel);
                        Provider.of<ChuteiraProvider>(context, listen: false)
                            .devolverAoEstoque(aluguel.chuteira);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${aluguel.chuteira.nome} devolvida. Obrigado!')),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
