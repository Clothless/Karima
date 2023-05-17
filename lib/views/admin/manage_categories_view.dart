import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:karima/views/admin/edit_category.dart';
import 'package:karima/views/widgets/custom_button.dart';
import 'package:karima/views/widgets/widgets.dart';

import '../../core/view_model/home_view_model.dart';
import 'add_category_view.dart';

class ManageCategorisView extends StatefulWidget {
  

  @override
  State<ManageCategorisView> createState() => _ManageCategorisViewState();
}

class _ManageCategorisViewState extends State<ManageCategorisView> {
  
  final CollectionReference _categoryCollectionRef = FirebaseFirestore.instance.collection('Categories');
  Future<List<QueryDocumentSnapshot>> getCategory() async {
    var value = await _categoryCollectionRef.get();

    return value.docs;
  }
  String temp = "";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (controller) => controller.loading.value
      ? const Center(child: CircularProgressIndicator())
      : Scaffold(
          body: Container(
            padding: const EdgeInsets.only(top: 80, right: 20, left: 20),
            child: Column(
              children: [
                Center(
                  child: CustomButton(
                    text: "Add new category",
                    background: Colors.green,
                    fontsize: 18,
                    onPress: (){
                      Get.to(AddCategory());
                    },
                  ),
                ),
                const SizedBox(height: 20,),
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
                                            width: 80,
                                            child: Image.network(controller.categoryModel[index].image!,),
                                            ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                text: controller.categoryModel[index].name!,
                                                height: 16.0,
                                                width: MediaQuery.of(context).size.width * 0.5,
                                                ),
                                              const SizedBox(height: 10,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  CustomButton(
                                                    text: "Edit",
                                                    background: Colors.green,
                                                    foreground: Colors.white,
                                                    fontsize: 14,
                                                    onPress: (){
                                                      getCategory().then((value) {
                                                        Get.to(EditCategory(model: controller.categoryModel[index], id: value[index].id,));
                                                      });
                                                      
                                                    },
                                                  ),
                                                  CustomButton(
                                                    text: "Delete",
                                                    background: Colors.red.shade400,
                                                    foreground: Colors.white,
                                                    fontsize: 14,
                                                    onPress: (){
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                            actionsAlignment: MainAxisAlignment.spaceBetween,
                                                            title: const Text('Delete!'),
                                                            content: const Text('Do you really want to Delete it?'),
                                                              actions: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                  children: [
                                                                    CustomButton(       
                                                                      onPress: () {
                                                                        Get.back();
                                                                      },
                                                                      pad: 0.0,
                                                                      text: 'Cancel',
                                                                      fontsize: 12,
                                                                    ),
                                                                    CustomButton(       
                                                                      onPress: () {
                                                                        getCategory().then((value) {
                                                                          FirebaseFirestore.instance.collection("Categories").doc(value[index].id).delete();
                                                                        });
                                                                        controller.categoryModel.removeAt(index);
                                                                        setState(() {
                                                                          Get.back();
                                                                        });
                                                                      },
                                                                      pad: 0.0,
                                                                      text: 'Continue',
                                                                      fontsize: 12,
                                                                    ),
                                                                  ],
                                                                ),
                                                            ],
                                                          );
                                                        }
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                              
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
                      itemCount: controller.categoryModel.length, separatorBuilder: (BuildContext context, int index) {
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