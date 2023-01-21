
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasaouq/Modules/layout/cubit.dart';
import 'package:tasaouq/Modules/layout/states.dart';
import 'package:tasaouq/component/component.dart';



class Favorities extends StatelessWidget {
  const Favorities({super.key});

  @override
  Widget build(BuildContext context,) {
    return BlocConsumer<ShopLayoutCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition:state is! shopLoadingGetFavoritesState,
          builder:(context)=> ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context,index)=>BuildListProduct(ShopLayoutCubit.get(context).favoritesModels.data!.data![index].product,context,isOldPrise: true),
            separatorBuilder: (context,index)=>const SizedBox(
              height: 10.0,
            ),
            itemCount: ShopLayoutCubit.get(context).favoritesModels.data!.data!.length,
          ),
          fallback:(context)=>const Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}
