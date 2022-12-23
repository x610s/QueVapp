import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BackGroundImageCard extends StatelessWidget {
  final List<String> imgs;
  const BackGroundImageCard({super.key, required this.imgs});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items:  
      imgs.isEmpty ? [const _ImagenCarousel(img: '')] : 
      imgs.map((e) => _ImagenCarousel(img: e)).toList(),
      options: CarouselOptions(
        height: 370.0,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
      ),
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
    return Padding(
      padding:  EdgeInsets.all(img.isEmpty ? 0: 20),
      child:  
      img.isEmpty ? const  Image(
          fit: BoxFit.cover,
          width: double.infinity,
          image:   AssetImage('assets/no-image.jpg')
        )  
      : FadeInImage(placeholder: const AssetImage('assets/no-image.jpg'), image:  NetworkImage(img))
    );
  }
}

class PriceBox extends StatelessWidget {
  final double precio;
  const PriceBox({
    super.key,
    required this.precio,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          width: 120,
          height: 60,
          decoration: const BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                  topRight: Radius.circular(18))),
          child: Text(
            '\$$precio',
            style: const TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.white,
                fontSize: 25,
                overflow: TextOverflow.ellipsis),
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}

class DescriptinBox extends StatelessWidget {
  final String nombre;
  const DescriptinBox({
    super.key,
    required this.nombre,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 370,
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: 300,
        height: 70,
        decoration: const BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18),
                topRight: Radius.circular(18))),
        child: Text(
          nombre,
          style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontSize: 20,
              overflow: TextOverflow.ellipsis),
          maxLines: 2,
        ),
      ),
    );
  }
}
