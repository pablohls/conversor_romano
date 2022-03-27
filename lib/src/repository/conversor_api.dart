import 'package:dio/dio.dart';

class ConversorApiRepository {
  final dio = Dio();
  final url = "https://romans.justyy.workers.dev/api/romans/?cached&n=";

  Future<String> fetchData(String valor) async {
    String resultado = "";
    final response = await dio.get(url + valor);
    resultado = response.data["result"].toString();
    return resultado;
  }
}
