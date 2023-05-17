import 'package:karima/model/cart_product_model.dart';


class OrderModel {
String? orderID, date, totalPrice, userID;
List<dynamic>? names, prices;
List<dynamic>? quantities;


OrderModel({
  this.orderID,
  this.date,
  this.totalPrice,
  this.userID,
  this.names,
  this.prices,
  this.quantities,
  });



OrderModel.fromJson(Map<dynamic, dynamic> map){
  if(map == null){
    return;
  }
  orderID = map['orderID'];
  date = map['date'];
  totalPrice = map['totalPrice'];
  userID = map['userID'];
  names = map['names'];
  prices = map['prices'];
  quantities = map['quantities'];
}
toJson(){
  return {
    'orderID': orderID,
    'date': date,
    'totalPrice': totalPrice,
    'userID': userID,
    'names': names,
    'prices': prices,
    'quantities': quantities,
  };
}
}