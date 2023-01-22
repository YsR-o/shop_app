import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/layout/shop_app/home_layout.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/conestants.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'layout/shop_app/cubit/cubit.dart';
import 'modules/login/shop_login_screen.dart';
import 'modules/on_bording/on_bording_screen.dart';

Future<void> main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CashHelper.init();
  Widget widget;
  bool? onBording = CashHelper.getData(key: 'onBording');
  token = CashHelper.getData(key: 'token');
  if (onBording != null) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = const OnBordingScreen();
  }
  runApp( MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp(this.startWidget, {super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavorites()
              ..getUserData(),
          )
        ],
        child: BlocConsumer<ShopCubit,ShopAppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightMode,
              home: startWidget,
            );
          },
        ));
  }
}
