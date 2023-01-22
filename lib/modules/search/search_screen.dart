import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../shared/styles/colors.dart';
import '../../models/search_model.dart';
import '../../shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final formkey = GlobalKey<FormState>();
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit, ShopSearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        defaultTextFormField(
                          controller: searchController,
                          type: TextInputType.text,
                          validate: (vlaue) {
                            if (vlaue != null && vlaue.isEmpty) {
                              return 'Enter text to search';
                            } else {
                              return null;
                            }
                          },
                          label: 'Search',
                          prefix: Icons.search,
                          onTap: () {},
                          onChange: (String value) {
                            if (formkey.currentState!.validate()) {
                              ShopSearchCubit.get(context).searching(value);
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (state is ShopSearchLoadingState)
                          LinearProgressIndicator(
                            color: defaultColor,
                            backgroundColor: defaultColor.withOpacity(0.3),
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (state is ShopSearchSuccessState)
                          Expanded(
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 1,
                              ),
                              itemBuilder: (context, index) => buildSearchItem(
                                  ShopSearchCubit.get(context)
                                      .model!
                                      .data!
                                      .data![index],
                                  context),
                              itemCount: ShopSearchCubit.get(context)
                                  .model!
                                  .data!
                                  .data!
                                  .length,
                            ),
                          ),
                      ],
                    ),
                  ),
                ));
          }),
    );
  }

  Widget buildSearchItem(ProductData model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image(
                    image: NetworkImage(model.image!),
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          model.price.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: defaultColor,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context).chaneFavorites(model.id!);
                          },
                          icon: (ShopCubit.get(context).favorites![model.id]!)
                              ? const Icon(
                                  Icons.favorite,
                                  color: defaultColor,
                                )
                              : const Icon(Icons.favorite_border),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
