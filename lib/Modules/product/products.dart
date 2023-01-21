




import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasaouq/Modules/categories/caertgoris_model.dart';
import 'package:tasaouq/Modules/layout/LayoutModel.dart';
import 'package:tasaouq/Modules/layout/cubit.dart';
import 'package:tasaouq/Modules/layout/states.dart';
import 'package:tasaouq/component/component.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopStates>(
       listener: (context,state){
         if(state is ShopSuccessFavoritesStates)
           {
             if(!state.model.status!)
               {
                 showToast(
                     text:state.model.message!,
                     state: ToastStates.ERROR,
                 );
               }
           }
       },
       builder: (context,state){
         return ConditionalBuilder(
             condition: ShopLayoutCubit.get(context).homeModel!=null &&ShopLayoutCubit.get(context).categorisModel!=null ,
             builder: (context)=>ProductItems(ShopLayoutCubit.get(context).homeModel,ShopLayoutCubit.get(context).categorisModel ,context),
           fallback: (context)=>const Center(child: CircularProgressIndicator(),),
         );
       },
    );
  }
  Widget  ProductItems(HomeDataModel model,CategorisModel categorisModel,context){
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //دى علشان أعرض صور وتتحرك ورى بعض لوحدها اسمها banners
          CarouselSlider(
            items: model.data!.banners.map((e) =>Image(
              image: NetworkImage('${e.image}',),
              fit: BoxFit.cover,
              width:double.infinity,
            ),).toList(),
            options: CarouselOptions(
              height: 200,
              initialPage: 0,// الصفحه اللى هيبدء بيها هيا الاولى فى الليست رقم 1
              autoPlay: true,// هتشتغل لوحدها
              viewportFraction:1 ,//علشان الصوره تملى المساحه بتاعتها
              autoPlayInterval: const Duration(seconds: 6),//الوقت اللى   محتاجه علشان يحول لصفحه غير اللى موجوده
              autoPlayAnimationDuration: const Duration(seconds: 4),// الوقت لعرض الانيميشن عند التحويل بين الشاشات
              autoPlayCurve: Curves.ease,//شكل التحويل بين الشاشات
              scrollDirection: Axis.horizontal,
              reverse: false,//علشان لما احول يمين ميعكسش ويعمل شمال
              enableInfiniteScroll: true,//يفضل يلف علطول
            ),
          ),
          const SizedBox(
            height:20.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,

                  ),
                ),
                const SizedBox(
                  height:20.0,
                ),
                Container(
                  height: 100.0,
                  child: ListView.separated(
                    scrollDirection:  Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index)=> buildCategoriesItem(categorisModel.data!.data[index]),
                    separatorBuilder:(context,index)=>const SizedBox(
                      width: 10.0,
                    ),
                    itemCount: categorisModel.data!.data.length,
                  ),
                ),
                const SizedBox(
                  height:20.0,
                ),
                const Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,

                  ),
                ),

              ],
            ),
          ),
          const SizedBox(
            height:20.0,
          ),
          Container(
            color: Colors.grey[400],
            child: GridView.count(
              shrinkWrap: true,//علشان يسكرول الكل مع بعض
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,//عدد العناصر اللى هتكىن فى الصف
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
              childAspectRatio:1/1.7,//الطول على العرض كمساحه
              children: List.generate(
                model.data!.products.length,
                    (index) => buildGridView(model.data!.products[index],context),
              ),
            ),
          )

        ],
      ),
    );
  }
  Widget buildGridView(Products model,context)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image:NetworkImage(model.image),
              fit:BoxFit.cover,
              height:180.0,
              width:double.infinity,
            ),
            if(model.discount !=0)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.red,
                ),

                padding: const EdgeInsets.all(6.0),
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 13.0,
                  ),
                ),
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(

                model.name,
                //textDirection: TextDirection.rtl,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(

                  height: 1.3,
                  fontSize: 14.0,
                ),
              ),
              Row(
                children: [
                  Text(
                    "${model.price.round()}",//علشان يدينى رقم  integer
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 2.0,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(
                    width:10.0,
                  ),
                  if(model.discount !=0)
                    Text(
                      '${model.oldPrice.round()}',//علشان يدينى رقم  integer
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,// علشان اعمل خط على السعر القديم
                        fontSize: 12.0,
                        height: 2.0,
                        color: Colors.grey[500],
                      ),
                    ),
                  const Spacer(),//علشان اودى العنصر اللى  بعده للاخر وافصل مابين اللى قبله واللى بعده بمسافه كwidth
                  IconButton(
                    onPressed: (){
                      ShopLayoutCubit.get(context).ChangeFavorites(model.id);


                    },
                    icon: CircleAvatar(
                      radius: 16.0,
                      backgroundColor: ShopLayoutCubit.get(context).favorieties[model.id]!?Colors.blue:Colors.grey,
                      child: const Icon(
                        Icons.favorite_border,
                        size: 20.0,
                        color: Colors.white,
                      ),
                    ),),

                ],
              ),

            ],
          ),
        ),


      ],

    ),
  );

  Widget buildCategoriesItem(Data modelDataForCategories){
    return Stack(

      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: NetworkImage(modelDataForCategories.image),
          fit: BoxFit.cover,
          height: 100.0,
          width: 100.0,
        ),
        Container(
          color: Colors.black.withOpacity(0.6),
          width: 100.0,
          child: Text(
            modelDataForCategories.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,

            ),
          ),
        ),

      ],
    );
  }

}
