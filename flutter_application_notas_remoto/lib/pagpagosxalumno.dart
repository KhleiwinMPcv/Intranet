import 'package:flutter/material.dart';
import 'package:flutter_application_notas_remoto/clases/menu.dart';

import 'package:flutter_application_notas_remoto/clases/pago.dart';
import 'package:flutter_application_notas_remoto/cnotas.dart';
import 'package:flutter_application_notas_remoto/pagnotaxalumno.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PagPagosxAlumno extends StatefulWidget {
  @override
  _PagPagosxAlumnoState createState() => _PagPagosxAlumnoState();
}

class _PagPagosxAlumnoState extends State<PagPagosxAlumno> {
  final TextEditingController _controller = TextEditingController();
  List<Pago> _pagos = [];
  bool _isLoading = false;

  Future<void> _fetchPagos(String id) async {
    setState(() {
      _isLoading = true;
      _pagos = []; // Limpiar resultados anteriores
    });

    try {
      final response = await http.get(Uri.parse(
        "http://192.168.2.108/ServidorNotas/controla.php?tag=consulta2&coda=$id",
      ));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['dato'] != null && (data['dato'] as List).isNotEmpty) {
          final List<Pago> fetchedPagos = (data['dato'] as List)
              .map((pago) => Pago.fromJson(pago))
              .toList();

          setState(() {
            _pagos = fetchedPagos;
          });
        } else {
          _showDialog('El alumno no tiene pagos registrados');
        }
      } else {
        print('Error en la carga de datos');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Información'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Color.fromARGB(255, 228, 228, 235),
        backgroundColor: Color.fromARGB(255, 131, 12, 47),
        title: Text('CONSULTA PAGOS '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Ingrese Código del Alumno',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 21, 32, 129),
                  backgroundColor: Color.fromARGB(255, 61, 168, 187),
                  padding: EdgeInsets.all(10),
                ),
                onPressed: () {
                  _fetchPagos(_controller.text);
                },
                child: Text('CONSULTAR PAGOS'),
              ),
            ),
            SizedBox(height: 16),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : _pagos.isEmpty
                    ? Text('El alumno no tiene pagos registrados')
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var pago in _pagos)
                                Card(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Ciclo: ${pago.ciclo}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 8),
                                        Text('Fecha: ${pago.fecha}'),
                                        SizedBox(height: 8),
                                        Text('Monto: ${pago.monto}'),
                                      ],
                                    ),
                                  ),
                                ),
                              SizedBox(height: 8),
                              Text(
                                  'Pago total: ${_pagos.isEmpty ? 0 : _pagos[0].pagoTotal(_pagos)}'),
                            ],
                          ),
                        ),
                      ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height:
                          20), // Espacio entre el contenido anterior y el botón
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color.fromARGB(255, 2, 2, 2),
                      backgroundColor: Color.fromARGB(255, 109, 199, 24),
                      padding: EdgeInsets.all(10),
                    ),
                    onPressed: () {
                      runApp(const MainApp()); // Retorna al menú principal
                    },
                    child: Text('MENÚ PRINCIPAL'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
