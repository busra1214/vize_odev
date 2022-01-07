class UserModel {
  String userMail, userImg;

  UserModel(
    this.userMail,
    this.userImg,
  );
}

class UserModelConverter {
  UserModel userModelFromJson(Map<String, dynamic>? json) => UserModel(
        json!["userMail"],
        json["userImg"],
      );

  Map<String, dynamic> userModelToJson(UserModel userModel) =>
      <String, dynamic>{
        'userMail': userModel.userMail,
        'userImg': userModel.userImg,
      };
}
