import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import '../Model/song_model.dart';

class PlayerController extends GetxController {
  late var playerList;
  late AudioPlayer player = AudioPlayer();
  RxBool isPlaying = false.obs;
  RxBool isLoopMode = false.obs;
  Rx<Duration> progress = Duration(seconds: 0).obs;
  Rx<Duration> buffer = Duration(seconds: 0).obs;

  @override
  onInit() async {
    super.onInit();
    playerList =
        ConcatenatingAudioSource(children:[], useLazyPreparation: true);
    await getListPlayer();
    await player.setAudioSource(playerList,
        initialIndex: 0, initialPosition: Duration.zero);
  }

  getListPlayer() async {
//External Storage
    // await Permission.manageExternalStorage.request();
    // await Permission.storage.request();
    // Directory directory = Directory('/storage/emulated/0/MUSIC');
    // RxList<FileSystemEntity> files = RxList();
    // files.value = directory.listSync(recursive: true, followLinks: false);

    // for (FileSystemEntity e in files) {
    //   String path = e.path;

    //   if (path.endsWith('.mp3')) {
    //     playerList.add(e);
    //   }
    //   log(playerList.toString());
    // }

    // log(playerList.toString());


    for (var element in songs) {
  
      playerList.add(AudioSource.uri(
          Uri.parse('asset:///${element.path}')));
      log(playerList.length.toString());
    }
  }

  Timer? timer;

  checkTimer() {
    if (player.playing) {
      playerAction();
    
    } else {
      timer!.cancel();
      buffer.value = Duration(seconds: 0);
      progress.value = Duration(seconds: 0);
  
    }
  }

  playerAction() {
    const tick = Duration(seconds: 1);
    int totalDuration = player.duration!.inSeconds - player.position.inSeconds;

    if (timer != null) {
      if (timer!.isActive) {
        timer!.cancel();
        timer = null;
      }
    }

    timer = Timer.periodic(tick, (timer) {
      totalDuration--;
      progress.value = player.position;
      buffer.value = player.bufferedPosition;
    });

    if (totalDuration <= 0) {
      timer!.cancel();
      buffer.value = Duration(seconds: 0);
    }
  }

  setLoopMode() {
    if (isLoopMode.value) {
      isLoopMode.value = false;
      player.setLoopMode(LoopMode.off);
    } else {
      isLoopMode.value = true;
      player.setLoopMode(LoopMode.all);
    }
  }
}
