import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:karima/model/product_model.dart';
import 'package:karima/views/widgets/widgets.dart';

class OrderHistory extends StatelessWidget {
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');

  Future<void> addProductToOrder(ProductModel productModel) async{
    return await usersCollection.doc(productModel.productID).set(productModel.tojson());
    
  }

  Future<DocumentSnapshot> getProducts (String uid) async{
    return await usersCollection.doc(uid).get();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomText(
            text: "testing",
          )
        ],
      ),
    );
  }
}