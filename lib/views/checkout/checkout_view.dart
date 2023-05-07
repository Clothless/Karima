import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:karima/core/view_model/cart_view_model.dart';
import 'package:karima/model/cart_product_model.dart';
import 'package:karima/views/widgets/widgets.dart';

import '../widgets/custom_button.dart';

class CheckoutView extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartViewModel>(
      builder: (controller) => Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 80, right: 20, left: 20),
          child: Expanded(
            child: Column(
              children: [
                const CustomText(
                  text: "Confirm Your Order!",
                  fontSize: 22,
                  alignment: Alignment.center,
                ),
                const SizedBox(height: 40,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      CustomText(
                        text: "Product",
                      ),
                      CustomText(
                        text: "Quantity",
                      ),
                      CustomText(
                        text: "U.Price",
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50.0 * controller.cartProductModel.length,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListView.separated(
                      itemBuilder: (context, index){
                        return SizedBox(
                          height: 20,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                      SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                CustomText(
                                                  text: controller.cartProductModel[index].name,
                                                  width: 160.0,
                                                  height: 16.0,
                                                  ),
                                                CustomText(
                                                  text: 'X ${controller.cartProductModel[index].quantity.toString()}',
                                                  height: 16.0,
                                                  ),
                                                  const SizedBox(width: 20,),
                                                CustomText(
                                                  text: '\$ ${controller.cartProductModel[index].price}',
                                                  height: 16.0,
                                                  ),
                                              ]
                                            ),
                                          ]
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: controller.cartProductModel.length, separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 20,);
                       },
                      ),
                ),
              Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                    text: "TOTAL:",
                    fontSize: 20,
                  ),
                  GetBuilder<CartViewModel>(
                    builder: (controller) => CustomText(
                      text: "\$ ${controller.totalPrice}",
                      fontSize: 20,
                      color: Colors.green.shade500,
                    ),
                  ),
                  ]
                ),
                const SizedBox(height: 20,),
                CustomButton(
                  onPress: (){
                    Get.to(CheckoutView());
                  },
                  text: "Confirm Order",
                ),
              ],
              ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}