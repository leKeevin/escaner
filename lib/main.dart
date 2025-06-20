import 'package:escaner/views/camara.dart';
import 'package:escaner/views/imagen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
      ),
      home:
          // Camara()
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey,
              title: Text("Escaner de Imaganes"),
            ),
            body: Column(
              children: [
                // Image.network('https://i.imgflip.com/p0a19.jpg'),
                // ImagenDesdeArchivo(),
                SizedBox(height: 20),
                CamaraSelector(),
                SizedBox(height: 20),
                ImagenSelector(),
              ],
            ),
          ),
    );
  }
}

class CamaraSelector extends StatelessWidget {
  const CamaraSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Camara()),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 240, 240, 240),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0,3,), // Cambia esto para ajustar la dirección de la sombra
            ),
          ],
        ),
        child: Center(
          child: Column(
            children: [
              Text("Tomar desde la camara", style: TextStyle(fontSize: 24)),
              Icon(Icons.camera_alt, size: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class ImagenSelector extends StatelessWidget {
  const ImagenSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Imagen()),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 240, 240, 240),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Column(
            children: [
              Text("Seleccionar imagen", style: TextStyle(fontSize: 24)),
              Icon(Icons.photo, size: 30),
            ],
          ),
        ),
      ),
    );
  }
}
