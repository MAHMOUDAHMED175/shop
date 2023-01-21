



import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasaouq/Modules/categories/caertgoris_model.dart';
import 'package:tasaouq/Modules/favorities/change_favorites_model.dart';
import 'package:tasaouq/Modules/favorities/favorities.dart';
import 'package:tasaouq/Modules/layout/LayoutModel.dart';
import 'package:tasaouq/Modules/layout/states.dart';
import 'package:tasaouq/component/dioHelper.dart';
import 'package:tasaouq/component/endPoints.dart';

import '../../component/constants.dart';
import '../../models/login_model.dart';
import '../categories/ctegories.dart';
import '../favorities/favorites model.dart';
import '../product/products.dart';
import '../search/search.dart';
import '../settings/settings.dart';

class ShopLayoutCubit extends Cubit<ShopStates>{
  ShopLayoutCubit() : super(ShopInitiStates());

  static ShopLayoutCubit get(context)=>BlocProvider.of(context);



  int currentIndex=0;
  void changeIndex(int index){
    currentIndex=index;
    emit(ShopChangeBottomNavStates());
  }
  List<Widget> Screen=[
    ProductsScreen(),
    Categories(),
    Favorities(),

    Settings(),

    Search(),
  ];



  late HomeDataModel homeModel;
  Map<int,bool> favorieties={};
  void getHomeData(){


    emit(ShopLoadingStates());
    DioHelper.getData(
        url: HOME,
        token: token
    ).then((value) {
      homeModel = HomeDataModel.fromJson(value.data);
      homeModel.data!.products.forEach((element) {
        favorieties.addAll({
          element.id:element.inFavorites
        });
      });
      emit(ShopSuccessProductStates());
      printFullText(homeModel.data!.banners[0].image!);

    }).catchError((error){
      print(error.toString());
      emit(ShopErrorProductStates());
    });
  }





  late CategorisModel categorisModel;
  void getCategoriesData(){
    DioHelper.getData(
        url: CATEGORIES,
    ).then((value) {
      categorisModel=CategorisModel.fromJson(value.data);
      emit(ShopSuccessCategoriesStates());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesStates());
    });
  }




  late FavoritesModel favoritesModel;
  void ChangeFavorites(int productId){
    favorieties[productId]=!favorieties[productId]!;
    emit(ShopFavoritesStates());
    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id':productId,
        },
      token: token
    ).then((value){
      favoritesModel=FavoritesModel.fromJson(value.data);
      print(value.data);
      if(!favoritesModel.status!){

        favorieties[productId]=!favorieties[productId]!;

      }
      else{
        getFavorites();
      }
      emit(ShopSuccessFavoritesStates(favoritesModel));
    }).catchError((error){

      print(error.toString());
      // favorieties[productId]=!favorieties[productId];

      emit(ShopErrorFavoritesStates());
    });
  }






  late FavoritesModels favoritesModels;

  void getFavorites(){
    emit(shopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
     ).then((value)
     {
      favoritesModels=FavoritesModels.fromJson(value.data);

      printFullText(value.data.toString());

      emit(ShopSuccessGetFavoritesStates());
    }).catchError((error)
    {
      print(error.toString());


      emit(ShopErrorGetFavoritesStates());
    });
  }












  late LoginModel loginModel;
  void UserLogin(){
    emit(shopLoadingGetUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token
    ).then((value) {
      print(value.data);
      loginModel=LoginModel.fromJson(value.data);
      emit(ShopSuccessGetUserDataStates(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetUserDataStates());
    });
  }
  void updateProfile(
      {
        String? name,
        String? email,
        String? phone,
      }
      ){
    emit(shopLoadingUpdateProfileState());
    DioHelper.putData(
      url:UPDATE_PROFILE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },
    ).then((value) {
      loginModel=LoginModel.fromJson(value.data);
      emit(shopSuccesUpdateProfileState(loginModel));
    }).catchError((error){
      emit(shopErrorUpdateProfileState());
    }
    );

  }





}