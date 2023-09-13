import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:music_player/Controller/controller.dart';

class TrackPlay extends StatefulWidget {
  const TrackPlay({super.key});
  @override
  State<TrackPlay> createState() => _TrackPlayState();
}

class _TrackPlayState extends State<TrackPlay> with TickerProviderStateMixin {
  bool isLike = false;
  late int index;
  late Animation<double> turns;
  var playerController = Get.put(PlayerController());
  late var animController;

  @override
  void initState() {
    super.initState();

    animController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    turns = Tween<double>(begin: 0, end: 20).animate(animController);

    index = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
         foregroundDecoration: BoxDecoration(
            color:Colors.transparent,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
              Color(0xfff02fc2),
              Color(0xfffed1c7),
            ])
          ),
      child: Scaffold(
       backgroundColor: Colors.transparent,
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
            systemNavigationBarDividerColor: Colors.transparent,
         systemNavigationBarIconBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.transparent),
          backgroundColor: Colors.transparent,
        ),
        body: Obx(
          () =>  Column(
              children: [
            playerController.songs[index].ima==null ? 
            Container(
                  width: Get.width / 1.2,
                  height: Get.height / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(136, 63, 81, 181),
                        const Color.fromARGB(75, 63, 81, 181),
                      ])),
                ): 
                 Container(
                  width: Get.width / 1.2,
                  height: Get.height / 2,
                  decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(20),
                     image: DecorationImage(
                      fit: BoxFit.fill,
                      image: 
                     AssetImage(playerController.songs[index].ima!))),
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
                Padding(
                  padding: const EdgeInsets.only(left:25,right:25,top:10),
                  child: ProgressBar(
                    bufferedBarColor: Color.fromARGB(38, 83, 109, 254),
                    progressBarColor: Color.fromARGB(70, 132, 141, 194),
                    baseBarColor: Color.fromARGB(54, 62, 72, 138),
                    thumbColor: Color.fromARGB(158, 63, 81, 181),
                    progress: playerController.progress.value,
                    buffered: playerController.buffer.value,
                    total: playerController.player.duration ?? Duration(seconds: 0),
                    onSeek: (position) async {
          
                      playerController.player.seek(position);
                       if (playerController.player.playing) {
                        playerController
                            .playerAction();
                      } else if (position <= Duration(seconds: 0)) {
                        await playerController.player.seekToNext();
                        playerController.currectFileIndex.value =
                            playerController.player.currentIndex!;
                        playerController.checkTimer();
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
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
                          onPressed: () async {
                            await playerController.player.seekToPrevious();
                            playerController.currectFileIndex.value =
                                playerController.player.currentIndex!;
          
                            playerController.checkTimer();
                          },
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
                            playerController.player.playing
                                ? playerController.timer!.cancel()
                                : playerController.playerAction(
                                    );
          
                            if (playerController.player.playing) {
                              playerController.player.pause();
                              playerController.isPlaying.value = false;
                            } else {
                              playerController.player.play();
                              playerController.isPlaying.value = true;
                            }
                            playerController.currectFileIndex.value =
                                playerController.player.currentIndex!;
                          },
                          icon: playerController.isPlaying.value
                              ? Icon(Icons.pause, color: Colors.white)
                              : Icon(Icons.play_arrow, color: Colors.white)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(136, 63, 81, 181),
                            const Color.fromARGB(75, 63, 81, 181),
                          ])),
                      child: IconButton(
                          onPressed: () async {
                            await playerController.player.seekToNext();
                            playerController.currectFileIndex.value =
                                playerController.player.currentIndex!;
          
                            playerController.checkTimer();
                          },
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
                          onPressed: () {
          
                             playerController.setLoopMode();
          
          
          
                          },
                          icon: Icon(
                            
                            
                            Icons.repeat_outlined, color: playerController.isLoopMode.value? Colors.blue: Colors.white,
          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        
      ),
    );
  }
}
