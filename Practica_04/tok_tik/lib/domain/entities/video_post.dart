class VideoPost {
///Agregar el campo descripcion, si es extensa se agrega funcionalidad ver mas
  final String caption;
  final String videoUrl;
  final int likes;
  final int views;
  
  VideoPost({
  required this.caption, 
  required this.videoUrl, 
  this.likes = 0, 
  this.views = 0
  });

}