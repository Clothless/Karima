class UserModel{
  String? userID, name, fullName, email, pic, address, postalCode, province;

  UserModel({
    this.userID,
    this.name,
    this.fullName,
    this.email,
    this.pic,
    this.address,
    this.postalCode,
    this.province,
    });

  UserModel.fromjson(Map<dynamic, dynamic>? map){
    if(map == null){
      return ;
    }

    userID = map['userID'];
    name = map['name'];
    fullName = map['fullName'];
    email = map['email'];
    pic = map['pic'];
    address = map['address'];
    postalCode = map['postalCode'];
    province = map['province'];
  }

  tojson(){
    return {
      'userID': userID,
      'name': name,
      'fullName': fullName,
      'email': email,
      'pic': pic,
      'address': address,
      'postalCode': postalCode,
      'province': province,
    };
  }
}