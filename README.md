# MyEnergy
MyEnergy é um aplicativo móvel projetado para ajudar os usuários a gerenciar seu consumo de eletricidade de forma eficiente. Ele permite que os usuários registrem dispositivos eletrônicos, registrem seu tempo de uso e calculem custos com base em tarifas regionais de energia. O aplicativo fornece um painel amigável com insights sobre consumo de energia e despesas, ajudando os usuários a tomar decisões informadas para reduzir sua pegada energética e economizar dinheiro.

## Recursos
- Registrar dispositivos manualmente.
- Registrar o tempo de uso do dispositivo e calcular o consumo.
- Personalizar tarifas regionais de energia.
- Visualizar um painel detalhado com estatísticas de consumo e rastreamento de despesas.

## Stack
### Front-end
- [Flutter](https://flutter.dev/) (Dart) 3.24.5: Framework de desenvolvimento de aplicativos multiplataforma.
- [Modular](https://pub.dev/packages/flutter_modular) 6.3.4: Gerenciamento de estado e injeção de dependência.
- [MobX](https://pub.dev/packages/mobx) 2.4.0: Gerenciamento de estado reativo.

### Banco de Dados
- [Floor](https://pub.dev/packages/floor) 1.5.0: ORM para SQLite.

## Arquitetura
O projeto adota um padrão de design modular, promovendo alta coesão e baixo acoplamento ao organizar o aplicativo em módulos autocontidos e orientados a recursos. Isso garante escalabilidade, testabilidade e facilidade de manutenção conforme o aplicativo evolui.

## Instalação
Para rodar o projeto, é necessário ter o Flutter instalado. Para isso, siga as instruções disponíveis na [documentação oficial](https://flutter.dev/docs/get-started/install).

Após instalar o Flutter, clone o repositório e instale as dependências do projeto:
```bash
git clone https://github.com/LosSantosBoys/gs-2024.git
cd gs-2024

flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

Para rodar o projeto, execute o seguinte comando:
```bash
flutter run
```

## Roadmap
- Adicionar suporte para adição de dispositivos via bluetooth.
- Adicionar sistema de notificações para alertar usuários sobre consumo excessivo.
- Adicionar suporte para múltiplos usuários.
- Adicionar suporte para múltiplas residências.
- Adicionar suporte para múltiplas tarifas de energia.
- Adicionar suporte para múltiplas moedas.
- Adicionar suporte para múltiplos idiomas.
- Adicionar suporte para exportação de dados.
- Adicionar sistema de clima para previsão de consumo.

## Documentação
Para ler a documentação do projeto, é necessário rodar alguns comandos:
```bash
dart doc .
```

```bash
dart pub global activate dhttpd
```

```bash
dart pub global run dhttpd --path doc/api
```

Após rodar esses comandos, você poderá acessar a documentação do projeto em http://localhost:8080.

## Licença
Este projeto é licenciado sob a licença GNU GPL v2.0. Consulte o arquivo [LICENSE](LICENSE) para obter mais informações.

## Autores
- [Raul Andres](https://github.com/raul-andres-martinez)
- [Samuel Marques](https://github.com/samuel-s-marques)
