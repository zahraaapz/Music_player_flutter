import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:music_player/Controller/controller.dart';
import 'package:music_player/View/track_play.dart';

class Playlist extends StatelessWidget{
  Playlist({super.key});
  final PlayerController controller=Get.put(PlayerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.transparent),
          backgroundColor: Colors.transparent,
          title: const Text(
            'My MUSIC',
            style: TextStyle(color: Colors.indigo),
          ),
        ),
        body: Obx(() => 
            ListView.builder(
                itemCount: controller.songs.length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () { 

                        controller.player.playing
                              ? controller.timer!.cancel()
                              : null;
                    
                    print(controller.timer.toString());
                 

                            Get.to(const TrackPlay(), arguments: index);
                              },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                controller.songs[index].ima != null
                                    ? Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                                image: AssetImage(controller
                                                    .songs[index].ima!))),
                                      )
                                    : Container(
                                        width: 60,
                                        height: 60,
                                        decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                          colors: [
                                            Color.fromARGB(136, 63, 81, 181),
                                            Color.fromARGB(
                                                75, 63, 81, 181)
                                          ],
                                        )),
                                      ),
                                SizedBox(
                                  width: 30,
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    controller.songs[index].musicName!,
                                    maxLines: 2,
                                  ),
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      color: Color.fromARGB(181, 158, 158, 158),
                                      Icons.more_vert_outlined,
                                      size: 30,
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            height: 2,
                            color: Color.fromARGB(73, 158, 158, 158),
                            thickness: 1,
                            endIndent: 40,
                            indent: 40,
                          )
                        ],
                      ),
                    ))));
  }
}
