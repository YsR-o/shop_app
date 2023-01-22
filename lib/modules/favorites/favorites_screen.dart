import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocConsumer<ShopCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return state is ShopLoadingFavoritesState ?
        const Center(child: CircularProgressIndicator(),) :
        ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 1,
      ),
      itemBuilder: (context, index) => buildProductItem(cubit.favoritesModel!.data!.data![index].product!,context),
      itemCount: cubit.favoritesModel!.data!.data!.length,
    );
      },
    );
  }

  
}
