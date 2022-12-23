
import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class ProductoAdd {
    ProductoAdd({
        required this.disponible,
        required this.nombre,
        required this.precio,
        required this.productoFotos,
    });

    final bool disponible;
    final String nombre;
    final double precio;
    final List<XFile> productoFotos;

     String toJson() => json.encode(toMap());

    Map<String, dynamic> toMap() => {
        "disponible": disponible,
        "nombre": nombre,
        "precio": precio,
        "productoFotos": List<dynamic>.from(productoFotos.map((x) => x)),
    };

    @override
  String toString() {
    return "Nombre: $nombre, Precio $precio, Disponible? $disponible";
  }
}

