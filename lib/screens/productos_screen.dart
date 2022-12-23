import 'package:fh_productos_app/model/producto_model.dart';
import 'package:fh_productos_app/provider/add_product_form_provider.dart';
import 'package:fh_productos_app/provider/products_provider.dart';
import 'package:fh_productos_app/theme/app_theme.dart';
import 'package:fh_productos_app/widgets/filter_productos.dart';
import 'package:fh_productos_app/widgets/product_card_parts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FutureBuilderScreen extends StatelessWidget {
  const FutureBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyle.primary,
        elevation: 5,
        title: const Text('Listado Productos'),
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            await provider.getProductosList();
          },
          child: const _ListProductContainer()),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.primary,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'addProducts');
        },
      ),
    );
  }
}

class _ListProductContainer extends StatelessWidget {
  const _ListProductContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromARGB(255, 212, 212, 212),
        child: Column(
          children: [const FilterProducts(), Expanded(child: _ListProductos())],
        ));
  }
}

class _ListProductos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductsProvider>(context);
    List<Producto> productosMostrar = provider.listadoProductos
        .where((x) => (provider.showDisponbiles ? x.disponible : !x.disponible))
        .toList();

    if (productosMostrar.isEmpty) {
      return const Center(
        child: Text('No hay nada para mostrar... aún...'),
      );
    }
    /* Si hay data */
    return ListView.builder(
        itemBuilder: (context, index) {
          int valueDisponible = provider.showDisponbiles ? 0 : 1;
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  GestureDetector(
                      onTap: () {
                        /* No habia nada */
                        if (provider.noDetailsImgIndex == null) {
                          //Disponbile 0 : 3
                          provider.noDetailsImgIndex = {valueDisponible: index};
                          return;
                        }
                        int? indice =
                            provider.noDetailsImgIndex?[valueDisponible];
                        /* Era el mismo(lo nuleamos) */
                        if (index == indice) {
                          provider.noDetailsImgIndex = null;
                        } else {
                          provider.noDetailsImgIndex = {valueDisponible: index};
                        }
                      },
                      child: _ProductCard(
                          hideinfo: provider.noDetailsImgIndex == null
                              ? false
                              : (provider.noDetailsImgIndex?[valueDisponible] !=
                                      null &&
                                  provider.noDetailsImgIndex?[
                                          valueDisponible] ==
                                      index),
                          producto: productosMostrar[index])),
                  SizedBox(
                    height: index == productosMostrar.length - 1 ? 100 : 40,
                  ),
                ],
              ));
        },
        itemCount: productosMostrar.length);
  }
}
/* class _ListProductosFuture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductsProvider>(context);

    return FutureBuilder(
      future: provider.getLocalProductosList(),
      builder: (context, data) {
        if (!data.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppStyle.primary,
            ),
          );
        }

        /* Si hay data */
        List<Producto> listado = data.data as List<Producto>;
        return ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: index == 0 ? 40 : 70,
                      ),
                      GestureDetector(
                          onTap: () {
                            provider.hideDetails = !provider.hideDetails;
                          },
                          child: _ProductCard(
                              hideinfo: provider.hideDetails,
                              producto: listado[index])),
                      SizedBox(
                        height: index == listado.length - 1 ? 100 : 0,
                      ),
                    ],
                  ));
            },
            itemCount: listado.length);
      },
    );
  }
} */

class _ProductCard extends StatelessWidget {
  final Producto producto;
  final bool hideinfo;
  const _ProductCard({
    super.key,
    required this.producto,
    required this.hideinfo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 5,
      child: Stack(
        children: [
          BackGroundImageCard(imgs: producto.productoFotos),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: !hideinfo ? 1.0 : 0.0,
            child: PriceBox(
              precio: producto.precio,
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: !hideinfo ? 1.0 : 0.0,
            child: DescriptinBox(
              nombre: producto.nombre,
            ),
          )
        ],
      ),
    );
  }
}
