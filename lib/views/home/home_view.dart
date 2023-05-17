import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:karima/core/view_model/home_view_model.dart';
import 'package:karima/views/category_screen.dart';
import 'package:karima/views/details_screen.dart';
import 'package:karima/views/widgets/custom_button.dart';
import 'package:karima/views/widgets/widgets.dart';

import 'best_selling_view.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (controller) => controller.loading.value
      ? const Center(child: CircularProgressIndicator())
      : Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade200,
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "What are you looking for today..?",
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
                const SizedBox(height: 50,),
                const CustomText(text: "Category",),
                const SizedBox(height: 20,),
                GetBuilder<HomeViewModel>(
                  builder: (controller) => SizedBox(
                    height: 100,
                    child: ListView.separated(
                      itemCount: controller.categoryModel.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: (){
                                Get.to(CategoryScreen(model: controller.categoryModel[index],));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.grey.shade100,
                                ),
                                height: 60,
                                width: 60,
                                child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(controller.categoryModel[index].image!),
                              ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            CustomText(
                              text: controller.categoryModel[index].name,
                            )
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(width: 20,),
                      ),
                  ),
                ),
                const SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      text: "Best Products",
                      fontSize: 18,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(const BestSellingView());
                      },
                      child: const CustomText(
                        text: "See All",
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                GetBuilder<HomeViewModel>(
                  init: HomeViewModel(),
                  builder: (controller) => SizedBox(
                    height: 350,
                    child: ListView.separated(
                      itemCount: controller.productModel.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Get.to(DetailsScreen(
                              model: controller.productModel[index],
                              ));
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * .4,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey.shade100,
                                    ),
                                    child: SizedBox(
                                      height: 220,
                                      width: MediaQuery.of(context).size.width * .4,
                                      child: Image.network(controller.productModel[index].image!,)
                                      ),
                                  ),
                                  const SizedBox(height: 20,),
                                  CustomText(
                                    text: controller.productModel[index].name,
                                    alignment: Alignment.bottomLeft,
                                    height: 16.0,
                                  ),
                                  const SizedBox(height: 10,),
                                  CustomText(
                                    height: 30.0,
                                    text: controller.productModel[index].description,
                                    alignment: Alignment.bottomLeft,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(height: 10,),
                                  CustomText(
                                    text: "\$ ${controller.productModel[index].price}",
                                    alignment: Alignment.bottomLeft,
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(width: 20,),
                      ),
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