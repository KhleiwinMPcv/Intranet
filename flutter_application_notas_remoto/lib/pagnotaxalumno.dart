import 'package:flutter/material.dart';
import 'package:flutter_application_notas_remoto/clases/menu.dart';
import 'package:flutter_application_notas_remoto/clases/nota.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PagNotasxAlumno extends StatefulWidget {
  @override
  _PagNotasxAlumnoState createState() => _PagNotasxAlumnoState();
}

class _PagNotasxAlumnoState extends State<PagNotasxAlumno> {
  final TextEditingController _controller = TextEditingController();
  List<Nota> _notas = [];
  bool _isLoading = false;

  Future<void> _fetchNotas(String id) async {
    setState(() {
      _isLoading = true;
      _notas = [];
    });

    try {
      final response = await http.get(Uri.parse(
        "http://192.168.2.108/ServidorNotas/controla.php?tag=consulta1&coda=$id",
      ));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['dato'] != null && (data['dato'] as List).isNotEmpty) {
          final List<Nota> fetchedNotas = (data['dato'] as List)
              .map((nota) => Nota.fromJson(nota))
              .toList();

          setState(() {
            _notas = fetchedNotas;
          });
        } else {
          _showDialog('Alumno no existe');
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
        title: Text('CONSULTA NOTAS '),
        backgroundColor: Color.fromARGB(255, 156, 79, 28),
        foregroundColor: Color.fromARGB(255, 19, 18, 18),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Ingrese Código del Alumno A....',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                style: TextButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 73, 21, 5),
                  backgroundColor: Color.fromARGB(255, 61, 168, 187),
                  padding: EdgeInsets.all(10),
                ),
                onPressed: () {
                  _fetchNotas(_controller.text);
                },
                child: Text('CONSULTAR '),
              ),
            ),
            SizedBox(height: 16),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : _notas.isEmpty
                    ? Text(
                        'Colsulte el codigo de alumno en este formato A0001 o numero que desea consultar ')
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _notas.map((nota) {
                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Curso: ${nota.nomc}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                          'Examen Parcial: ${nota.ep.toString()}'),
                                      SizedBox(height: 8),
                                      Text(
                                          'Examen Final: ${nota.ef.toString()}'),
                                      SizedBox(height: 8),
                                      Text(
                                          'Promedio: ${nota.promedio().toStringAsFixed(2)}'),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
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
                      foregroundColor: Color.fromARGB(255, 0, 0, 0),
                      backgroundColor: Color.fromARGB(255, 82, 187, 61),
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
