import 'package:flutter/material.dart';

SnackBar SavedOrFailedMessage(BuildContext context) {
  return SnackBar(
      dismissDirection: DismissDirection.endToStart,
      backgroundColor: Colors.green,
      content: const Text('Producto Agregador exitosamente!'),
      action: SnackBarAction(
          textColor: Colors.white,
          label: 'Ir al home',
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, 'products', (Route<dynamic> route) => false);
          }));
}
