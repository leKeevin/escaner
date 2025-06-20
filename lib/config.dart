import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as p;

class ConfiguracionApp {
  late File _archivoConfig;

  ConfiguracionApp() {
    final home = Platform.environment['HOME']!;
    _archivoConfig = File(p.join(home, '.mi_app_config.json'));
  }

  Future<void> guardarRuta(String ruta) async {
    final config = {'directorio_guardado': ruta};
    await _archivoConfig.writeAsString(jsonEncode(config));
  }

  Future<String?> cargarRuta() async {
    if (await _archivoConfig.exists()) {
      final contenido = await _archivoConfig.readAsString();
      final data = jsonDecode(contenido);
      return data['directorio_guardado'];
    }
    return null;
  }
}
