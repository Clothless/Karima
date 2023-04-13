class UserModel{
  String userID, name, email, pic;

  UserModel({
    this.userID,
    this.name,
    this.email,
    this.pic,
    });

  UserModel.fromjson(Map<dynamic, dynamic> map){
    if(map == null){
      return ;
    }

    userID = map['userID'];
    name = map['name'];
    email = map['email'];
    pic = map['pic'];
  }

  tojson(){
    return {
      'userID': userID,
      'name': name,
      'email': email,
      'pic': pic,
    };
  }
}