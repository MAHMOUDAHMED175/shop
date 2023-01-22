
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasaouq/Modules/layout/layout.dart';
import 'package:tasaouq/Modules/register/cubit/cubit.dart';
import 'package:tasaouq/Modules/register/cubit/states.dart';
import 'package:tasaouq/component/cacheHelper.dart';
import 'package:tasaouq/component/component.dart';
import 'package:tasaouq/component/constants.dart';

class shopRegisterScreen extends StatefulWidget {

  @override
  State<shopRegisterScreen> createState() => _shopRegisterScreenState();
}

class _shopRegisterScreenState extends State<shopRegisterScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>shopRegisterCubit(),
        child: BlocConsumer<shopRegisterCubit , shopRegisterStates>(
          listener: (context, state) {

            if(state is shopRegisterSuccessState){
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
                print(state.loginModel.message);
                print(state.loginModel.status);
                CacheHelper.savedData(
                    key: 'token',
                    value: state.loginModel.data!.token
                ).then((value){
                  token=state.loginModel.data!.token;

                  navigateAndFinish(context, const ShopLayout());
                });

              }else{

                showToast(
                    text: state.loginModel.message!,
                    state:ToastStates.ERROR
                );
              }
            }



          },
          builder: (context, state){
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
                            'REGISTER',
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          defaultFormField(
                            controller: nameController,
                            labelText: 'UserName',
                            prefix: Icons.person,
                            submit: (value) {
                              if (formKey.currentState!.validate()) {
                              }
                            },
                            validate: (String value)
                            {
                              if(value.isEmpty)
                              {
                                return 'userName must not be empty';
                              }
                              //8888
                            },
                            type: TextInputType.name,
                            hintText: 'name',
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                            controller: emailController,
                            labelText: 'Email',
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
                            }, hintText: 'email',
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                            controller: passwordController,
                            labelText: 'Password',
                            prefix: Icons.lock,
                            suffixIcon: shopRegisterCubit.get(context).sufixIcon,
                            isPassword: shopRegisterCubit.get(context).isPassword,
                            suffixPressd: ()
                            {
                              setState(()
                              {
                                shopRegisterCubit.get(context).changePasswordVisibility();
                              });
                            },
                            type: TextInputType.visiblePassword,
                            submit: (value){
                              if(formKey.currentState!.validate())
                              {

                              }
                            },
                            validate: (String value)
                            {
                              if(value.isEmpty)
                              {
                                return 'password is too short';
                              }
                              return null;
                            }, hintText: 'password',
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                            controller:phoneController,
                            labelText: 'Phone',
                            prefix: Icons.phone,
                            type: TextInputType.phone,
                            submit: (value) {
                              if (formKey.currentState!.validate()) {

                              }
                            },
                            validate: (String value)
                            {
                              if(value.isEmpty)
                              {
                                return 'phone must not be empty';
                              }

                              return null;
                            }, hintText: 'phone',
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! shopRegisterLoadingState,
                            builder:(context)=> defaultButton(
                              text: 'REGISTER',
                              onPressed: ()
                              {

                                if(formKey.currentState!.validate())
                                {
                                  shopRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text
                                  );

                               // Navigator.push(context,MaterialPageRoute(builder:(context)=>shopLayout() ));
                                }
                              },
                            ),
                            fallback: (context)=>const Center(child: CircularProgressIndicator()),

                          ),


                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        )
    );

  }
}
