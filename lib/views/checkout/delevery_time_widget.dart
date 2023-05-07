import 'package:flutter/material.dart';
import 'package:karima/helper/enum.dart';
import 'package:karima/views/widgets/widgets.dart';

class DeliveryTime extends StatefulWidget {
  @override
  State<DeliveryTime> createState() => _DeliveryTimeState();
}

class _DeliveryTimeState extends State<DeliveryTime> {
  Delivery delivery = Delivery.StandardDelivery;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(height: 50,),
          RadioListTile<Delivery>(
            value: Delivery.StandardDelivery,
            groupValue: delivery,
            onChanged: (Delivery? value) {
              setState(() {
                delivery = value!;
              });
            },
            title: const CustomText(
              text: "Standard Delivery",
              fontSize: 24,
            ),
            subtitle: const CustomText(
              text: "sldgps zfolshf zpfosdhof",
              fontSize: 18,
            ),
            activeColor: Colors.green,
            ),
            const SizedBox(height: 50,),
            RadioListTile<Delivery>(
              value: Delivery.NextDayDelivery,
              groupValue: delivery,
              onChanged: (Delivery? value) {
                setState(() {
                  delivery = value!;
                });
              },
              title: const CustomText(
                text: "Next Day Delivery",
                fontSize: 24,
              ),
              subtitle: const CustomText(
                text: "sldgps zfolshf zpfosdhof",
                fontSize: 18,
              ),
              activeColor: Colors.green,
              ),
            const SizedBox(height: 50,),
            RadioListTile<Delivery>(
              value: Delivery.NominatedDelivery,
              groupValue: delivery,
              onChanged: (Delivery? value) {
                setState(() {
                  delivery = value!;
                });
              },
              title: const CustomText(
                text: "Nominated  Delivery",
                fontSize: 24,
              ),
              subtitle: const CustomText(
                text: "sldgps zfolshf zpfosdhof",
                fontSize: 18,
              ),
              activeColor: Colors.green,
              )
        ],
      ),
    );
  }
}