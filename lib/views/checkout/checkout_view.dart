import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:karima/core/view_model/auth_view_model.dart';
import 'package:karima/core/view_model/cart_view_model.dart';
import 'package:karima/core/view_model/profile_view_model.dart';
import 'package:karima/helper/local_storage_data.dart';
import 'package:karima/model/cart_product_model.dart';
import 'package:karima/model/user_model.dart';
import 'package:karima/views/checkout/order_done.dart';
import 'package:karima/views/widgets/widgets.dart';

import '../../model/product_model.dart';
import '../widgets/custom_button.dart';

class CheckoutView extends StatefulWidget {
  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final now = DateTime.now();

  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');

  Future<void> addProductToOrder(CartProductModel productModel, String uid) async{
    return await usersCollection.doc(uid).collection("Cart").doc(productModel.productID).set(productModel.tojson());
    
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
                                text: 'X ${controller.cartProductModel[index].quantity.toString()}',
                                alignment: Alignment.centerRight,
                                ),
                              CustomText(
                                text: '\$ ${controller.cartProductModel[index].price}',
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
                              text: controller.userModel!.fullName!,
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
                              text: controller.userModel!.address,
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
                              text: controller.userModel!.province,
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
                              text: controller.userModel!.postalCode,
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
              GetBuilder<ProfileViewModel>(
                builder: (context) {
                  return CustomButton(
                    onPress: (){
                      for(int i=0; i<controller.cartProductModel.length; i++){
                      addProductToOrder(controller.cartProductModel[i], context.userModel!.userID!);
                      Get.to(OrderDone());
                      }
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