import 'package:fh_productos_app/ENV.dart';
import 'package:fh_productos_app/model/producto_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../model/producto_add_model.dart';

class AddProductFormProvider extends ChangeNotifier {
  bool _disponible = true;
  double _precio = 123.3;
  String _nombre = 'prueba';
  List<XFile> _fotosSeleccionadas = [];
  List<String> _pathsImgs = [];
  bool _isValid = false;
  bool _deleting = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AddProductFormProvider();

  bool get disponible => _disponible;
  bool get isValid => _isValid;
  bool get deleting => _deleting;
  double get precio => _precio;
  String get nombre => _nombre;
  List<XFile> get fotosSeleccionadas => _fotosSeleccionadas;
  List<String> get pathsImgs => _pathsImgs;

  set disponible(bool value) {
    _disponible = value;
    notifyListeners();
  }

  set deleting(bool value) {
    _deleting = value;
    notifyListeners();
  }

  set isValid(bool value) {
    _isValid = value;
    notifyListeners();
  }

  set precio(double value) {
    _precio = value;
    notifyListeners();
  }

  set nombre(String value) {
    _nombre = value;
    notifyListeners();
  }

  set fotosSeleccionadas(List<XFile> value) {
    _fotosSeleccionadas = value;
    notifyListeners();
  }

  set pathsImgs(List<String> value) {
    _pathsImgs = value;
    notifyListeners();
  }

  Future<void> deleteSelectedIndex(int index)async {
    _fotosSeleccionadas.removeAt(index);
    _pathsImgs.removeAt(index);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (deleting) {
        deleting = false;
    }
    notifyListeners();
  }

  @override
  String toString() {
    return 'Nombre: $nombre, Precio: $precio, Disponible: $disponible';
  }

  /* Http Methods */
  Future<Producto?> storeProducto(ProductoAdd producto) async {
    try {
      List<http.MultipartFile> files = [];

      var request = http.MultipartRequest(
          'POST', Uri.parse("${EnvApp.HttpsURLApi}Producto"));

      for (var i = 0; i < producto.productoFotos.length; i++) {
        files.add(await http.MultipartFile.fromPath(
            'ProductoFotos', producto.productoFotos[i].path));
      }

      request.files.addAll(files);
      request.fields['Disponible'] = producto.disponible.toString();
      request.fields['Precio'] = producto.precio.toString();
      request.fields['Nombre'] = producto.nombre;
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      ProductoResponse productoResponse =
          ProductoResponse.fromJson(response.body);
      return productoResponse.productos[0];
    } catch (e) {
      return null;
    }
  }
}
