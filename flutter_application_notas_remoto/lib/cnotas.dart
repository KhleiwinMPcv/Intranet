import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_notas_remoto/clases/alumno.dart';
import 'package:flutter_application_notas_remoto/clases/curso.dart';
import 'package:flutter_application_notas_remoto/clases/menu.dart';
import 'package:flutter_application_notas_remoto/pagnota.dart';
import 'package:http/http.dart' as http;

class Cnotas extends StatefulWidget {
  const Cnotas({super.key});

  @override
  State<Cnotas> createState() => _CnotasState();
}

class _CnotasState extends State<Cnotas> {
  List<Curso> doclis = [];
  List lisnota = [];
  String _selectedvalue = "";

  // Lista de cursos
  Future<void> getCurso() async {
    final response = await http.get(Uri.parse(
        "http://192.168.2.108/ServidorNotas/controla.php?tag=consulta3"));

    if (response.statusCode == 200) {
      setState(() {
        var resp = jsonDecode(response.body);
        List<dynamic> liscurso = resp["dato"];
        doclis = liscurso
            .map((item) => Curso(codc: item['codc'], nomc: item['nomc']))
            .toList();
        _selectedvalue = doclis[0].codc;
      });
    } else {
      print('Error en la carga de datos');
    }
  }

  // Lista de notas
  Future<void> getNotas(String id) async {
    final response = await http.get(Uri.parse(
        "http://192.168.2.108/ServidorNotas/controla.php?tag=consulta5&codc=$id"));

    if (response.statusCode == 200) {
      setState(() {
        var resp = jsonDecode(response.body);
        lisnota = resp["dato"];
      });
    } else {
      print('Error en la carga de datos');
    }
  }

  @override
  void initState() {
    super.initState();
    getCurso();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 25, 37, 206),
        foregroundColor: Color.fromARGB(255, 235, 234, 238),
        centerTitle: true,
        title: Text('ALUMNOS POR CURSO'),
      ),
      body: Center(
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedvalue,
              hint: Text('Seleccione curso'),
              onChanged: (valor) {
                setState(() {
                  _selectedvalue = valor!;
                  getNotas(_selectedvalue);
                });
              },
              items: doclis.map((item) {
                return DropdownMenuItem<String>(
                  value: item.codc,
                  child: Text(item.nomc),
                );
              }).toList(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: lisnota.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                        '${lisnota[index]['ape']}, ${lisnota[index]['nom']}'),
                    subtitle: Text("Código: ${lisnota[index]['coda']}"),
                    trailing: ElevatedButton.icon(
                      icon: Icon(Icons.note),
                      label: Text('Ver Nota'),
                      onPressed: () {
                        Alumno alu = Alumno();
                        alu.coda = lisnota[index]['coda'];
                        alu.ape = lisnota[index]['ape'];
                        alu.noma = lisnota[index]['nom'];
                        alu.exp = int.parse(lisnota[index]['ep']);
                        alu.exf = int.parse(lisnota[index]['ef']);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyNota(alu)),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20), // Espacio entre la imagen y el botón
            ElevatedButton(
              style: TextButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 0, 0, 0),
                backgroundColor: Color.fromARGB(255, 82, 187, 61),
                padding: EdgeInsets.all(10),
              ),
              onPressed: () {
                runApp(MainApp()); // Retorna a la pantalla inicial
              },
              child: Text('MENÚ PRINCIPAL'),
            ),
          ],
        ),
      ),
    );
  }
}
