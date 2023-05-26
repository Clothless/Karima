import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karima/core/view_model/cart_view_model.dart';
import 'package:karima/core/view_model/control_view_model.dart';
import 'package:karima/model/cart_product_model.dart';
import 'package:karima/views/widgets/custom_button.dart';
import 'package:karima/views/widgets/widgets.dart';

import '../const.dart';
import '../const.dart';
import '../model/product_model.dart';
import 'home/control_view.dart';

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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 9,
                  blurRadius: 15,
                  offset: const Offset(0, 3),
                )
              ],
              border: Border.all(
                color: Colors.grey,
                style: BorderStyle.none
              )
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 350,
            child: Image.network(
              model!.image!,
              ),
          ),
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
                    
                    const SizedBox(height: 20,),
                    const CustomText(
                      text: "Description",
                      fontSize: 20,
                    ),
                    const SizedBox(height: 15,),
                    CustomText(
                      text: model!.description,
                      separator: 2.0,
                    ),
                    const SizedBox(height: 30,),
                    Column(
                      children: [
                        Row(
                          children: [
                            const CustomText(
                              text: "Brand :",
                              fontSize: 18,
                            ),
                            const SizedBox(width: 20,),
                            CustomText(
                              text: "Men\'s",
                              color: Colors.black.withOpacity(0.6),
                            )
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                            const CustomText(
                              text: "Category :",
                              fontSize: 18,
                            ),
                            const SizedBox(width: 20,),
                            CustomText(
                              text: model!.category,
                              color: Colors.black.withOpacity(0.6),
                            )
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                            const CustomText(
                              text: "Weight :",
                              fontSize: 18,
                            ),
                            const SizedBox(width: 20,),
                            CustomText(
                              text: "${model!.price} g",
                              color: Colors.black.withOpacity(0.6),
                            )
                          ],
                        ),
                        const SizedBox(height: 20,),
                      ],
                    )
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
                        text: "${model!.price} DZD",
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
                      child: GetBuilder<ControlViewModel>(
                        builder: (context) {
                          return CustomButton(
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
                            context.changeSelectedValue(1);
                            Get.to(ControlView());
                            },
                            text: "Add to cart",
                          );
                        }
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