import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:karima/core/view_model/control_view_model.dart';
import 'package:karima/views/control_view.dart';
import 'package:karima/views/home_view.dart';
import 'package:karima/views/widgets/custom_button.dart';

import '../widgets/widgets.dart';

class OrderDone extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControlViewModel>(
      builder: (context) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomText(
                          alignment: Alignment.topCenter,
                          text: "Thank You for your order!",
                          fontSize: 32,
                          color: Colors.black,
                        ),
                        const SizedBox(height: 20,),
                        SvgPicture.asset(
                          "assets/images/order-confirmed.svg",
                          width: 200,
                          height: 200,
                          ),
                        const SizedBox(height: 20,),
                        CustomButton(
                          text: "Home",
                          onPress: () {
                            context.changeSelectedValue(0);
                            Get.to(ControlView());
                          },
                        )
                      ],
                    ),
          ),
        );
      }
    );
  }
}