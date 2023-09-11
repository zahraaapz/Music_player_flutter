import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:music_player/controller.dart';
import 'package:music_player/track_play.dart';

class Playlist extends StatelessWidget {
   Playlist({super.key});
var playerController=Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
 

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent
          ),
        backgroundColor: Colors.transparent,
        title: Text(
          'My MUSIC',
          style: TextStyle(color: Colors.indigo),
        ),
      ),
      body:  
      Obx(()=>
        playerController.playerList.isEmpty?
      Center(child: CircularProgressIndicator(color:Colors.indigo)):
      
    
    
      ListView.builder(
        itemCount:playerController.playerList.length,
        itemBuilder: (context, index) => 
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              InkWell(
                onTap: () => Get.to(TrackPlay(),arguments: index) ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.amberAccent),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                  
                         SizedBox(width: 200,
                           child: Text(playerController.playerList[index].uri.pathSegments.last.toString(),
                           maxLines: 2,),
                         ),
              
                    Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
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
              Divider(
                height: 2,
                color: const Color.fromARGB(73, 158, 158, 158),
                thickness: 1,
                endIndent: 40,
                indent: 40,
              )
            ],
          ),
        )
      
    )));
  }
}
