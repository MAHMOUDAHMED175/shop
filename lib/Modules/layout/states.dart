


import 'package:tasaouq/Modules/favorities/change_favorites_model.dart';
import 'package:tasaouq/models/login_model.dart';

abstract class ShopStates{}

class ShopInitiStates extends ShopStates{}
class ShopLoadingStates extends ShopStates{}
class ShopSuccessProductStates extends ShopStates{}
class ShopErrorProductStates extends ShopStates{}

class shopLoadingGetFavoritesState extends ShopStates{}
class ShopErrorGetFavoritesStates extends ShopStates{}
class ShopSuccessGetFavoritesStates extends ShopStates{}



class shopLoadingGetUserDataState extends ShopStates{}
class ShopErrorGetUserDataStates extends ShopStates{}
class ShopSuccessGetUserDataStates extends ShopStates{
  final LoginModel loginModel;
  ShopSuccessGetUserDataStates(this.loginModel);
}



class shopLoadingUpdateProfileState extends ShopStates{

}

class shopSuccesUpdateProfileState extends ShopStates{

  final LoginModel loginModel;

  shopSuccesUpdateProfileState(this.loginModel);

}

class shopErrorUpdateProfileState extends ShopStates{}




class ShopSuccessCategoriesStates extends ShopStates{}
class ShopErrorCategoriesStates extends ShopStates{}


class ShopFavoritesStates extends ShopStates{}
class ShopSuccessFavoritesStates extends ShopStates{
  final FavoritesModel model;

  ShopSuccessFavoritesStates(this.model);
}
class ShopErrorFavoritesStates extends ShopStates{}


class ShopChangeBottomNavStates extends ShopStates{}