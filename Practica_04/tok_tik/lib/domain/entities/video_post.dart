class VideoPost {
  final String id;
  final String caption;
  final String description;
  final String userName;
  final String videoUrl;
  final int likes;
  final int views;
  final bool isLiked;

  VideoPost({
    String? id,
    required this.caption,
    String? description,
    String? userName,
    required this.videoUrl,
    this.likes = 0,
    this.views = 0,
    this.isLiked = false,
  })  : id = id ?? videoUrl,
        description = description ?? caption,
        userName = userName ?? '@toktik_creator';

  VideoPost copyWith({
    String? id,
    String? caption,
    String? description,
    String? userName,
    String? videoUrl,
    int? likes,
    int? views,
    bool? isLiked,
  }) {
    return VideoPost(
      id: id ?? this.id,
      caption: caption ?? this.caption,
      description: description ?? this.description,
      userName: userName ?? this.userName,
      videoUrl: videoUrl ?? this.videoUrl,
      likes: likes ?? this.likes,
      views: views ?? this.views,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'caption': caption,
      'description': description,
      'userName': userName,
      'videoUrl': videoUrl,
      'likes': likes,
      'views': views,
      'isLiked': isLiked,
    };
  }

  factory VideoPost.fromJson(Map<String, dynamic> json) {
    return VideoPost(
      id: json['id'] as String?,
      caption: (json['caption'] ?? json['name'] ?? '') as String,
      description: (json['description'] ?? json['caption'] ?? json['name'] ?? '') as String,
      userName: (json['userName'] ?? '@toktik_creator') as String,
      videoUrl: (json['videoUrl'] ?? '') as String,
      likes: (json['likes'] ?? 0) as int,
      views: (json['views'] ?? 0) as int,
      isLiked: (json['isLiked'] ?? false) as bool,
    );
  }
}
