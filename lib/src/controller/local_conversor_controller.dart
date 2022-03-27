import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  final RegExp _regexp = RegExp(
      r'^(M{0,65})(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$',
      caseSensitive: false);

  final _numerosRomanosLetras = {
    1: 'I',
    4: 'IV',
    5: 'V',
    9: 'IX',
    10: 'X',
    40: 'XL',
    50: 'L',
    90: 'XC',
    100: 'C',
    400: 'CD',
    500: 'D',
    900: 'CM',
    1000: 'M'
  };

  final _letrasRomanasNumeros = {
    'N': 0,
    'I': 1,
    'V': 5,
    'X': 10,
    'L': 50,
    'C': 100,
    'D': 500,
    'M': 1000
  };

  final TextEditingController _arabeController = TextEditingController();
  final TextEditingController _romanoController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey {
    return _formKey;
  }

  TextEditingController controller(String tipo) {
    if (tipo == "Arabe") {
      return _arabeController;
    }
    return _romanoController;
  }

  validador(String tipo, String valor) {
    // ignore: prefer_typing_uninitialized_variables
    var mensagem;
    (tipo == "Arabe")
        ? mensagem = validadorCampoArabico(valor)
        : mensagem = validadorCampoRomano(valor);
    return mensagem;
  }

  converter(String tipo, String valor) {
    (tipo == "Arabe") ? converterArabico(valor) : converterRomano(valor);
  }

  validadorCampoArabico(String valor) {
    if (valor.isEmpty) {
      return null;
    } else {
      int n = int.tryParse(valor)!;
      if (n < 66000) {
        return null;
      } else {
        return "Valor inválido";
      }
    }
  }

  converterArabico(String valor) {
    if (valor.isNotEmpty) {
      int n = int.tryParse(valor)!;
      _romanoController.text = toRomano(n);
      _formKey.currentState!.validate();
    } else {
      _romanoController.clear();
      _formKey.currentState!.validate();
    }
    notifyListeners();
  }

  validadorCampoRomano(String valor) {
    if (!_regexp.hasMatch(valor)) {
      _arabeController.text = "";
      notifyListeners();
      return "Expressão inválida";
    } else {
      return null;
    }
  }

  converterRomano(String valor) {
    if (valor.isNotEmpty) {
      _arabeController.text = toNumeral(valor);
      _formKey.currentState!.validate();
    } else {
      _arabeController.clear();
      _formKey.currentState!.validate();
    }
    notifyListeners();
  }

  String toRomano(int valor) {
    if (valor > 0 && valor < 66000) {
      final listaValores = _numerosRomanosLetras.keys.toList();
      listaValores.sort((a, b) => b.compareTo(a));
      var resultado = "";
      var nIndex = 0;
      while (valor > 0) {
        var divisor = listaValores[nIndex];
        var unidade = valor ~/ divisor;
        if (unidade > 0) {
          var valorLista = _numerosRomanosLetras[divisor];
          if (valorLista != null) {
            resultado += valorLista;
            valor -= divisor;
          }
        } else {
          nIndex += 1;
        }
      }
      return resultado;
    } else {
      return "";
    }
  }

  String toNumeral(String valor) {
    final valorUp = valor.toUpperCase();
    var resultado = 0;
    var valorMax = 0;
    var valorAtual = 0;
    valorUp.split('').reversed.forEach((element) {
      var valorLista = _letrasRomanasNumeros[element];
      if (valorLista != null) {
        valorAtual = valorLista;
        if (valorAtual >= valorMax) {
          resultado += valorAtual;
          valorMax = valorAtual;
        } else {
          resultado -= valorAtual;
        }
      }
    });
    return resultado.toString();
  }

  clean() {
    _arabeController.clear();
    _romanoController.clear();
    _formKey.currentState!.validate();
  }
}
