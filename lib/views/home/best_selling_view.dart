import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:karima/views/widgets/custom_button.dart';
import 'package:karima/views/widgets/widgets.dart';

import '../../core/view_model/cart_view_model.dart';
import '../../core/view_model/home_view_model.dart';
import '../../model/cart_product_model.dart';

class BestSellingView extends StatelessWidget {
  const BestSellingView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      builder: (controller) => Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 80, right: 20, left: 20),
          
          child: Column(
            children: [
              const CustomText(
                text: "Discover",
                alignment: Alignment.center,
                fontSize: 32,
              ), const SizedBox(height: 10,),
                  Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index){
                        return Column(
                          children: [
                            SizedBox(
                                height: 140,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 140,
                                            child: Image.network(controller.productModel[index].image!,),
                                            ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                text: controller.productModel[index].name!,
                                                height: 16.0,
                                                width: MediaQuery.of(context).size.width * 0.5,
                                                ),
                                              const SizedBox(height: 10,),
                                              CustomText(
                                                text: '\$ ${controller.productModel[index].price!}',
                                                color: Colors.green,
                                                ),
                                              const SizedBox(height: 10),
                                              GetBuilder<CartViewModel>(
                                                init: CartViewModel(),
                                                builder: (cont) => Container(
                                                  width: 80,
                                                  height: 40,
                                                  child: CustomButton(
                                                    onPress: () {
                                                      cont.addProduct(
                                                        CartProductModel(
                                                          productID: controller.productModel[index].productID,
                                                          name: controller.productModel[index].name,
                                                          image: controller.productModel[index].image,
                                                          quantity: 1,
                                                          price: controller.productModel[index].price,
                                                        )
                                                      );
                                                    },
                                                    text: "Add",
                                                    fontsize: 14,
                                                    pad: 0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                            ),
                            const SizedBox(height: 20,)
                          ],
                        );
                      },
                      itemCount: controller.productModel.length, separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 0,);
                      },
                      ),
                  ),
                ],
                
              ),
    
              
        ),
      ),
    );
  }
}