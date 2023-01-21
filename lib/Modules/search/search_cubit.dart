
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasaouq/Modules/search/search_states.dart';
import 'package:tasaouq/Modules/search/searh_model.dart';
import 'package:tasaouq/component/constants.dart';
import 'package:tasaouq/component/dioHelper.dart';

import '../../component/endPoints.dart';

class SearchCubit extends Cubit<searchStates>{
  SearchCubit() : super(searchInitiState());

  static SearchCubit get(context)=>BlocProvider.of(context);


  late SearchModel model;

  void search(String text){
    emit(searchLoadingState());
    DioHelper.postData(
      url:SEARCH,
      token:token,
      data:{
        'text':text,
      },
    ).then((value)
    {
      model=SearchModel.fromJson(value.data);
      emit(searchSuccessState());
    }).catchError((error)
    {
      print(error.toString());


      emit(searchErrorState());
    });
  }


}