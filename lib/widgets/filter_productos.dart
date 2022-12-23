import 'package:fh_productos_app/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterProducts extends StatelessWidget {
  const FilterProducts({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductsProvider>(context);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      child: SwitchListTile(
        title: provider.showDisponbiles
            ? const Text('Disponibles',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w500))
            : const Text('No Disponibles',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.w500)),
        value: provider.showDisponbiles,
        onChanged: (value) {
          provider.showDisponbiles = value;
        },
      ),
    );
  }
}
