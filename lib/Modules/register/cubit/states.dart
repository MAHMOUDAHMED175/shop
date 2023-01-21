

import 'package:tasaouq/models/login_model.dart';

abstract class shopRegisterStates{}
class shopRegisterInitiState extends shopRegisterStates{}
class shopRegisterLoadingState extends shopRegisterStates{}
class shopRegisterSuccessState extends shopRegisterStates{
  final LoginModel loginModel;

  shopRegisterSuccessState(this.loginModel);
}
class shopRegisterErrorState extends shopRegisterStates{
  final String Error;
  shopRegisterErrorState(this.Error);
}
class shopRegisterChangePassowrdVisibilityState extends shopRegisterStates{}