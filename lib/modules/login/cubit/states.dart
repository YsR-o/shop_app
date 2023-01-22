import '../../../models/shop_login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {

  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginErorState extends ShopLoginStates {

  final String error;

  ShopLoginErorState(this.error);
}

class ChangeVisibilityState extends ShopLoginStates {}

