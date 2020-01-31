import 'package:flutter/material.dart';
import 'package:bank/components/editor.dart';
import 'package:bank/models/transferencia.dart';

class FormularioTransferencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controllerConta = TextEditingController();
  final TextEditingController _controllerValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferência'),
      ),
      body: SingleChildScrollView(
        child: Column(
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
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int numeroConta = int.tryParse(_controllerConta.text);
    final double numeroValor = double.tryParse(_controllerValor.text);
    if (numeroConta != null && numeroValor != null) {
      final transferenciaCriada = Transferencia(numeroValor, numeroConta);
      Navigator.pop(context, transferenciaCriada);
    }
  }
}
