import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:karima/core/services/database/cart_database_helper.dart';
import 'package:karima/core/view_model/auth_view_model.dart';
import 'package:karima/core/view_model/cart_view_model.dart';
import 'package:karima/core/view_model/profile_view_model.dart';
import 'package:karima/helper/local_storage_data.dart';
import 'package:karima/model/cart_product_model.dart';
import 'package:karima/model/user_model.dart';
import 'package:karima/views/checkout/order_done.dart';
import 'package:karima/views/widgets/widgets.dart';

import '../../model/order_model.dart';
import '../../model/product_model.dart';
import '../widgets/custom_button.dart';

class CheckoutView extends StatefulWidget {
  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final now = DateTime.now();

  final ab = FirebaseAuth.instance.currentUser?.uid;

  final CollectionReference orderCollection = FirebaseFirestore.instance.collection('Orders');

  Future<void> addProductToOrder(OrderModel orderModel) async{
    return await orderCollection.doc(orderModel.orderID).set(orderModel.toJson());
    
  }

  

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartViewModel>(
      builder: (controller) => Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 80, right: 20, left: 20),
          child: Column(
            children: [
              const CustomText(
                text: "Confirm Your Order!",
                fontSize: 22,
                alignment: Alignment.center,
              ),
              const SizedBox(height: 40,),
              Table(
                border: TableBorder.all(
                  color: Colors.grey,  
                  style: BorderStyle.solid,  
                  borderRadius: BorderRadius.circular(5),
                  width: 1,
                ),
                children: const [
                  TableRow(
                    children: [
                      CustomText(
                        text: 'Product',
                        fontSize: 20.0,
                        alignment: Alignment.center,
                      ), 
                      CustomText(
                        text: 'Quantity',
                        fontSize: 20.0,
                        alignment: Alignment.center,
                      ), 
                      CustomText(
                        text: 'U.Price',
                        fontSize: 20.0,
                        alignment: Alignment.center,
                      ), 
                  ]),
                ],
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index){
                      return Table(
                        border: TableBorder.all(
                          color: Colors.grey,  
                          style: BorderStyle.solid,  
                          borderRadius: BorderRadius.circular(5),
                        ),
                        children: [  
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0, top: 5.0, bottom: 3.0),
                                child: CustomText(
                                  text: controller.cartProductModel[index].name,
                                  height: 18.0,
                                ),
                              ),
                              CustomText(
                                text: "X ${controller.cartProductModel[index].quantity}",
                                alignment: Alignment.centerRight,
                                ),
                              CustomText(
                                text: '${controller.cartProductModel[index].price} DZD',
                                alignment: Alignment.centerRight,
                                ),
                            ]
                          ),
                        ]
                      );
                    },
                    itemCount: controller.cartProductModel.length, separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 0,);
                     },
                    ),
              ),
              const CustomText(
                text: "Shipping Details!",
                fontSize: 20,
                alignment: Alignment.center,
              ),
              GetBuilder<ProfileViewModel>(
                init: ProfileViewModel(),
                builder: (controller) {
                  return Table(
                        border: TableBorder.all(
                          color: Colors.grey,  
                          style: BorderStyle.solid,  
                          borderRadius: BorderRadius.circular(5),
                        ),
                      children: [
                        TableRow(
                          children: [
                            const CustomText(
                              text: 'Date: ',
                              fontSize: 20.0,
                            ), 
                            CustomText(
                              text: now.toString().substring(0,10),
                              fontSize: 16.0,
                            ),
                        ]),
                        TableRow(
                          children: [
                            const CustomText(
                              text: 'Name: ',
                              fontSize: 20.0,
                            ), 
                            CustomText(
                              text: controller.userModel?.name!,
                              fontSize: 16.0,
                            ),
                        ]),
                        TableRow(
                          children: [
                            const CustomText(
                              text: 'Address: ',
                              fontSize: 20.0,
                            ), 
                            CustomText(
                              text: "",
                              fontSize: 16.0,
                            ),
                        ]),
                        TableRow(
                          children: [
                            const CustomText(
                              text: 'Province: ',
                              fontSize: 20.0,
                            ), 
                            CustomText(
                              text: "",
                              fontSize: 16.0,
                            ),
                        ]),
                        TableRow(
                          children: [
                            const CustomText(
                              text: 'Postal Code: ',
                              fontSize: 20.0,
                            ), 
                            CustomText(
                              text: "",
                              fontSize: 16.0,
                            ),
                        ]),
                      ],
                    );
                }
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
              GetBuilder<CartViewModel>(
                builder: (context) {
                  return CustomButton(
                    onPress: () async{
                      List<String> names = [];
                      List<String> prices = [];
                      List<int> quantities = [];
                        for(int i = 0; i<context.cartProductModel.length; i++){
                          names.add(context.cartProductModel[i].name!);
                          prices.add(context.cartProductModel[i].price!);
                          quantities.add(context.cartProductModel[i].quantity!);
                        }
                        print("this is it:");
                      DateTime now = DateTime.now();
                      OrderModel xa = OrderModel(
                        orderID: ab! + now.toString(),
                        date: now.toString().substring(0, 10),
                        totalPrice: controller.totalPrice.toString(),
                        names: names,
                        quantities: quantities,
                        prices: prices,
                        userID: ab,
                      );
                      addProductToOrder(xa);
                      Get.to(OrderDone());
                      },
                    text: "Confirm Order",
                  );
                }
              ),
            ],
            ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}