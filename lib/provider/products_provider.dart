import 'package:fh_productos_app/ENV.dart';
import 'package:fh_productos_app/model/producto_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductsProvider extends ChangeNotifier {
  List<Producto> listadoProductos = [];
  bool _showDisponbiles = true;
  Map<int, int?>? _noDetailsImgIndex;

  ProductsProvider() {
    getProductosList();
  }

  bool get showDisponbiles => _showDisponbiles;
  Map<int, int?>? get noDetailsImgIndex => _noDetailsImgIndex;

  set showDisponbiles(bool value) {
    _showDisponbiles = value;
    notifyListeners();
  }

  set noDetailsImgIndex(Map<int, int?>? value) {
    _noDetailsImgIndex = value;
    notifyListeners();
  }

  Future<void> getProductosList() async {
    try {
      var url = Uri.parse("${EnvApp.HttpsURLApi}Producto");
      var response = await http.get(url);
      ProductoResponse pr = ProductoResponse.fromJson(response.body);
      listadoProductos = pr.productos;
      notifyListeners();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void addProductoToList(Producto producto) {
    listadoProductos = [producto, ...listadoProductos];
    notifyListeners();
  }
}
