import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_block_demo/domain/entities/post_entity.dart';

part 'post_file_model.g.dart';

@JsonSerializable()
class PostFileModel extends PostFileEntity {
  const PostFileModel({
    required super.id,
    required super.url,
    super.thumbnailUrl,
    required super.type,
    super.height,
    super.width,
    super.localFile,
  });

  factory PostFileModel.fromJson(Map<String, dynamic> json) => _$PostFileModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostFileModelToJson(this);
}
