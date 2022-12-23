import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../provider/add_product_form_provider.dart';
import 'package:image_picker/image_picker.dart';

class AddProductsContainer extends StatelessWidget {
  const AddProductsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
            clipBehavior: Clip.hardEdge,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Column(
              children: const [_ImgHeader(), _Formulario()],
            )),
      ),
    );
  }
}

class _ImgHeader extends StatelessWidget {
  const _ImgHeader({super.key});

  @override
  Widget build(BuildContext context) {
    var productoAddProvider = Provider.of<AddProductFormProvider>(context);
    return  Container(
        width: double.infinity,
        height: 300,
        child: productoAddProvider.pathsImgs.isEmpty
            ? const _NoImageContainer()
            : productoAddProvider.deleting
                ? const _DeletingContainer()
                : const _ImageContainer());
  }
}

class _DeletingContainer extends StatelessWidget {
  const _DeletingContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Image(
            width: double.infinity,
            fit: BoxFit.cover,
            image: AssetImage('assets/jar-loading.gif'));
  }
}

class _NoImageContainer extends StatelessWidget {
  const _NoImageContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var productoAddProvider = Provider.of<AddProductFormProvider>(context);
    return Stack(
      children: [
        const Image(
            width: double.infinity,
            fit: BoxFit.cover,
            image: AssetImage('assets/select-image.png')),
        Align(
            alignment: Alignment.topRight,
            child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(100)),
                child: GestureDetector(
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    final List<XFile> images = await picker.pickMultiImage();
                    if (images.isNotEmpty) {
                      productoAddProvider.fotosSeleccionadas = images;
                      productoAddProvider.pathsImgs =
                          images.map((e) => e.path).toList();
                    }
                  },
                  child: const Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.white,
                  ),
                )))
      ],
    );
  }
}

class _ImageContainer extends StatefulWidget {
  const _ImageContainer({
    super.key,
  });
  @override
  State<_ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<_ImageContainer> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    var productoAddProvider =
        Provider.of<AddProductFormProvider>(context, listen: false);
    return Stack(
      children: [
        CarouselSlider(
            items: productoAddProvider.pathsImgs
                .map((e) => _ImagenCarousel(img: e))
                .toList(), //List<_ImageCarousel>
            options: CarouselOptions(
              height: 370.0,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _index = index;
                });
              },
            )),
        Align(
            alignment: Alignment.topRight,
            child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(100)),
                child: GestureDetector(
                  onTap: () async{
                    productoAddProvider.deleting = true;
                   await productoAddProvider.deleteSelectedIndex(_index);
                  },
                  child: const Icon(
                    Icons.clear,
                    size: 30,
                    color: Colors.white,
                  ),
                )))
      ],
    );
  }
}

class _ImagenCarousel extends StatelessWidget {
  const _ImagenCarousel({
    super.key,
    required this.img,
  });
  final String img;
  @override
  Widget build(BuildContext context) {
    return Image.file(fit: BoxFit.cover, File(img));
  }
}

class _Formulario extends StatelessWidget {
  const _Formulario({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var formProvider = Provider.of<AddProductFormProvider>(context);
    return Form(
        key: formProvider.formKey,
        onChanged: () {
          formProvider.isValid = formProvider.formKey.currentState!.validate();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                autocorrect: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) => formProvider.nombre = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'El campo no puede estar vacio';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'El precio no puede estar vacio';
                  }
                  return null;
                },
                onChanged: (value) {
                  if (double.tryParse(value) == null) {
                    formProvider.precio = 0;
                  } else {
                    formProvider.precio = double.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Precio'),
              ),
            ),
            SwitchListTile(
                title: const Text('Disponible'),
                value: formProvider.disponible,
                onChanged: (value) => formProvider.disponible = value),
            const SizedBox(
              height: 20,
            )
          ],
        ));
  }
}