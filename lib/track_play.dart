import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:music_player/controller.dart';

class TrackPlay extends StatefulWidget {
  const TrackPlay({super.key});
  @override
  State<TrackPlay> createState() => _TrackPlayState();
}

class _TrackPlayState extends State<TrackPlay> with TickerProviderStateMixin {
  bool isLike = false;
late  int index;
  late Animation<double> turns;
var playerController=Get.put(PlayerController());
  late var animController;

  @override
  void initState() {
    super.initState();

    animController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    turns = Tween<double>(begin: 0, end: 20).animate(animController);

index= Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent),
        backgroundColor: Colors.transparent,
      ),
      body: 
        Obx(()=>
         Column(
            children: [
              Container(
                width: Get.width / 1.2,
                height: Get.height / 2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(136, 63, 81, 181),
                      const Color.fromARGB(75, 63, 81, 181),
                    ])),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  AnimatedRotation(
                      duration: Duration(seconds: 1),
                      turns: turns.value,
                      child: Icon(
                        Icons.audiotrack_rounded,
                        color: Colors.indigo,
                      )),
                  Text(playerController.playerList[index].uri.pathSegments.last),
                  Spacer(),
                  AnimatedOpacity(
                      curve: Curves.bounceIn,
                      duration: Duration(seconds: 1),
                      opacity: 1,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (isLike) {
                                isLike = false;
                                animController.reverse();
                                print(animController.value.toString());
                              } else {
                                isLike = true;
                                if (!animController.isCompleted) {
                                  animController.forward();
                                  print(animController.value.toString());
                                }
                              }
                            });
                          },
                          icon: isLike
                              ? Icon(Icons.favorite_sharp, color: Colors.red)
                              : Icon(Icons.favorite_outline_outlined)))
                ],
              ),
             Slider(
                
                value:playerController.position.value.inSeconds.toDouble()
              
              
              , max: playerController.duration.value.inSeconds.toDouble(), min: 0, onChanged: (value) {}),
           Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    
                  Text(playerController.format(playerController.position)),
                  SizedBox(width: 160,),
                  Text(playerController.format(playerController.duration)),
                ],),
              
              SizedBox(height: 60,),
              
             Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(136, 63, 81, 181),
                            const Color.fromARGB(75, 63, 81, 181),
                          ])),
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.skip_previous,
                            color: Colors.white,
                          )),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(136, 63, 81, 181),
                            const Color.fromARGB(75, 63, 81, 181),
                          ])),
                      child: IconButton(
                          onPressed: () {
        
                            
                            if (playerController.player.playing) {
                              playerController.player.pause();
                              playerController.isPlaying.value=false;
                            }else{
                               playerController.playerAction(playerController.playerList[index]);
                               playerController.player.play();
                               
                                playerController.isPlaying.value=true;
                            }
                          
                          },
                          icon: 
                          playerController.isPlaying.value?
                           Icon(Icons.pause, color: Colors.white):
                          Icon(Icons.play_arrow, color: Colors.white)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(136, 63, 81, 181),
                            const Color.fromARGB(75, 63, 81, 181),
                          ])),
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.skip_next, color: Colors.white)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(136, 63, 81, 181),
                            const Color.fromARGB(75, 63, 81, 181),
                          ])),
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.repeat_outlined, color: Colors.white)),
                    ),
                  ],
                
              )
            ],
               
              ),
        ),
    );
  }
}
