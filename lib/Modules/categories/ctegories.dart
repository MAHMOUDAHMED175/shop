
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasaouq/Modules/categories/caertgoris_model.dart';
import 'package:tasaouq/Modules/layout/cubit.dart';
import 'package:tasaouq/Modules/layout/states.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopLayoutCubit cubit=ShopLayoutCubit.get(context);
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context,index)=>buildCategoriesItem(cubit.categorisModel.data!.data[index]),
          separatorBuilder: (context,index)=>const SizedBox(
            height: 10.0,
          ),
          itemCount: cubit.categorisModel.data!.data.length,
        );
      },
    );
  }
  Widget buildCategoriesItem(Data model){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image:NetworkImage(model.image),
            height: 100.0,
            width: 100.0,
          ),
          const SizedBox(
            width: 20.0,
          ),
          Text(
            model.name,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Icon(
              Icons.arrow_forward_ios
          )
        ],
      ),
    );
  }
}
