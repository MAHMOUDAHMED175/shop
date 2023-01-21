
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tasaouq/Modules/search/search_cubit.dart';
import 'package:tasaouq/Modules/search/search_states.dart';
import 'package:tasaouq/component/component.dart';

class Search extends StatelessWidget {


  Search({super.key});
final searchController=TextEditingController();
final  FormKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>SearchCubit(),
      child: BlocConsumer<SearchCubit,searchStates>(
          listener:(context, state) {},
          builder:(context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: HexColor('#BE5C1A'),

                title:
                const Text('TASAOQ',
                ),

              ),
              body: Form(
                key: FormKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormField(
                        controller:searchController,
                        type: TextInputType.text,
                        validate: (String value){
                          {
                            if(value.isEmpty){
                              return 'type to search';
                            }
                            return null;
                          }
                        },
                        submit: (String text){

                          SearchCubit.get(context).search(text);


                          if(FormKey.currentState!.validate()){

                          }
                        },
                        labelText: 'search',
                        prefix: Icons.search, hintText: 'search',
                      ),

                      const SizedBox(
                        height:20.0,
                      ),

                      if(state is searchLoadingState)
                        const LinearProgressIndicator(),



                      const SizedBox(
                        height:20.0,
                      ),
                      if(state is searchSuccessState)
                        Expanded(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context,index)=>BuildListProduct(
                              SearchCubit.get(context).model.data!.data![index],
                              context,
                            ),
                            separatorBuilder: (context,index)=>const SizedBox(
                              height: 10.0,
                            ),
                            itemCount: SearchCubit.get(context).model.data!.data!.length,
                          ),
                        ),



                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
