import 'package:flutter/material.dart';
import 'package:flutter_application_notas_remoto/clases/alumno.dart';

// void main() => runApp(const MyNota());

class MyNota extends StatefulWidget {
  final Alumno alu;
  const MyNota(this.alu, {super.key});

  @override
  State<MyNota> createState() => _MyNotaState();
}

class _MyNotaState extends State<MyNota> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 12, 65, 211),
        foregroundColor: Color.fromARGB(255, 222, 222, 226),
        centerTitle: true,
        title: Text('NOTAS DEL ALUMNO'),
      ),
      body: Container(
        child: Column(
          children: [
            Text('Apellido y Nombre: ' + widget.alu.ape + widget.alu.noma),
            Divider(),
            Text('Promedio: ' + widget.alu.promedio().toStringAsFixed(2)),
            Divider(),
            Text('Observación: ' + widget.alu.obser()),
            Divider(),
            ClipOval(
              child: Image.network(
                "http://192.168.2.108/servidorNotas/fotos/${widget.alu.coda}.jpg",
                errorBuilder: (BuildContext context, Object execption,
                    StackTrace? StackTrace) {
                  return Image.asset('assets/sin_foto.jpg');
                },
                width: 200,
                height: 200,
                fit: BoxFit
                    .cover, // toma todo el espacio del contenedor como un strech
              ),
            ),
            SizedBox(height: 20), // Espacio entre la imagen y el botón
            ElevatedButton(
              style: TextButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 22, 21, 129),
                backgroundColor: Color.fromARGB(255, 82, 187, 61),
                padding: EdgeInsets.all(10),
              ),
              onPressed: () {
                Navigator.pop(context); // Retorna a la pantalla anterior
              },
              child: Text('RETORNAR'),
            ),
          ],
        ),
      ),
    );
  }
}
