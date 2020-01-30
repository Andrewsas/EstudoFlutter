import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transferências',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Transferências'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListaTransferencia(),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controllerConta = TextEditingController();
  final TextEditingController _controllerValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferência'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Editor(
              controller: _controllerConta,
              rotulo: 'Numéro da conta',
              dica: '0000'),
          Editor(
              controller: _controllerValor,
              rotulo: 'Valor',
              dica: '00.0',
              icon: Icons.monetization_on),
          RaisedButton(
            child: Text('Confirmar'),
            onPressed: () => _criaTransferencia(context),
          ),
        ],
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int numeroConta = int.tryParse(_controllerConta.text);
    final double numeroValor = double.tryParse(_controllerValor.text);
    if (numeroConta != null && numeroValor != null) {
      final transferenciaCriada =
          Transferencia(numeroValor, numeroConta);
          Navigator.pop(context, transferenciaCriada);
    }
  }
}

class Editor extends StatelessWidget {
  final String rotulo;
  final String dica;
  final IconData icon;
  TextEditingController controller = TextEditingController();

  Editor({this.controller, this.rotulo, this.dica, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          labelText: rotulo,
          hintText: dica,
          icon: icon !=  null ? Icon(icon) : null,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListaTransferencia extends StatefulWidget {

  final List<Transferencia> _transferecias = List();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Trasnferências'),
      ),
      body: ListView.builder(
        itemCount: _transferecias.length,
        itemBuilder: (context, indece) {
          final transference =  _transferecias[indece];
          return ItemTransferencia(transference);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Transferencia> future = Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return FormularioTransferencia();
            }
          ));
          future.then((transferenciaRecebida) {
            debugPrint('Chegou no then do future');
            debugPrint('$transferenciaRecebida');
            _transferecias.add(transferenciaRecebida);
          });
        },
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.conta.toString()),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int conta;

  Transferencia(this.valor, this.conta);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, conta: $conta}';
  }
}
