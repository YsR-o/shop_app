import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import '../../../shared/components/conestants.dart';
import '../../layout/shop_app/home_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cash_helper.dart';
import '../../shared/styles/colors.dart';
import '../register/shop_register.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({super.key});
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status!) {
              CashHelper.saveData(
                      key: 'token', value: state.loginModel.data?.token)
                  .then((value) {
                token = state.loginModel.data?.token!;
                navigateAndKill(context, const ShopLayout());
              });
              showToast(
                  text: state.loginModel.message.toString(),
                  state: ToastStates.SUCCESS);
            } else {
              showToast(
                  text: state.loginModel.message.toString(),
                  state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(color: Colors.black)),
                        Text('login now to browse our hot offers',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: Colors.grey)),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            label: 'Email',
                            prefix: Icons.email_outlined,
                            validate: (value) {
                              if (value != null && value.isEmpty) {
                                return 'please enter your Email';
                              }
                              return null;
                            },
                            onTap: () {},
                            onChange: (value) {
                              return null;
                            }),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            label: 'PassWord',
                            isPassword: ShopLoginCubit.get(context).isPassword,
                            prefix: Icons.lock_outline,
                            suffix: ShopLoginCubit.get(context).suffix,
                            suffixPressed: () {
                              ShopLoginCubit.get(context).changeVisibility();
                            },
                            validate: (value) {
                              if (value != null && value.length < 4) {
                                return 'password is too short';
                              }
                              return null;
                            },
                            onTap: () {},
                            onChange: (value) {
                              return null;
                            }),
                        const SizedBox(
                          height: 15,
                        ),
                        state is ShopLoginLoadingState
                            ? const Center(child: CircularProgressIndicator())
                            : Container(
                                width: double.infinity,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: defaultColor,
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    final isVaildForm =
                                        formkey.currentState!.validate();
                                    if (isVaildForm) {
                                      ShopLoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  child: const Text(
                                    'LOGIN',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?'),
                            TextButton(
                                onPressed: () {
                                  navigateTo(
                                    context,
                                    ShopRegisterScreen(),
                                  );
                                },
                                child: const Text('REGISTER'))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
