
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../clases/clima.dart';

class ServicioClima {
  final String _apiKey = '29aeeac1399ed157c02c63c6738fa696'; 
  final String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<Clima> obtenerClima(String ciudad) async {
    final url = Uri.parse('$_baseUrl/weather?q=$ciudad&units=metric&appid=$_apiKey');
    final respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      final datos = jsonDecode(respuesta.body);
      return Clima.fromJson(datos);
    } else {
      throw Exception('No se pudo obtener el clima de $ciudad');
    }
  }
}

