

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasaouq/Modules/register/cubit/states.dart';
import 'package:tasaouq/component/dioHelper.dart';
import 'package:tasaouq/component/endPoints.dart';
import 'package:tasaouq/models/login_model.dart';

class shopRegisterCubit extends Cubit<shopRegisterStates>{
  shopRegisterCubit() : super(shopRegisterInitiState());

  static shopRegisterCubit get(context)=>BlocProvider.of(context);

  late LoginModel loginModel;
  void userRegister({
  required String name,
  required String email,
  required String password,
  required String phone,
  })
  {
    emit(shopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name':name,
        'email':email,
        'password':password,
        'phone':phone,

      },
    ).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      emit(shopRegisterSuccessState(loginModel));
    }).catchError((error){
      emit(shopRegisterErrorState(error.toString()));
    });
  }

  IconData sufixIcon=Icons.visibility;
  bool isPassword=true;


  void changePasswordVisibility(){
    isPassword=!isPassword;
    sufixIcon=isPassword ?Icons.visibility_off:Icons.visibility;
    emit(shopRegisterChangePassowrdVisibilityState());
  }


}