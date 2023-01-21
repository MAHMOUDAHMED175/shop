class  CategorisModel{
  bool? status;
  CategoriesData? data;

  CategorisModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    data=CategoriesData.fromJson(json['data']);

  }
}
class CategoriesData{
  int? current_page;
  List<Data> data=[];

  CategoriesData.fromJson(Map<String,dynamic> json){
    current_page=json['current_page'];
    json['data'].forEach((element){
      data.add(Data.fromJson(element));
    });
  }
}
class Data{
  late int id;
  late String name;
  late String image;

  Data.fromJson(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}