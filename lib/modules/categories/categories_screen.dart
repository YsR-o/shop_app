import 'package:flutter/material.dart';
import '../../layout/shop_app/cubit/cubit.dart';
import '../../models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemBuilder: (context, index) =>
          buildCategories(cubit.categoriesModel!.data!.data[index]),
      itemCount: cubit.categoriesModel!.data!.data.length,
    );
  }

  Widget buildCategories(DataModel model) => Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image(
              image: NetworkImage(model.image!),
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
            Text(model.name!),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward_ios,
              ),
            ),
          ],
        ),
      );
}
