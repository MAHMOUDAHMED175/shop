

 class HomeDataModel {
   bool? status;
   DataModel? data;
   HomeDataModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    data=DataModel.fromJson(json['data']);
    //data=json['data']!=null?DataModel.fromJson(json['data']):null;
   }

   }

 class DataModel{

  List<Banners> banners=[];
  List<Products> products=[];
  DataModel.fromJson(Map<String,dynamic>json){

   json['banners'].forEach((element){
    banners.add(Banners.fromJson(element));
   });
   json['products'].forEach((element){
    products.add(Products.fromJson(element));
   });
  }
  }

 class Banners{
 int? id;
 String? image;
 Banners.fromJson(Map<String,dynamic>json){
  id=json['id'];
  image=json['image'];

 }

 }
 class Products{

  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;
  Products.fromJson(Map<String,dynamic>json){

   id=json['id'];
   price=json['price'];
   oldPrice=json['old_price'];
   discount=json['discount'];
   image=json['image'];
   name=json['name'];
   inFavorites=json['in_favorites'];
   inCart=json['in_cart'];

  }

 }