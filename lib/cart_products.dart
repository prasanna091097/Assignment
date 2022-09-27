import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'Model/prod_model.dart';
import 'controller.dart';

class CartProducts extends StatelessWidget {
  final CartController controller = Get.find();

  CartProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      (() => SizedBox(
            height: 700,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.products.length,
                  itemBuilder: ((BuildContext context, int index) {
                    return CartProductCard(
                      controller: controller,
                      product: controller.products.keys.toList()[index],

                      // product: controller.products.keys.toList()[index],
                      quantity: controller.products.values.toList()[index],
                      index: index,
                    );
                  })),
            ),
          )),
    );
  }
}

class CartProductCard extends StatelessWidget {
  final CartController controller;
  final Product product;
  final int quantity;
  final int index;
  const CartProductCard(
      {Key? key,
      required this.controller,
      required this.product,
      required this.quantity,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 150,
            height: 150,
            child: Image(
              image: NetworkImage(product.imageURL.toString()),
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(product.p_name.toString()),
              Text(
                '\$${product.p_cost}',
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          IconButton(
              onPressed: (() {
                controller.removeProduct(product);
              }),
              icon: const Icon(Icons.remove_circle)),
          Text("$quantity"),
          IconButton(
              onPressed: (() {
                controller.addProduct(product);
              }),
              icon: const Icon(Icons.add_circle))
        ],
      ),
    );
  }
}
