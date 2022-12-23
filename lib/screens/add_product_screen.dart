import 'package:fh_productos_app/model/producto_add_model.dart';
import 'package:fh_productos_app/provider/products_provider.dart';
import 'package:fh_productos_app/theme/app_theme.dart';
import 'package:fh_productos_app/widgets/add_product_parts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/producto_model.dart';
import '../provider/add_product_form_provider.dart';
import '../widgets/dialog_error.dart';
import '../widgets/save_fail_message.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var addProductProvider = Provider.of<AddProductFormProvider>(context);
    var providerProducto = Provider.of<ProductsProvider>(context);

    return WillPopScope(
         onWillPop: () async{
        addProductProvider.pathsImgs.clear();
        addProductProvider.fotosSeleccionadas.clear();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Agregar Producto'),
            backgroundColor: AppStyle.primary),
        backgroundColor: Colors.blueGrey[50],
        floatingActionButton: addProductProvider.isValid &&
                addProductProvider.fotosSeleccionadas.isEmpty
            ? FloatingActionButton(
                onPressed: () async {
                  if (addProductProvider.fotosSeleccionadas.isEmpty) {
                    await showMyDialog(context);
                    return;
                  }
    
                  ProductoAdd productoAdd = ProductoAdd(
                      disponible: addProductProvider.disponible,
                      precio: addProductProvider.precio,
                      nombre: addProductProvider.nombre,
                      productoFotos: addProductProvider.fotosSeleccionadas);
                  Producto? pro =
                      await addProductProvider.storeProducto(productoAdd);
                  if (pro != null && context.mounted) {
                    providerProducto.addProductoToList(pro);
                    final snackBar = SavedOrFailedMessage(context);
                    addProductProvider.fotosSeleccionadas.clear();
                    addProductProvider.pathsImgs.clear();
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: const Icon(Icons.save),
              )
            : null,
        body: const AddProductsContainer(),
      ),
    );
  }
}
