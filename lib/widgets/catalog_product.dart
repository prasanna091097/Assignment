import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../Model/prod_model.dart';
import '../controller/controller.dart';

class CatalogProducts extends StatelessWidget {
  const CatalogProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FutureBuilder(
          future: ReadJsonData(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text("${data.error}"));
            } else if (data.hasData) {
              var product = data.data as List<Product>;
              return ListView.builder(
                  itemCount: product == null ? 0 : product.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CatalogProductsCard(
                      index: index,
                      product: product,
                    );
                  });
            } else {
              return const Center(
                  child: SpinKitWave(
                color: Color(0XFF711F2C),
                size: 45,
              ));
            }
          }),
    );
  }

  Future<List<Product>> ReadJsonData() async {
    final jsondata = await rootBundle.rootBundle.loadString('assets/prod.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => Product.fromjson(e)).toList();
  }
}

class CatalogProductsCard extends StatelessWidget {
  final cartController = Get.put(CartController());
  final int index;
  var product;
  CatalogProductsCard({Key? key, required this.index, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Container(
        height: 250,
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  child: Image(
                    image: NetworkImage(product[index].imageURL.toString()),
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Text(
                          product[index].p_name.toString(),
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18, right: 18),
                        child: Text(
                          '\$${product[index].p_cost.toString()}',
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                )),
                IconButton(
                    onPressed: (() {
                      cartController.addProduct(product[index]);
                    }),
                    icon: const Icon(Icons.add_circle))
              ],
            ),
            Text(
              product[index].p_details.toString(),
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              'Availability-${product[index].p_availability.toString()}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
