
import 'package:flutter/material.dart';
import '../clases/clima.dart';
import 'servicio.dart';

class InterfazClima extends StatefulWidget {
  const InterfazClima({super.key});

  @override
  State<InterfazClima> createState() => _InterfazClimaState();
}

class _InterfazClimaState extends State<InterfazClima> {
  final ServicioClima _servicioClima = ServicioClima();
  final TextEditingController _controlCiudad = TextEditingController(text: 'Madrid');
  Clima? _clima;
  bool _cargando = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _obtenerClima();
  }

  Future<void> _obtenerClima() async {
    setState(() {
      _cargando = true;
      _error = null;
    });

    try {
      final clima = await _servicioClima.obtenerClima(_controlCiudad.text);
      setState(() {
        _clima = clima;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }

    setState(() {
      _cargando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clima en Tiempo Real')),
      body: RefreshIndicator(
        onRefresh: _obtenerClima,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextField(
              controller: _controlCiudad,
              decoration: const InputDecoration(labelText: 'Ciudad'),
              onSubmitted: (_) => _obtenerClima(),
            ),
            const SizedBox(height: 20),
            if (_cargando)
              const Center(child: CircularProgressIndicator())
            else if (_error != null)
              Text('Error: $_error', style: const TextStyle(color: Colors.red))
            else if (_clima != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ciudad: ${_clima!.ciudad}', style: const TextStyle(fontSize: 18)),
                  Text('Temperatura: ${_clima!.temperatura} °C'),
                  Text('Condición: ${_clima!.descripcion}'),
                  Text('Viento: ${_clima!.velocidadViento} m/s'),
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _obtenerClima,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
