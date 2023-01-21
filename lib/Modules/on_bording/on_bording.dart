import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tasaouq/Modules/login/login.dart';
import 'package:tasaouq/component/cacheHelper.dart';
import 'package:tasaouq/component/component.dart';
class BoardingModel {
  String? image;
  String? title;
  String? body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});


  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var borderController=PageController();
  bool isLast=false;
  List<BoardingModel> boarding=[
    BoardingModel(
      image: 'assets/images/shop.png',
      title: 'Enjoy ',
      body: 'the most exclusive and discounted offers',

    ),
    BoardingModel(
      image: 'assets/images/discount.png',
      body:" what you want with discount coupons and easy payment",
      title: 'Order',
    ),
    BoardingModel(
      image: 'assets/images/payment.png',
      body: 'your order within the specified time with easy delivery',
      title: 'Receive',
    ),

  ];
void submit(){
  CacheHelper.savedData(key:"onBoarding", value: true).then((value){

    if(value){
      navigateAndFinish(context,Login());
    }
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          actions: [
            TextButton(
              onPressed:(){

                submit();
              },
              child:const Text(
                'SKIP',
                style: TextStyle(
                  color: Colors.white
                ),

              ),
            ),
          ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              //ال pageView دي الصفحه اللى قبل تسجل الدخول اللى بتعرفك على التطبيق
              child: PageView.builder(
                reverse: false,


                onPageChanged: (int index){
                  if(index==boarding.length-1)
                    {
                      setState(() {
                        isLast=true;
                      });
                    }else
                      {

                        setState(() {
                          isLast=false;
                        });
                      }

                },
                controller:borderController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height:40.1,
            ),
            Row(
              children: [
                //دى علشان شكل التلت نقط اللى هتتحرك لما احرك الشاشات والنقط تتحرك معاها اسمها //indacator

                SmoothPageIndicator(
                  controller:borderController,
                  //علشان شكل التلت نقط
                  effect:const ExpandingDotsEffect(
                    dotColor:Colors.blueAccent,
                    activeDotColor:Colors.orange,
                    dotHeight:15,
                    expansionFactor:4,//دي اللى بتوصل بين النقطتين
                    dotWidth:15,
                    spacing:5,
                  ),
                  count:boarding.length,
                ),

                const Spacer(),//علشان يرمى اللى بعديه فى اخر الصفحه يعنى بيبعد اللى قبليه عن اللى بعديه
                FloatingActionButton(
                  onPressed: (){
                    borderController.nextPage(duration:  const Duration(
                      microseconds: 20
                    ), curve: Curves.easeOutQuart);
                    if(isLast){
                      submit();
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel boardingForModel)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:[
      Expanded(
        child: Image(
            image: AssetImage(boardingForModel.image!)
        ),
      ),
      const SizedBox(
        height:20.1,
      ),
      Text(
          boardingForModel.title!,
        style: const TextStyle(
            fontSize: 30.2
        ),
      ),
      const SizedBox(
        height:20.1,
      ),
      Text(
          boardingForModel.body!,
        style: const TextStyle(
            fontSize: 15.1
        ),
      ),
      const SizedBox(
        height:15.1,
      ),
    ],
  );
}