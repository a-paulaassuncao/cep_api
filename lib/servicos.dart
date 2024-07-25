import 'dart:convert';

import 'package:http/http.dart' as http;

class CepServico {
  static Future<Map<String, dynamic>?> buscaEnderecoPorCep(String cep) async {
    final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');
    final resposta = await http.get(url);
    if (resposta.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(resposta.body);

      if (data.containsKey('erro') && data['erro'] == true) {
        return null;
      }
      return data;
    }else {
      return null;
    }
  }
}