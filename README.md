# Aluga Chuteira

App de aluguel de chuteiras feito com **Flutter** e **Provider** para gerenciamento de estado.

## Funcionalidades

- Catálogo de chuteiras com filtro por tipo (Campo, Society, Futsal)
- Tela de detalhes para escolher o tamanho e quantos dias alugar
- Reserva: aumentar/diminuir dias, remover itens e ver o total
- Confirmar o aluguel e ver em "Meus aluguéis"
- Devolver a chuteira (volta para o estoque)

## Estrutura

```
lib/
├── main.dart                     # MultiProvider com os dois providers
├── models/
│   ├── chuteira.dart             # nome, marca, tipo, preço da diária, estoque
│   └── aluguel.dart              # chuteira + tamanho + dias
├── providers/
│   ├── chuteira_provider.dart    # catálogo, filtro e estoque
│   └── aluguel_provider.dart     # reserva e aluguéis ativos
├── pages/
│   ├── catalogo_page.dart
│   ├── detalhe_page.dart
│   ├── reserva_page.dart
│   └── meus_alugueis_page.dart
├── widgets/
│   └── chuteira_avatar.dart
└── utils/
    └── formatar.dart
```

## Como o Provider foi usado

- `ChuteiraProvider` e `AluguelProvider` estendem `ChangeNotifier` e chamam
  `notifyListeners()` sempre que mudam alguma coisa (filtro, estoque, reserva, dias...).
- Os dois são registrados no `main.dart` com `MultiProvider`, então todas as páginas
  enxergam o mesmo estado.
- Estado compartilhado entre páginas: o estoque aparece no catálogo e no detalhe; a
  reserva aparece no ícone (badge) do catálogo e na página de reserva; os aluguéis
  confirmados aparecem em "Meus aluguéis".
- Formas de acessar o Provider usadas no projeto:
  - `context.watch<T>()` para ler e reconstruir a tela quando o estado muda;
  - `context.read<T>()` e `Provider.of<T>(context, listen: false)` dentro de botões;
  - `Consumer<T>` para reconstruir só o ícone da reserva na AppBar.
- O tamanho e os dias na tela de detalhes são estado local (`setState`), porque só
  importam para aquela tela.

## Como rodar

```bash
flutter pub get
flutter run
flutter test
```
