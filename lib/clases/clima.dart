
class Clima {
  final String ciudad;
  final double temperatura;
  final String descripcion;
  final double velocidadViento;

  Clima({
    required this.ciudad,
    required this.temperatura,
    required this.descripcion,
    required this.velocidadViento,
  });

  factory Clima.fromJson(Map<String, dynamic> json) {
    return Clima(
      ciudad: json['name'],
      temperatura: json['main']['temp'].toDouble(),
      descripcion: json['weather'][0]['description'],
      velocidadViento: json['wind']['speed'].toDouble(),
    );
  }
}

