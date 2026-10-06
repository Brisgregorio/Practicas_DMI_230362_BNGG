import 'package:tok_tik/domain/datasources/video_post_datasource.dart';
import 'package:tok_tik/domain/entities/video_post.dart';
import 'package:tok_tik/shared/data/local_video_post.dart';


class LocalVideoDatasource implements LocalVideoDatasource{

  @override
  Future<List<VideoPost>> getFavoriteVideosByUser(String userID){
   throw UnimplementedError(); 
  }



@overrride
   Future<List<VideoPost>> getFavoriteVideosByUser(int page) async{
    await Future .delayed( cons Duration(secons: 2));
     
     final  List<VideoPost> newVideos = videoPosts.map(
      (video) => LocalVideoModel.fromJson(video).toVideoPostEntity()
     ).toList();

      return newVideos;
   }

}


