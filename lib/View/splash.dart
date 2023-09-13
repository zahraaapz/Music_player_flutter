import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_player/View/playList.dart';
import 'package:get/get.dart';


class Splash extends StatefulWidget {
  const Splash({
    super.key,
  });

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash>
    with SingleTickerProviderStateMixin {
  late var animationController;
 
  late Animation<double>x;
  late Animation<double> y ;

  @override
  void initState() {

    super.initState();
    animationController =
        AnimationController(vsync: this,duration: Duration(seconds:1));
     
     x =
      Tween<double>(begin: 0, end: 50).animate(animationController);
         y=
      Tween<double>(begin: 500, end: 0).animate(animationController);
    
          animationController.forward();

        Future.delayed(Duration(seconds: 3)) .then((value){
        
         Get.to(Playlist());}); 
          
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent
          ),
        ),
        body: Center(
          child: AnimatedBuilder(
            animation: CurvedAnimation(parent: animationController, curve: Curves.bounceIn),
            builder: (context, child) => 

           Stack(
              children: [
                  AnimatedPositioned(
                    bottom:y.value ,
                    left: Get.width/10,
                    duration: Duration(seconds: 2),
                    child: Container(
                      width: Get.width/2.2,
                      height:  Get.height/2.6,
                      decoration: BoxDecoration(
                        gradient:LinearGradient(colors: [   
                              Color(0xff42e695),
              Color(0xff3bb2b8),]) ,
                        shape: BoxShape.circle,
                        
                       
                      ),
                    ),
                  ),

                Positioned(
                  top:Get.height/2.3,
                  right: Get.width/2.5,
                  child: Transform.rotate(
                          
                    angle: x.value,
                    child:SvgPicture.asset('assets/image/2.svg',color:Colors.indigo,width: 120,height: 120,)
                        
                    //SvgPicture.asset('assets/2.svg',height: 200,width: 200,color: Colors.indigo,),
                  ),
                ),
             AnimatedPositioned(
                    top:y.value ,
                    right: Get.width/10,
                    duration: Duration(seconds: 2),
                    child: Container(
                          width: Get.width/2.2,
                      height:  Get.height/2.6,
                      decoration: BoxDecoration(
                        gradient:LinearGradient(
                          
                          colors: [   
              Color(0xfff02fc2),
              Color(0xfffed1c7),]) ,
                        shape: BoxShape.circle,
                        
                       
                      ),
                    ),
                  ),   ],
            ),
          ),
        ));
  }
}
