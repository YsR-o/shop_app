import '../../../models/shop_login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {

  final ShopLoginModel loginModel;

  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterErorState extends ShopRegisterStates {

  final String error;

  ShopRegisterErorState(this.error);
}

class ChangeVisibilityState extends ShopRegisterStates {}

