import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tasaouq/Modules/layout/cubit.dart';
import 'package:tasaouq/Modules/layout/states.dart';
import 'package:tasaouq/Modules/search/search.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context) =>ShopLayoutCubit()..getHomeData()..getCategoriesData()..getFavorites()..UserLogin(),
      child: BlocConsumer<ShopLayoutCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=ShopLayoutCubit.get(context);
          return  Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: HexColor('#BE5C1A'),
              title: const Text(
                'TASAOAQ',
              ),
              actions: [
                IconButton(
                  onPressed:(){
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context)=>Search()),
                   );
                  },
                    icon:const Icon(Icons.search),
                ),
              ],
            ),
            body: ShopLayoutCubit.get(context).Screen[cubit.currentIndex],
            bottomNavigationBar: CurvedNavigationBar(
              onTap: (index){
                cubit.changeIndex(index);
              },
              backgroundColor: Colors.white,
              buttonBackgroundColor: Colors.brown,
              color:  HexColor('#BE5C1A'),
              height: 50.0,
              animationCurve: Curves.easeInCirc,
              animationDuration: const Duration(
                milliseconds: 20,
              ),
              index: cubit.currentIndex,
              items:<Widget> [
                const Icon(Icons.production_quantity_limits,color: Colors.white,),
                const Icon(Icons.apps,color: Colors.white,),
                const Icon(Icons.favorite,color: Colors.white,),
                const Icon(Icons.settings,color: Colors.white,),

              ],
            ),


          );
        },
      ),
    );
  }
}
