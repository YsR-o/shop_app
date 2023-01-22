import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import '../../../../shared/network/end_points.dart';
import '../../../models/search_model.dart';
import '../../../shared/components/conestants.dart';
import '../../../shared/network/remote/dio_helper.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates> {
  ShopSearchCubit() : super(ShopSearchInitialState());

  static ShopSearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;
  void searching(String text) {
    emit(ShopSearchLoadingState());
    DioHelper.postData(
      url: productsSearch,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(ShopSearchSuccessState());
    }).catchError((erorr) {
      emit(ShopSearchErorrState());
    });
  }
}
