import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../data/models/post/post_file_model.dart';

class PostEntity extends Equatable {
  final int id;
  final String? description;
  final int type;
  @JsonKey(name: 'profile_id')
  final int profileId;
  @JsonKey(name: 'profile_image_url')
  final String? profileImageUrl;
  final String name;
  final List<PostFileModel>? files;
  @JsonKey(defaultValue: 0, name: 'likes_count')
  final int likesCount;
  @JsonKey(defaultValue: 0, name: 'comments_count')
  final int commentsCount;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'date_time')
  final String dateTime;
  @JsonKey(defaultValue: false, name: 'is_liked')
  final bool isLiked;
  @JsonKey(name: 'link_meta')
  final String? linkMeta;
  @JsonKey(name: 'aspect_ratio')
  final double? aspectRatio;
  @JsonKey(name: 'is_edited', defaultValue: false)
  final bool isEdited;
  @JsonKey(name: 'view_count', defaultValue: 0)
  final int viewCount;
  @JsonKey(name: 'user_work_area')
  final String? userWorkArea;
  @JsonKey(name: 'user_city')
  final String? userCity;

  const PostEntity({
    required this.id,
    this.description,
    required this.type,
    required this.profileId,
    this.profileImageUrl,
    required this.name,
    this.files,
    required this.likesCount,
    required this.commentsCount,
    this.updatedAt,
    required this.dateTime,
    required this.isLiked,
    this.linkMeta,
    this.aspectRatio,
    required this.isEdited,
    required this.viewCount,
    this.userWorkArea,
    this.userCity,
  });

  @override
  List<Object?> get props => [id, description, type, profileId, profileImageUrl, name, files, likesCount, commentsCount, updatedAt, dateTime, isLiked, linkMeta, aspectRatio, isEdited, viewCount, userWorkArea, userCity];
}

class PostFileEntity extends Equatable {
  final int id;
  final String url;
  @JsonKey(name: 'thumbnail_url')
  final String? thumbnailUrl;
  final String type;
  final String? height;
  final String? width;
  @JsonKey(name: 'local_file')
  final String? localFile;

  const PostFileEntity({
    required this.id,
    required this.url,
    this.thumbnailUrl,
    required this.type,
    this.height,
    this.width,
    this.localFile,
  });

  @override
  List<Object?> get props => [id, url, thumbnailUrl, type, height, width, localFile];
}
