import 'package:converter/src/view/api_conversor_view/widgets/api_card_customizado.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/api_conversor_controller.dart';

class ApiConversorPage extends StatelessWidget {
  const ApiConversorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ApiConversorController>();
    return Scaffold(
      appBar: AppBar(title: const Text("Conversor")),
      body: Form(
        key: controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: ApiCardCustomizado(controller: controller),
            ),
            // ignore: prefer_const_constructors
            ElevatedButton(
                onPressed: controller.converter(),
                child: const Text("Converter")),
            SizedBox(
              height: 100,
              width: 250,
              child: Card(
                elevation: 20,
                child:
                    Center(child: Text("Resultado:\n${controller.resultado}")),
              ),
            )
          ],
        ),
      ),
    );
  }
}
