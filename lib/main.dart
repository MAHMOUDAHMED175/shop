import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasaouq/Modules/layout/cubit.dart';
import 'package:tasaouq/Modules/layout/layout.dart';
import 'package:tasaouq/Modules/layout/states.dart';
import 'package:tasaouq/Modules/login/login.dart';
import 'package:tasaouq/Modules/on_bording/on_bording.dart';
import 'package:tasaouq/component/blocOpserver.dart';
import 'package:tasaouq/component/cacheHelper.dart';
import 'package:tasaouq/component/constants.dart';
import 'package:tasaouq/component/dioHelper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer=MyBlocObserver();
  DioHelper.Init();
  await CacheHelper.Initi();
  late var onBoarding=CacheHelper.getData(key:"onBoarding");
  Widget widget;
   bool? token=CacheHelper.getData(key: "token");
  if(onBoarding !=null){
    if(token!=null){
      widget=ShopLayout();
    }else{
      widget=Login();
    }

  }else{
    widget=OnBoardingScreen();
  }

  runApp( Shop(onBoarding: onBoarding,widget: widget,));
}

class Shop extends StatelessWidget {

  bool? onBoarding;
  Widget? widget;

  Shop({
    this.onBoarding,
    this.widget,
  });



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
          // علشان استدعى البيانات بتاعت التلت شاشات مع بعض
        BlocProvider(create: (BuildContext context) =>ShopLayoutCubit()..getHomeData()..getCategoriesData()..getFavorites()..UserLogin(),)
      ],
      child: BlocConsumer<ShopLayoutCubit,ShopStates>(
        listener: (context, state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home:widget,
          );
        },
      ),
    );
  }
}


