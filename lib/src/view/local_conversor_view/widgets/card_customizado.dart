import 'package:converter/src/controller/local_conversor_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardCustomizado extends StatelessWidget {
  const CardCustomizado({
    Key? key,
    required this.tipo,
    required this.controller,
    required this.inputFormater,
    required this.labelTexto,
    required this.helperTexto,
  }) : super(key: key);

  final String tipo;
  final LocalConversorController controller;
  final List<TextInputFormatter> inputFormater;
  final String labelTexto;
  final String helperTexto;

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      elevation: 15,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Expanded(
          child: Center(
            child: TextFormField(
              controller: controller.controller(tipo),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                label: Text(labelTexto),
                helperText: helperTexto,
                helperStyle:
                    const TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
              ),
              inputFormatters: inputFormater,
              validator: (valor) => controller.validador(tipo, valor!),
              onChanged: (valor) => controller.converter(tipo, valor),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            controller.clean();
            controller.formKey.currentState!.validate();
          },
          icon: const Icon(Icons.clear),
        )
      ]),
    );
  }
}
