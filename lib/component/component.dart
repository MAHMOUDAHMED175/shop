


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tasaouq/Modules/layout/cubit.dart';

Widget defaultFormField({
    required TextEditingController controller,
   required TextInputType type,
  Function? suffixPressd,validate,
  bool isPassword=false,
  Function? submit,
   IconData? suffixIcon,
  required String hintText,labelText,
  required IconData prefix,
})=>TextFormField(
    keyboardType:type,
    controller: controller,
    obscureText: isPassword,
    onFieldSubmitted: (s){
      submit!(s);
    },
    validator: (s){
      validate(s);
    },
  decoration: InputDecoration(
    prefixIcon:Icon(prefix),
    hintText: hintText,
    suffixIcon: IconButton(
      onPressed:(){
        suffixPressd!();
      } ,
      icon:Icon(suffixIcon),

    ),
    labelText: labelText,
    border: const OutlineInputBorder(),
  ),
    );
Widget defaultButton({
  required Function onPressed,
  required String text,
  bool isUppercase=true,
})=>Container(
  color: Colors.blue,
  width: double.infinity,
  child:   MaterialButton(

    child:Text(
        isUppercase?text.toUpperCase():text,
      style: const TextStyle(
        color: Colors.white
      ),
    ),
    onPressed: (){
      onPressed();
    },
  ),
);


void navigateAndFinish(context ,widget)=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder:(context)=> widget
    ),
        (route) => false
);

void showToast({
  required String text,
  required ToastStates state,
}){
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: toastColor(state),
      textColor: Colors.white,
      fontSize: 15.0
  );

}

enum ToastStates{SUCCECC,ERROR,WARNING}

Color toastColor(ToastStates state){

Color color;
  switch(state){

    case ToastStates.SUCCECC:
      color= Colors.green;
      break;
    case ToastStates.ERROR:
      color= Colors.red;
      break;
    case ToastStates.WARNING:
      color= Colors.yellow;
      break;
  }
  return color;


}



Widget BuildListProduct(model,context,{bool isOldPrise=false}){


  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(image:NetworkImage(model.image),
                // fit:BoxFit.cover,
                height:150.0,
                width:150.0,
              ),
              if(model.discount !=0&&isOldPrise)
                Expanded(
                  child: Container(
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
                ),
            ],
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    height: 1.3,
                    fontSize: 14.0,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      maxLines: 2,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14.0,
                        height: 2.0,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(
                      width:10.0,
                    ),
                    if(model.discount!=0&& isOldPrise)
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
                        backgroundColor :ShopLayoutCubit.get(context).favorieties[model.id]!?Colors.blue:Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          size: 20.0,
                          color: Colors.grey[200],
                        ),
                      ),),

                  ],
                ),

              ],
            ),
          ),


        ],

      ),
    ),
  );
}
