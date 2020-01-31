import 'package:flutter/material.dart';

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
          icon: icon != null ? Icon(icon) : null,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
