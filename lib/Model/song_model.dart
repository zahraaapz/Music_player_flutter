import 'package:get/get_rx/src/rx_types/rx_types.dart';

class SongModel{

String ?ima;
String ?path;
String ?musicName;


SongModel({

required this.ima,
required this.path,
required this.musicName,

});

}
RxList<SongModel> songs =
[
SongModel(
ima: "assets/image/1.jpg",
path: "assets/music/Mahasti-Ashegh-128.mp3",
musicName: "Ashegh"
),
SongModel(
ima: "assets/image/2.jpg",
path: "assets/music/Mahasti-AyBahareh.mp3",
musicName: "Ay Bahareh"
),
SongModel(
ima: "assets/image/3.jpg",
path: "assets/music/Mahasti-DelamTangeh.mp3",
musicName: "Delam Tangeh"
),
SongModel(
ima: "assets/image/4.jpg",
path: "assets/music/Mahasti-Moj.mp3",
musicName: "Moj"
),
SongModel(
ima: "assets/image/5.jpg",
path: "assets/music/Mahasti-ShabeEyd.mp3",
musicName: "Shabe Eyd"
)
].obs;