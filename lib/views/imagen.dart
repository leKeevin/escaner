import 'dart:io';
import 'package:escaner/provider/imagenes_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class Imagen extends StatefulWidget {
  const Imagen({super.key});

  @override
  State<Imagen> createState() => _ImagenState();
}

class _ImagenState extends State<Imagen> {
  File? imagen;
  File? imagenProcesada;

  Future<void> seleccionarImagen() async {
    final picker = ImagePicker();
    final imagenSeleccionada = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagenSeleccionada != null) {
      imagen = File(imagenSeleccionada.path);
      setState(() {
        imagenProcesada = null;
      });
    }
  }

  void recortarImagen() async {
    final img = imagen;

    if (img != null) {
      final bytes = await ImagenesProvider().recortaImagen(
        context,
        File(img.path),
      );
      // if (bytes != null) print("No retorna vacio la API");
      if (bytes != null) {
        setState(() {
          imagenProcesada = bytes;
        });
        // print("Imagen cargada desde la API");
      }
    }
  }

  void recortarImagenPDF() async {
    final img = imagen;

    if (img != null) {
      final pdfFile = await ImagenesProvider().recortaImagenPdf(
        context,
        File(img.path),
      );
      if (pdfFile != null) {
        // print('PDF guardado en: ${pdfFile.path}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Row(children: [Text("Seleccion de imagen")])),
      body: ListView(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: seleccionarImagen,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [Icon(Icons.photo), Text('Seleccionar imagen')],
                  ),
                ),
                if (imagen != null)
                  Padding(
                    padding: EdgeInsetsGeometry.all(10),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Image.file(imagen!),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: recortarImagen,
                                child: Text("Recortar Imagen"),
                              ),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: recortarImagenPDF,
                                child: Text("Recortar y convertir a PDF"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                if (imagenProcesada != null)
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Image.file(imagenProcesada!),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
