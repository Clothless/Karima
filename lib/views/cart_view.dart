import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:karima/core/view_model/cart_view_model.dart';
import 'package:karima/model/cart_product_model.dart';
import 'package:karima/views/checkout/checkout_view.dart';
import 'package:karima/views/widgets/custom_button.dart';
import 'package:karima/views/widgets/widgets.dart';

class CartView extends StatefulWidget {

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<CartProductModel>? cart;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartViewModel>(
      init: CartViewModel(),
      builder: (controller) => Scaffold(
      body: controller.cartProductModel.isEmpty
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/cart_empty.svg",
                    width: 200,
                    height: 200,
                    ),
                  const SizedBox(height: 20,),
                  const CustomText(
                    alignment: Alignment.topCenter,
                    text: "Your Cart is empty",
                    fontSize: 32,
                    color: Colors.grey,
                  )
                ],
              )
              : Column(
        children: [
          const SizedBox(height: 50,),
          const CustomText(
            text: "Ready to buy!?",
            fontSize: 24.0,
            alignment: Alignment.center,
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index){
                  return SizedBox(
                    height: 140,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 140,
                                child: Image.network(controller.cartProductModel[index].image!, fit: BoxFit.contain,),
                                ),
                                SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text: controller.cartProductModel[index].name,
                                        width: MediaQuery.of(context).size.width * 0.4,
                                        height: 16.0,
                                        ),
                                      const SizedBox(height: 10),
                                      CustomText(
                                        text: " ${controller.cartProductModel[index].price} DZD",
                                        color: Colors.green,
                                        ),
                                      const SizedBox(height: 10),
                                      Container(
                                        height: 40,
                                        width: 100,
                                        color: Colors.grey.shade200,
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              child: const Icon(
                                                Icons.add,
                                                color: Colors.black,
                                              ),
                                              onTap: () {
                                                controller.incresaeQuantity(index);
                                              },
                                            ),
                                            const SizedBox(width: 20),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 12.0),
                                              child: CustomText(
                                                text: controller.cartProductModel[index].quantity.toString(),
                                                fontSize: 18,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 15.0),
                                              child: GestureDetector(
                                                child: const Icon(
                                                  Icons.minimize,
                                                  color: Colors.black,
                                                ),
                                                onTap: () {
                                                  controller.decreaseQuantity(index);
                                                },
                                              ),
                                            ),
                                            
                                          ]
                                        ),
                                      ),
                                      CustomButton(
                                        text: "Delete",
                                        background: Colors.red.shade400,
                                        foreground: Colors.white,
                                        fontsize: 14,
                                        onPress: (){
                                          controller.cartProductModel.removeAt(index);
                                          controller.getTotalPrice();
                                          setState(() {
                                            
                                          });
                                        },
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const CustomText(
                  text: "TOTAL:",
                  fontSize: 20,
                ),
                GetBuilder<CartViewModel>(
                  builder: (controller) => CustomText(
                    text: "${controller.totalPrice} DZD",
                    fontSize: 26,
                    color: Colors.green.shade500,
                  ),
                ),
                ]
              ),
              CustomButton(
                onPress: (){
                  Get.to(CheckoutView());
                },
                text: "Checkout",
              ),
            ],
            ),
        ),
        ],
    ),
      ),
    );
  }
}