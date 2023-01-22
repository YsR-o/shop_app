class ChaneFavoritesModel {
bool? status;
String? message;

ChaneFavoritesModel.fromJson(Map<String,dynamic>json){
  status = json['status'];
  message = json['message'];
}
}