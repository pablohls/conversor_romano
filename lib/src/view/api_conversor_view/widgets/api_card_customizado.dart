import 'package:flutter/material.dart';

import '../../../controller/api_conversor_controller.dart';

class ApiCardCustomizado extends StatelessWidget {
  const ApiCardCustomizado({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ApiConversorController controller;

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
                controller: controller.inputController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 25),
                  label: Text("Campo do Valor"),
                  helperText:
                      " Informe um valor numerico de 1 a 65999 ou uma\n combinação válida de algarismos romanos.",
                  helperStyle:
                      TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                ),
                validator: (valor) => controller.validador(),
                onChanged: (valor) => controller.validar(valor)),
          ),
        ),
        IconButton(
          onPressed: () {
            controller.clean();
          },
          icon: const Icon(Icons.clear),
        )
      ]),
    );
  }
}
