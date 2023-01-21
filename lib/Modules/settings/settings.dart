
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasaouq/Modules/layout/cubit.dart';
import 'package:tasaouq/Modules/layout/states.dart';
import 'package:tasaouq/component/component.dart';

import '../../component/constants.dart';

class Settings extends StatelessWidget {
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();
  var FormKey=GlobalKey<FormState>();
  bool isPasswordShowen =false;

  Settings({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
       var cubit=ShopLayoutCubit.get(context).loginModel;
       emailController.text=cubit.data!.email;
       nameController.text=cubit.data!.name;
       phoneController.text=cubit.data!.phone;
        return ConditionalBuilder(
          condition:ShopLayoutCubit.get(context).loginModel!=null,
          builder:(context)=> SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: FormKey,
                child: Column(
                  children: [
                    if(state is shopLoadingUpdateProfileState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height:20.0,
                    ),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.text,
                      validate: (String value){

                        if(value.isEmpty)
                        {
                          return 'name must not be empty';
                        }
                      },
                      labelText: 'Your Name',
                      prefix: Icons.person, hintText: 'name',
                    ),
                    const SizedBox(
                      height:20.0,
                    ),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      labelText: 'Your Email',
                      validate: (String value){
                        if(value.isEmpty)
                        {
                          return 'email must not be empty';
                        }
                      },
                      prefix: Icons.email, hintText: 'email',
                    ),
                    const SizedBox(
                      height:20.0,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String value){
                        if(value.isEmpty)
                        {
                          return 'phone must not be empty';
                        }
                      },
                      labelText: 'Your Phone',
                      prefix: Icons.phone, hintText: 'phone',
                    ),
                    // SizedBox(
                    //   height:20.0,
                    // ),
                    // defaultFormField(
                    //   controller: passwordController,
                    //   type: TextInputType.visiblePassword,
                    //     validate: (String value){
                    //       if(value.isEmpty)
                    //       {
                    //         return 'password must not be empty';
                    //       }
                    //     },
                    //   label: 'Your Password',
                    //   prefix: Icons.password,
                    //   suffix: shopCubit.get(context).sufixIcon,
                    //   isPassword: shopCubit.get(context).isPasswordShowen,
                    //    suffixPressed: (){
                    //     shopCubit.get(context).changePasswordForProfile();
                    //    }
                    // ),
                    const SizedBox(
                      height:20.0,
                    ),
                    defaultButton(
                      onPressed: (){
                        if(FormKey.currentState!.validate()){
                          ShopLayoutCubit.get(context).updateProfile(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                          );

                        }
                      },
                      isUppercase: true,
                      text: 'update',

                    ),


                    const SizedBox(
                      height:20.0,
                    ),
                    defaultButton(
                      onPressed: (){
                        sinOut(context);
                      },
                      text: 'LOGOUT',

                    )
                  ],
                ),
              ),
            ),
          ),
          fallback:(context)=>const Center(child: CircularProgressIndicator(),),
        );
      },

    );
  }
}
