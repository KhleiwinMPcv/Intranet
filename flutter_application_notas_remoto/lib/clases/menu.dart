import 'package:flutter/material.dart';
import 'package:flutter_application_notas_remoto/cnotas.dart';

import 'package:flutter_application_notas_remoto/pagnotaxalumno.dart';
import 'package:flutter_application_notas_remoto/pagpagosxalumno.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('MENÚ PRINCIPAL'),
          backgroundColor: Color.fromARGB(255, 134, 219, 138),
          foregroundColor: Color.fromARGB(255, 19, 18, 18),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: TextButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 229, 229, 235),
                  backgroundColor: Color.fromARGB(255, 9, 11, 156),
                  padding: EdgeInsets.all(10),
                ),
                onPressed: () {
                  runApp(MyAppcnotas());
                },
                child: const Text('NOTAS ALUMNOS EN UN CURSO'),
              ),
              ElevatedButton(
                style: TextButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 241, 241, 240),
                  backgroundColor: Color.fromARGB(255, 131, 99, 10),
                  padding: EdgeInsets.all(10),
                ),
                onPressed: () {
                  runApp(const MyAppNotas());
                },
                child: const Text('NOTAS DEL ALUMNO'),
              ),
              ElevatedButton(
                style: TextButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 228, 228, 235),
                  backgroundColor: Color.fromARGB(255, 131, 12, 47),
                  padding: EdgeInsets.all(10),
                ),
                onPressed: () {
                  runApp(const MyAppPagos());
                },
                child: const Text('PAGOS DEL ALUMNO'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyAppcnotas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NOTAS ALUMNOS EN UN CURSO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Cnotas(),
    );
  }
}

class MyAppNotas extends StatelessWidget {
  const MyAppNotas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NOTAS DEL ALUMNO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PagNotasxAlumno(),
    );
  }
}

class MyAppPagos extends StatelessWidget {
  const MyAppPagos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PAGOS DEL ALUMNO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PagPagosxAlumno(),
    );
  }
}
