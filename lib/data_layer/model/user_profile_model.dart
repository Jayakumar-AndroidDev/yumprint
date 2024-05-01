class UserProfileModel {
  String? userImage;
  String? userName;

  UserProfileModel({required this.userImage,required this.userName});

  UserProfileModel.fromJson(Map<String,dynamic> json){
    userImage = json['user_image'];
    userName = json['user_name'];
  }

  Map<String,dynamic> toMap(){
    return {'user_image':userImage,'user_name':userName};
  }

}