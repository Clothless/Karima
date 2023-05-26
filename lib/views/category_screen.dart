import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:karima/core/view_model/cart_view_model.dart';
import 'package:karima/model/cart_product_model.dart';
import 'package:karima/model/category_model.Dart';
import 'package:karima/views/widgets/custom_button.dart';
import 'package:karima/views/widgets/widgets.dart';
import '../core/view_model/home_view_model.dart';

class CategoryScreen extends StatelessWidget {
  CategoryModel model;
  
  CategoryScreen({
    required this.model,
    });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      builder: (controller) => Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 80, right: 20, left: 20),
          
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey.shade100,
                        ),
                        height: 60,
                        width: 60,
                        child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(model.image!),
                        )
                      ),
                      Text(
                        model.name!,
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.80 - 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade200,
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "How can i help you today!",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                          ),
                      ),
                    ),
                    ),
                ],
              ),
                  Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index){
                        return controller.productModel[index].category == model.name!
                        ? Column(
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
                                                text: '${controller.productModel[index].price!} DZD',
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
                        )
                        : const SizedBox(height: 0,) ;
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