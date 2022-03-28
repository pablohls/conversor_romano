import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:converter/src/controller/local_conversor_controller.dart';

import 'widgets/card_customizado.dart';

class LocalConversorPage extends StatelessWidget {
  const LocalConversorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<LocalConversorController>();
    return Scaffold(
      appBar: AppBar(title: const Text("Conversor")),
      body: Form(
        key: controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardCustomizado(
              tipo: "Arabe",
              controller: controller,
              inputFormater: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              labelTexto: "Algarismos arábicos",
              helperTexto:
                  "*Campo so aceita numeros de 0-9, com valor maximo de 65999.",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Transform.rotate(
                angle: 95,
                child: const Icon(
                  Icons.compare_arrows_rounded,
                  size: 35,
                ),
              ),
            ),
            CardCustomizado(
              tipo: "Romano",
              controller: controller,
              inputFormater: const [],
              labelTexto: "Algarismos romanos",
              helperTexto:
                  "*Inserir apenas algarismos romanos e em ordem válida.",
            ),
          ],
        ),
      ),
    );
  }
}
