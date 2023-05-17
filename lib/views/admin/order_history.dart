import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:karima/core/view_model/order_history.dart';
import 'package:karima/model/user_model.dart';
import 'package:karima/views/widgets/custom_button.dart';
import 'package:karima/views/widgets/widgets.dart';


class OrderHistory extends StatefulWidget {

  
  @override
  State<OrderHistory> createState() => _OrderHistoryState();

}

class _OrderHistoryState extends State<OrderHistory> {
  

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderHistoryModel>(
      init: OrderHistoryModel(),
      builder: (controller) {
        return controller.loading.value
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
          body: controller.curr.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/empty.svg", height: 200, width: 200,),
                const CustomText(
                  text: "No Orders",
                  alignment: Alignment.center,
                  fontSize: 32,
                  color: Colors.grey,
                )
              ],
            )
          : Padding(
            padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CustomText(
                    text: "Remaining Orders",
                    fontSize: 32,
                    alignment: Alignment.center,
                  ), const SizedBox(height: 50,),
                  for(int i=0; i<controller.fin.length; i++)...[
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)
                      ),
                      child: Column(
                        children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                  text: "Date: ",
                                  fontSize: 22,
                                ),
                                CustomText(
                                  text: controller.fin[i].date,
                                  fontSize: 20,
                                  color: Colors.blue.shade800,
                                ),
                              ],
                            ), const SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                  text: "Name: ",
                                  fontSize: 22,
                                ),
                                CustomText(
                                  width: MediaQuery.of(context).size.width - 180,
                                  text: controller.curr[i]!.fullName,
                                  fontSize: 20,
                                  color: Colors.blue.shade800,
                                ),
                              ],
                            ), const SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                  text: "Address: ",
                                  fontSize: 22,
                                ),
                                CustomText(
                                  text: controller.curr[i]!.address,
                                  width: MediaQuery.of(context).size.width - 180,
                                  fontSize: 20,
                                  color: Colors.blue.shade800,
                                ),
                              ],
                            ), const SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                  text: "Province: ",
                                  fontSize: 22,
                                ),
                                CustomText(
                                  text: controller.curr[i]!.province,
                                  fontSize: 20,
                                  color: Colors.blue.shade800,
                                ),
                              ],
                            ), const SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                  text: "Postal Code: ",
                                  fontSize: 22,
                                ),
                                CustomText(
                                  text: controller.curr[i]!.postalCode,
                                  fontSize: 20,
                                  color: Colors.blue.shade800,
                                ),
                              ],
                            ),
                          ],
                        ),
                          Container(
                            alignment: Alignment.topCenter,
                            height: controller.fin[i].names!.length * 45,
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
                                              text: controller.fin[i].toJson()['names'][index],
                                              height: 18.0,
                                            ),
                                          ),
                                          CustomText(
                                            text: "X ${controller.fin[i].toJson()['quantities'][index]}",
                                            alignment: Alignment.centerRight,
                                            ),
                                          CustomText(
                                            text: '\$ ${controller.fin[i].toJson()['prices'][index]}',
                                            alignment: Alignment.centerRight,
                                            ),
                                        ]
                                      ),
                                    ]
                                  );
                                },
                                itemCount: controller.fin[i].names!.length, separatorBuilder: (BuildContext context, int index) {
                                  return const SizedBox(height: 0,);
                                },
                                ),
                          ), const SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CustomText(
                                text: "Total Price: ",
                                fontSize: 22,
                              ),
                              CustomText(
                                text: "\$ ${controller.fin[i].totalPrice}",
                                fontSize: 20,
                                color: Colors.green,
                              )
                            ],
                          ), const SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 150,
                                child: CustomButton(
                                  text: "Done",
                                  background: Colors.green,
                                  fontsize: 20,
                                  onPress: () async{
                                    await controller.orderCollectionRef.doc(controller.fin[i].orderID).delete();
                                    controller.curr.removeAt(i);
                                    controller.fin.removeAt(i);
                                    setState(() {
                                      
                                    });

                                  },
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 60,),
                  ],
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}