class SongModel{

String ?ima;
String ?path;
String ?musicName;


SongModel({

required this.ima,
required this.path,
required this.musicName,

});



SongModel.fromJson(Map<String,dynamic>element){


ima=element['ima'];
path=element['path'];
musicName=element['musicName'];







}
}