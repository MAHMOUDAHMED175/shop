import 'package:tasaouq/models/login_model.dart';

abstract class LoginStates{}

class InitiLoginStates extends LoginStates{}
class LoadingLoginStates extends LoginStates{}
class SuccessLoginStates extends LoginStates{
  final LoginModel loginModel;

  SuccessLoginStates(this.loginModel);
}
class ErrorLoginStates extends LoginStates{
  final String error;

  ErrorLoginStates(this.error);
}
class ChangeVisibilityLoginStates extends LoginStates{}