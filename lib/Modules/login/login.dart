import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasaouq/Modules/layout/layout.dart';
import 'package:tasaouq/Modules/login/cubit.dart';
import 'package:tasaouq/Modules/login/states.dart';
import 'package:tasaouq/Modules/register/social_register_screen.dart';
import 'package:tasaouq/component/cacheHelper.dart';
import 'package:tasaouq/component/component.dart';
import 'package:tasaouq/component/constants.dart';

class Login extends StatelessWidget {
//https://student.valuxapps.com/api/
var formKey=GlobalKey<FormState>();
var emailController=TextEditingController();
var passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){
          if(state is SuccessLoginStates){
            if(state.loginModel.status!){
              // دى علشان تظهر رساله كدا على السريع بنقول فيها لليوزر مبروك او error
              // Fluttertoast.showToast(
              //     msg:state.loginModel.message,// "اكتب الايميل والباسورد صح ياابن الناصح "
              //     toastLength: Toast.LENGTH_LONG,
              //     gravity: ToastGravity.SNACKBAR,
              //     timeInSecForIosWeb: 4,
              //     backgroundColor: Colors.white,
              //     textColor: Colors.black,
              //     fontSize: 20.2
              // );
              showToast(
                  text: state.loginModel.message!,
                  state:ToastStates.SUCCECC
              );
              CacheHelper.savedData(
                  key: "token",
                  value: state.loginModel.data!.token
              ).then((value){
                token=state.loginModel.data!.token;

                navigateAndFinish(context, ShopLayout());
              });

            }else{

              showToast(
                  text: state.loginModel.message!,
                  state:ToastStates.ERROR
              );
            }
          }
        },
        builder:(context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'TASAOQ',
                style: TextStyle(
                    color: Colors.white
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          labelText: 'Email',
                          hintText: 'email',

                          prefix: Icons.email,
                          type: TextInputType.emailAddress,
                          submit: (value) {
                            if (formKey.currentState!.validate()) {

                            }
                          },
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'email must not be empty';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          labelText: 'Password',
                          prefix: Icons.lock,
                          suffixIcon: LoginCubit.get(context).icons,
                          hintText: 'password',

                          isPassword: LoginCubit.get(context).isPasswordshowen,
                          suffixPressd: ()
                          {
                            LoginCubit.get(context).ChangeVisibility();
                          },
                          type: TextInputType.visiblePassword,
                          submit: (value){
                            if(formKey.currentState!.validate())
                            {
                              LoginCubit.get(context).UserLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                              );
                            }
                          },
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'password is too short';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoadingLoginStates,
                          builder:(context)=> defaultButton(
                            text: 'login',
                            isUppercase: true,

                            onPressed: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                //   Navigator.push(context,MaterialPageRoute(builder:(context)=>NewsLayout() ));

                                LoginCubit.get(context).UserLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );

                              }
                              return null;
                            },
                          ),
                          fallback: (context)=>const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                            ),
                            TextButton(
                              onPressed: () {},
                              child: TextButton(
                                child: const Text('Register Now',),
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context)=>shopRegisterScreen()
                                  )
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      );

  }
}
