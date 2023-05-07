import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karima/core/view_model/cart_view_model.dart';
import 'package:karima/model/cart_product_model.dart';
import 'package:karima/views/widgets/custom_button.dart';
import 'package:karima/views/widgets/widgets.dart';

import '../const.dart';
import '../const.dart';
import '../model/product_model.dart';

class DetailsScreen extends StatelessWidget {
  ProductModel? model;

  DetailsScreen({
    this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Image.network(
              model!.image!,
              fit: BoxFit.fill,
              ),
          ),
          const SizedBox(height: 15,),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    CustomText(
                      text: model!.name,
                      fontSize: 26,
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 15, bottom: 15,),
                          width: MediaQuery.of(context).size.width * 0.40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.grey,
                            )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const CustomText(
                                text: "Size",
                              ),
                              CustomText(
                                text: model!.size,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 15, bottom: 15,),
                          width: MediaQuery.of(context).size.width * 0.40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.grey,
                            )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const CustomText(
                                text: "Color",
                              ),
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                  color: model!.color,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    const CustomText(
                      text: "Details",
                      fontSize: 20,
                    ),
                    const SizedBox(height: 15,),
                    CustomText(
                      text: model!.description,
                      separator: 2.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const CustomText(
                        text: "PRICE:",
                        fontSize: 20,
                      ),
                      CustomText(
                        text: "\$ ${model!.price}",
                        fontSize: 26,
                        color: Colors.green.shade500,
                      ),
                    ],
                  ),
                  GetBuilder<CartViewModel>(
                    init: CartViewModel(),
                    builder: (controller) => Container(
                      width: 140,
                      height: 50,
                      child: CustomButton(
                        onPress: () {
                          controller.addProduct(
                          CartProductModel(
                            productID: model!.productID,
                            name: model!.name,
                            image: model!.image,
                            quantity: 1,
                            price: model!.price,
                          )
                        );
                        },
                        text: "Add to cart",
                      ),
                    ),
                  )
                ],
              ),
          ),
          
        ],
      ),
    );
  }
}