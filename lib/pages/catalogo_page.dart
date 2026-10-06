import 'package:flutteratividade/pages/detalhe_page.dart';
import 'package:flutteratividade/pages/meus_alugueis_page.dart';
import 'package:flutteratividade/pages/reserva_page.dart';
import 'package:flutteratividade/providers/aluguel_provider.dart';
import 'package:flutteratividade/providers/chuteira_provider.dart';
import 'package:flutteratividade/utils/formatar.dart';
import 'package:flutteratividade/widgets/chuteira_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatalogoPage extends StatelessWidget {
  const CatalogoPage({super.key});

  static const List<String> tipos = ['Todos', 'Campo', 'Society', 'Futsal'];

  @override
  Widget build(BuildContext context) {
    final chuteiraProvider = context.watch<ChuteiraProvider>();
    final chuteiras = chuteiraProvider.chuteiras;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aluga Chuteira'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Meus aluguéis',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MeusAlugueisPage()),
              );
            },
          ),
          // Consumer só reconstrói o ícone quando a reserva muda
          Consumer<AluguelProvider>(
            builder: (context, aluguelProvider, child) {
              return IconButton(
                tooltip: 'Minha reserva',
                icon: Badge(
                  label: Text('${aluguelProvider.quantidadeNaReserva}'),
                  isLabelVisible: aluguelProvider.quantidadeNaReserva > 0,
                  child: const Icon(Icons.shopping_bag),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ReservaPage()),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filtro por tipo de chuteira
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: tipos.map((tipo) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(tipo),
                    selected: chuteiraProvider.filtro == tipo,
                    onSelected: (_) {
                      context.read<ChuteiraProvider>().mudarFiltro(tipo);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chuteiras.length,
              itemBuilder: (context, index) {
                final chuteira = chuteiras[index];
                final esgotada = chuteira.estoque == 0;

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: ChuteiraAvatar(tipo: chuteira.tipo),
                    title: Text(chuteira.nome),
                    subtitle: Text(
                      '${chuteira.marca} • ${chuteira.tipo}\n'
                      '${formatarPreco(chuteira.precoDiaria)} / dia',
                    ),
                    isThreeLine: true,
                    trailing: Text(
                      esgotada ? 'Esgotada' : '${chuteira.estoque} disp.',
                      style: TextStyle(
                        color: esgotada ? Colors.red : Colors.green[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalhePage(chuteira: chuteira),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
