import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import '../../../models/categories_model.dart';
import '../../../models/change_favorites_model.dart';
import '../../../models/favorites_model.dart';
import '../../../models/home_model.dart';
import '../../../models/shop_login_model.dart';
import '../../../modules/categories/categories_screen.dart';
import '../../../modules/favorites/favorites_screen.dart';
import '../../../modules/products/products_screen.dart';
import '../../../modules/settings/settings_screen.dart';
import '../../../shared/components/conestants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopAppStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool>? favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then(
      (value) {
        homeModel = HomeModel.fromJson(value.data);
        for (var element in homeModel!.data!.products!) {
          favorites!.addAll(
            {
              element.id!: element.inFavorites!,
            },
          );
        }
        emit(ShopSuccessHomeDataState());
      },
    ).catchError(
      (erorr) {
        emit(ShopErorrHomeDataState());
      },
    );
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    emit(ShopLoadingCategoriesDataState());
    DioHelper.getData(url: GET_CATEGORIES, token: token).then(
      (value) {
        categoriesModel = CategoriesModel.fromJson(value.data);
        emit(ShopSuccessCategoriesState());
      },
    ).catchError(
      (erorr) {
        emit(ShopErorrCategoriesState());
        print(erorr.toString());
      },
    );
  }

  ChaneFavoritesModel? chaneFavoritesModel;
  void chaneFavorites(int productId) {
    favorites?[productId] = !(favorites![productId]!);
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      chaneFavoritesModel = ChaneFavoritesModel.fromJson(value.data);
      if (!chaneFavoritesModel!.status!) {
        favorites?[productId] = !favorites![productId]!;
      } else {
        getFavorites();
      }

      emit(ShopSuccessChangeFavoritesState(chaneFavoritesModel!));
    }).catchError((erorr) {
      favorites?[productId] = !(favorites![productId]!);

      emit(ShopErorrFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {
    emit(ShopLoadingFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then(
      (value) {
        favoritesModel = FavoritesModel.fromJson(value.data);
        emit(ShopSuccessGetFavoritesState());
      },
    ).catchError(
      (erorr) {
        emit(ShopErorrGetFavoritesState());
        print(erorr.toString());
      },
    );
  }

  ShopLoginModel? loginModel;
  void getUserData() {
    emit(ShopLoadingGetUserState());
    DioHelper.getData(
      url: profile,
      token: token,
    ).then(
      (value) {
        loginModel = ShopLoginModel.fromJson(value.data);
        emit(ShopSuccessGetUserState(loginModel!));
      },
    ).catchError(
      (erorr) {
        emit(ShopErorrGetUserState());
      },
    );
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: updateProfile,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then(
      (value) {
        loginModel = ShopLoginModel.fromJson(value.data);
        emit(ShopSuccessUpdateUserState(loginModel!));
      },
    ).catchError(
      (erorr) {
        emit(ShopErorrUpdateUserState());
      },
    );
  }
}
