import '../../../models/change_favorites_model.dart';
import '../../../models/shop_login_model.dart';

abstract class ShopAppStates {}

class ShopInitialState extends ShopAppStates {}

class ShopChangeBottomNavState extends ShopAppStates {}

class ShopLoadingHomeDataState extends ShopAppStates {}

class ShopSuccessHomeDataState extends ShopAppStates {}

class ShopErorrHomeDataState extends ShopAppStates {}

class ShopLoadingCategoriesDataState extends ShopAppStates {}

class ShopSuccessCategoriesState extends ShopAppStates {}

class ShopErorrCategoriesState extends ShopAppStates {}

class ShopSuccessChangeFavoritesState extends ShopAppStates 
{
  final ChaneFavoritesModel model ;
  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErorrFavoritesState extends ShopAppStates {}

class ShopChangeFavoritesState extends ShopAppStates {}

class ShopLoadingFavoritesState extends ShopAppStates {}

class ShopSuccessGetFavoritesState extends ShopAppStates {}

class ShopErorrGetFavoritesState extends ShopAppStates {}

class ShopLoadingGetUserState extends ShopAppStates {}

class ShopSuccessGetUserState extends ShopAppStates {

  final ShopLoginModel model;
  ShopSuccessGetUserState(this.model);}

class ShopErorrGetUserState extends ShopAppStates {}

class ShopLoadingUpdateUserState extends ShopAppStates {}

class ShopSuccessUpdateUserState extends ShopAppStates {

  final ShopLoginModel model;

  ShopSuccessUpdateUserState(this.model);
  }

class ShopErorrUpdateUserState extends ShopAppStates {}