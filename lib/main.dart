import 'dart:io';

import 'package:fh_productos_app/provider/add_product_form_provider.dart';
import 'package:fh_productos_app/provider/products_provider.dart';
import 'package:fh_productos_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() {
  HttpOverrides.global =  MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductsProvider(),lazy: false,),
        ChangeNotifierProvider(create: (context) => AddProductFormProvider(),lazy: true,)
      ],
      child: MaterialApp(
        title: 'Material App'       ,
        initialRoute:  'products',
        onGenerateRoute: (_) {
         return MaterialPageRoute(builder: (context) => const AddProduct());
        },
        routes: {
          'products': (_)=> const FutureBuilderScreen(),
          'addProducts': (_)=> const AddProduct()
        },
      ),
    );
  }
}
    
