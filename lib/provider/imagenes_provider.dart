import 'dart:typed_data';
import 'package:escaner/provider/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ImagenesProvider extends ChangeNotifier {
  Future<String> getDownloadPath(String filename) async {
    Directory? dir;

    if (Platform.isAndroid) {
      dir = Directory(
        '/storage/emulated/0/Download',
      ); // Ruta común para Descargas en Android
      if (!await dir.exists()) {
        dir = await getExternalStorageDirectory(); // Fallback
      }
    } else if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
      dir = await getDownloadsDirectory();
    }

    return '${dir?.path}/$filename';
  }

  String getNameFile(String path) {
    final routes = path.split('/');
    var file = routes[routes.length - 1];
    file = file.split('.')[0];
    // print("Nombre del archivo: ${file}");

    return file;
  }

  Future<File?> recortaImagen(BuildContext context ,File imgFile) async {
    final url = Uri.parse('${getBaseUrl()}/imagen-imagen');
    final mimeType = lookupMimeType(imgFile.path);
    final mimeSplit = mimeType?.split('/') ?? ['image', 'jpeg'];

    final request = http.MultipartRequest('POST', url)
      ..files.add(
        await http.MultipartFile.fromPath(
          'file',
          imgFile.path,
          contentType: MediaType(mimeSplit[0], mimeSplit[1]),
        ),
      );

    try {
      final streamedResponse = await request.send();
      if (streamedResponse.statusCode == 200) {
        final bytes = await streamedResponse.stream.toBytes();
        final name = getNameFile(imgFile.path);

        final path = await getDownloadPath('$name.jpg');
        final imageFile = File(path);
        await imageFile.writeAsBytes(bytes);
        return imageFile;
      }
      if (streamedResponse.statusCode == 422) {
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Error 422"),
            content: Text("El archivo enviado no es válido o está corrupto."),
            actions: [
              TextButton(
                child: Text("Aceptar"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      } else {
        print('Error en la respuesta: ${streamedResponse.statusCode}');
      }
    } catch (e) {
      print('Error al enviar imagen: $e');
    }

    return null;
  }

  Future<File?> recortaImagenPdf(BuildContext context ,File imgFile) async {
    final url = Uri.parse('${getBaseUrl()}/imagen-pdf');
    final mimeType = lookupMimeType(imgFile.path);
    final mimeParts = mimeType?.split('/') ?? ['image', 'jpeg'];

    final request = http.MultipartRequest('POST', url)
      ..files.add(
        await http.MultipartFile.fromPath(
          'file',
          imgFile.path,
          contentType: MediaType(mimeParts[0], mimeParts[1]),
        ),
      );

    try {
      final streamedResponse = await request.send();
      if (streamedResponse.statusCode == 200) {
        final bytes = await streamedResponse.stream.toBytes();
        final name = getNameFile(imgFile.path);

        final path = await getDownloadPath('$name.pdf');
        final pdfFile = File(path);
        await pdfFile.writeAsBytes(bytes);
        return pdfFile;
      }
      if (streamedResponse.statusCode == 422) {
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Error 422"),
            content: Text("El archivo enviado no es válido o está corrupto."),
            actions: [
              TextButton(
                child: Text("Aceptar"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      } 
      else {
        print('Error de servidor: ${streamedResponse.statusCode}');
      }
    } catch (e) {
      print('Error al enviar imagen o recibir PDF: $e');
    }

    return null;
  }
}
