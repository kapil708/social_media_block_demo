import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/post_entity.dart';
import 'post_file_model.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel extends PostEntity {
  const PostModel({
    required super.id,
    super.description,
    required super.type,
    required super.profileId,
    required super.profileImageUrl,
    required super.name,
    super.files,
    required super.likesCount,
    required super.commentsCount,
    super.updatedAt,
    required super.dateTime,
    required super.isLiked,
    super.linkMeta,
    super.aspectRatio,
    required super.isEdited,
    required super.viewCount,
    super.userWorkArea,
    super.userCity,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
