

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasaouq/Modules/login/states.dart';
import 'package:tasaouq/component/dioHelper.dart';
import 'package:tasaouq/models/login_model.dart';

import '../../component/endPoints.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() :super(InitiLoginStates());
  static LoginCubit get(context)=>BlocProvider.of(context);

  bool isPasswordshowen=true;
  IconData icons=Icons.visibility_off;
  void ChangeVisibility(){
    isPasswordshowen=!isPasswordshowen;
    icons=isPasswordshowen?Icons.visibility_off:Icons.visibility;
    emit(ChangeVisibilityLoginStates());
  }

  late LoginModel loginModel;
  void UserLogin({
    required String email,
    required String password,
}){
    emit(LoadingLoginStates());
    DioHelper.postData(
        url: LOGIN,
        data: {
          "email":email,
          "password":password,
        },
    ).then((value) {
      print(value.data);
      loginModel=LoginModel.fromJson(value.data);
      emit(SuccessLoginStates(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ErrorLoginStates(error.toString()));
    });
  }




}