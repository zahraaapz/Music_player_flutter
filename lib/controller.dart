


import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/track_play.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController{
 
RxList <FileSystemEntity> playerList=RxList();
RxString currectFile=''.obs;
final player=AudioPlayer();
RxBool isPlaying=false.obs;
Rx<Duration> position=Duration(seconds: 0).obs;
Rx<Duration> duration=Duration(seconds: 0).obs;


 @override
onInit() async{
super.onInit();
 getListPlayer();
  }  

  getListPlayer() async{

   await Permission.manageExternalStorage.request();
   await Permission.storage.request();
   Directory directory =Directory('/storage/emulated/0/MUSIC');
   String mp3path=directory.toString();
   RxList<FileSystemEntity> file=RxList();
  file.value =directory.listSync(
    recursive: true,followLinks: false
   );
   
for (FileSystemEntity e in file) {
  String path=e.path;

  if (path.endsWith('.mp3')) {
    playerList.add(e);
  }
  log(playerList.toString()); }

log(playerList.toString());
 }

playerAction(FileSystemEntity file)async{
  await player.setUrl(file.path);


if ( player.duration != null) {
  duration.value=player.duration!;
  
 
}

if(currectFile.value == file){
if (player.playing) {
  
  
    player.pause();
  isPlaying.value=false;
}
else{

   player.play();
   isPlaying.value=true;

}}
else{

  player.play();
   isPlaying.value=true;

}

currectFile.value=File(file.path).uri.pathSegments.last;




}






String format(Rx<Duration> v){
  String twoDigit(int time){
    return time.toString().padLeft(2,'0');
  }
final hour=twoDigit(v.value.inHours);
final min=twoDigit(v.value.inMinutes.remainder(60));
final sec=twoDigit(v.value.inSeconds.remainder(60));

return [if (v.value.inHours > 0) hour , min, sec].join(':');

}
}