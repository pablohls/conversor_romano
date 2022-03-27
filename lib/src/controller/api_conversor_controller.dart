import 'package:converter/src/repository/conversor_api.dart';
import 'package:flutter/material.dart';

enum ApiConversorEstado { esperando, parado, erro, ok }

class ApiConversorController extends ChangeNotifier {
  final RegExp _regexp = RegExp(
      r'^(M{0,65})(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$',
      caseSensitive: false);
  var _estado = ApiConversorEstado.parado;
  final _repository = ConversorApiRepository();
  final TextEditingController _inputController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _resultado = "";

  ApiConversorEstado get estado {
    return _estado;
  }

  set estado(ApiConversorEstado estado) {
    _estado = estado;
    notifyListeners();
  }

  TextEditingController get inputController {
    return _inputController;
  }

  GlobalKey<FormState> get formKey {
    return _formKey;
  }

  validar(String valor) {
    if (valor.isEmpty) {
      formKey.currentState!.validate();
      estado = ApiConversorEstado.parado;
    } else {
      estado = ApiConversorEstado.esperando;
      formKey.currentState!.validate();
    }
  }

  Function()? converter() {
    return (estado == ApiConversorEstado.ok)
        ? () {
            solicitar(inputController.text);
          }
        : null;
  }

  solicitar(String valor) async {
    var texto = valor.toUpperCase();
    _resultado = await _repository.fetchData(texto);
    notifyListeners();
  }

  String get resultado {
    return _resultado;
  }

  validador() {
    bool numero = checarNumero(_inputController.text);
    if (numero == true) {
      int valor = int.parse(inputController.text);
      if (valor < 66000) {
        _estado = ApiConversorEstado.ok;
        return null;
      } else {
        _estado = ApiConversorEstado.erro;
        return "Valor inválido";
      }
    } else {
      if (!_regexp.hasMatch(inputController.text)) {
        _estado = ApiConversorEstado.erro;
        return "Expressão inválida";
      } else {
        _estado = ApiConversorEstado.ok;
        return null;
      }
    }
  }

  bool checarNumero(String valor) {
    // ignore: unnecessary_null_comparison
    if (valor == null) {
      return false;
    }
    return int.tryParse(valor) != null;
  }

  clean() {
    _inputController.clear();
    _resultado = "";
    formKey.currentState!.validate();
    _estado = ApiConversorEstado.parado;
    notifyListeners();
  }
}
