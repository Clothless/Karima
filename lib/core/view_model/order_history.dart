import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../model/order_model.dart';
import '../../model/user_model.dart';

class OrderHistoryModel extends GetxController{

  ValueNotifier<bool> get loading => _loading;
  final ValueNotifier<bool> _loading = ValueNotifier(false);

  CollectionReference get userCollectionRef => _userCollectionRef;
  final CollectionReference _userCollectionRef = FirebaseFirestore.instance.collection('Users');
  
  CollectionReference get orderCollectionRef => _orderCollectionRef;
  final CollectionReference _orderCollectionRef = FirebaseFirestore.instance.collection('Orders');

  List<UserModel?> get curr => _curr;
  final List<UserModel?> _curr = [];

  List<OrderModel> get fin => _fin;
  final List<OrderModel> _fin = [];


  OrderHistoryModel(){
    listing();
  }


  Future<DocumentSnapshot> getCurrentUser (String uid) async{
    return await _userCollectionRef.doc(uid).get();
  }

  Future<List<QueryDocumentSnapshot>> getOrders() async {
    var value = await _orderCollectionRef.get();
    return value.docs;
  }

  void listing() async{
    _loading.value = true;
    await getOrders().then((value) {
      for(int i = 0; i < value.length; i++){
        _fin.add(OrderModel.fromJson(value[i].data() as Map<dynamic, dynamic>));
      }
    });
    for(int i = 0; i < fin.length; i++) {
      await getCurrentUser(fin[i].userID!).then((value) {
      _curr.add(UserModel.fromjson(value.data()  as Map<dynamic, dynamic>?));
    });
    }
    _loading.value = false;
    update();
  }

}