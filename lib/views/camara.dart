import 'dart:io';
import 'package:escaner/provider/imagenes_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Camara extends StatefulWidget {
  const Camara({super.key});

  @override
  State<Camara> createState() => _CamaraState();
}

class _CamaraState extends State<Camara> {
  File? imagen0;
  File? imagenProcesada;

  Future<void> tomarFoto() async {
    final picker = ImagePicker();
    final imagen = await picker.pickImage(source: ImageSource.camera);

    if (imagen != null) {
      setState(() {
        imagen0 = File(imagen.path);
      });
    }
  }

  void recortarImagen() async {
    final img = imagen0;

    if (img != null) {
      final bytes = await ImagenesProvider().recortaImagen(context,File(img.path));
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
    final img = imagen0;

    if (img != null) {
      final pdfFile = await ImagenesProvider().recortaImagenPdf(context,File(img.path));
      if (pdfFile != null) {
        // print('PDF guardado en: ${pdfFile.path}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Usar Cámara")),
      body: ListView(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                ElevatedButton(onPressed: tomarFoto, child: Text("Tomar foto")),
                SizedBox(height: 10),
                if (imagen0 != null)
                  Padding(
                    padding: EdgeInsetsGeometry.all(10),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Image.file(imagen0!,height: 200,),
                        SizedBox(height: 10),
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

// class _CamaraState extends State<Camara> {
//   File? _imagen;

//   Future<void> _tomarFoto() async {
//     final picker = ImagePicker();
//     final imagen = await picker.pickImage(source: ImageSource.camera);

//     if (imagen != null) {
//       setState(() {
//         _imagen = File(imagen.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Usar Cámara")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _imagen != null
//               ? Image.file(_imagen!, height: 200)
//               : Text("No hay imagen"),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _tomarFoto,
//               child: Text("Tomar foto"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
