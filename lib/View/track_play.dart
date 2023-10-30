import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:music_player/Controller/controller.dart';
import 'package:music_player/View/playList.dart';

class TrackPlay extends StatefulWidget {
  const TrackPlay({super.key});
  @override
  State<TrackPlay> createState() => _TrackPlayState();
}

class _TrackPlayState extends State<TrackPlay> with TickerProviderStateMixin {
  bool isLike = false;
  RxInt index = 0.obs;
  var controller=Get.find<PlayerController>();
  late Animation<double> turns;
  late var animController;

  @override
  void initState() {
    super.initState();

    animController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    turns = Tween<double>(begin: 0, end: 20).animate(animController);

    index.value = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: ([
          Color(0xfffbc7d4),
          Color(0xff9796f0),
        ])),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                
                   
                Get.offAll(Playlist());

              },
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
              systemNavigationBarDividerColor: Colors.transparent,
              systemNavigationBarIconBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.transparent),
          backgroundColor: Colors.transparent,
        ),
        body: Obx(
          () => Column(
            children: [
              controller.songs[index.value].ima == null
                  ? Container(
                      width: Get.width / 1.2,
                      height: Get.height / 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(colors: [
                            Color.fromARGB(136, 63, 81, 181),
                            Color.fromARGB(75, 63, 81, 181),
                          ])),
                    )
                  : Container(
                      width: Get.width / 1.2,
                      height: Get.height / 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(Get.find<PlayerController>()
                                  .songs[index.value]
                                  .ima!))),
                    ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  AnimatedRotation(
                      duration: const Duration(seconds: 1),
                      turns: turns.value,
                      child: const Icon(
                        Icons.audiotrack_rounded,
                        color: Colors.indigo,
                      )),
                  Text(Get.find<PlayerController>()
                      .songs[index.value]
                      .musicName!),
                  Spacer(),
                  AnimatedOpacity(
                      curve: Curves.bounceIn,
                      duration: const Duration(seconds: 1),
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
                              ? const Icon(Icons.favorite_sharp,
                                  color: Colors.red)
                              : const Icon(Icons.favorite_outline_outlined)))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
                child: ProgressBar(
                  
                  timeLabelTextStyle: const TextStyle(color: Colors.white),
                  bufferedBarColor: const Color.fromARGB(38, 83, 109, 254),
                  progressBarColor: const Color.fromARGB(70, 132, 141, 194),
                  baseBarColor: const Color.fromARGB(54, 62, 72, 138),
                  thumbColor: const Color.fromARGB(158, 63, 81, 181),
                  progress: controller.progress.value,
                  buffered: controller.buffer.value,
                  total: controller.player.duration ??
                      const Duration(seconds: 0),
                  onSeek: (position) async {
                    controller.player.seek(position);
                    if (controller.player.playing) {
                      controller.playerAction();
                    } else if (position <= const Duration(seconds: 0)) {
                      await controller.player.seekToNext();
                   
                      controller.checkTimer();
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
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(136, 63, 81, 181),
                          Color.fromARGB(75, 63, 81, 181),
                        ])),
                    child: IconButton(
                        onPressed: () async {
                          await Get.find<PlayerController>()
                              .player
                              .seekToPrevious();
                          index.value == 0
                              ? null
                              : index.value = index.value - 1;
                          controller.checkTimer();
                        },
                        icon: const Icon(
                          Icons.skip_previous,
                          color: Colors.white,
                        )),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(136, 63, 81, 181),
                          Color.fromARGB(75, 63, 81, 181),
                        ])),
                    child: IconButton(
                        onPressed: () {
                          controller.player.playing
                              ? controller.timer!.cancel()
                              : controller.playerAction();

                          if (controller.player.playing) {
                            controller.player.pause();
                            controller.isPlaying.value =
                                false;
                          } else {
                            controller.player.play();
                            controller.isPlaying.value = true;
                          }
                       
                        },
                        icon: controller.isPlaying.value
                            ? Icon(Icons.pause, color: Colors.white)
                            : Icon(Icons.play_arrow, color: Colors.white)),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(136, 63, 81, 181),
                          Color.fromARGB(75, 63, 81, 181),
                        ])),
                    child: IconButton(
                        onPressed: () async {
                          await Get.find<PlayerController>()
                              .player
                              .seekToNext();

                          index.value + 1 ==
                                  controller.songs.length
                              ? null
                              : index.value = index.value + 1;
                          controller.checkTimer();
                        },
                        icon: const Icon(Icons.skip_next, color: Colors.white)),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(136, 63, 81, 181),
                          Color.fromARGB(75, 63, 81, 181),
                        ])),
                    child: IconButton(
                        onPressed: () {
                          controller.setLoopMode();
                        },
                        icon: Icon(
                          Icons.repeat_outlined,
                          color: controller.isLoopMode.value
                              ? Colors.blue
                              : Colors.white,
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
