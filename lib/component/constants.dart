
import 'package:tasaouq/Modules/login/login.dart';

import 'cacheHelper.dart';
import 'component.dart';

void sinOut(context){
  CacheHelper.sharedPreferences.remove('token').then((value){
    if(value) {
      navigateAndFinish(context, Login());
    }
  });
}

//ميثود علشان تعرض النص كامل
void printFullText(String text){
  final pattern =RegExp('{1,800}');//800 is the size of each chunk
  pattern.allMatches(text).forEach((match) =>print(match.group(0)));
}


String? token='';