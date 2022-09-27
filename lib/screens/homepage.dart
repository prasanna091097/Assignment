import 'dart:convert';
import 'package:assignmt_app/Model/prod_model.dart';
import 'package:assignmt_app/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../widgets/catalog_product.dart';
import '../controller/controller.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final cartController = Get.put(CartController());
  late int index;
  var product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
            Color(0XFFA1282A),
            Color.fromARGB(255, 164, 53, 52),
            Color(0XFF711F2C)
          ]))),
        ),
        body: FutureBuilder(
          future: ReadJsonData(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text("${data.error}"));
            } else if (data.hasData) {
              var product = data.data as List<Product>;
              return Column(
                children: [
                  const CatalogProducts(),
                  uiButton(context, "Go To Cart",
                      (() => Get.to(() => const CartScreen())))
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  Future<List<Product>> ReadJsonData() async {
    final jsondata = await rootBundle.rootBundle.loadString('assets/prod.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => Product.fromjson(e)).toList();
  }
}

Container uiButton(BuildContext context, String title, Function onTap) {
  return Container(
    width: 250,
    // width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.amber;
            }
            return Colors.grey;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}
