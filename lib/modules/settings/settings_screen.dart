import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/shop_app/cubit/cubit.dart';
import '../../layout/shop_app/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/conestants.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          nameController.text = ShopCubit.get(context).loginModel!.data!.name!;
          emailController.text =
              ShopCubit.get(context).loginModel!.data!.email!;
          phoneController.text =
              ShopCubit.get(context).loginModel!.data!.phone!;
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  if (state is ShopLoadingUpdateUserState)
                    const LinearProgressIndicator(),
                  defaultTextFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    label: 'Name',
                    prefix: Icons.person_outline,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    label: 'Email Address',
                    prefix: Icons.email_outlined,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    label: 'Phone ',
                    prefix: Icons.phone_android,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        ShopCubit.get(context).updateUserData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                      }
                    },
                    text: 'UPDATE',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                    onPressed: () {
                      singOut(context);
                    },
                    text: 'Logout',
                  ),
                ],
              ),
            ),
          );
        });
  }
}
