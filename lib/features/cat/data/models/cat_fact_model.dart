import '../../domain/entities/cat_fact_entity.dart';

/// A model class of [CatFactEntity]
class CatFactModel extends CatFactEntity {
  /// Creates an instance of [CatFactModel]
  const CatFactModel({
    required super.id,
    required super.user,
    required super.text,
    required super.source,
    required super.updatedAt,
    required super.type,
    required super.createdAt,
    required super.deleted,
    required super.used,
  });

  /// Converts a json object into a [CatFactModel]
  factory CatFactModel.fromJSON(Map<String, dynamic> json) => CatFactModel(
        id: json['_id'] as String,
        user: json['user'] as String,
        text: json['text'] as String,
        source: json['source'] as String,
        updatedAt: DateTime.parse(json['updatedAt'] as String),
        type: json['type'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
        deleted: json['deleted'] as bool,
        used: json['used'] as bool,
      );

  /// Converts a [CatFactModel] into a json object
  Map<String, dynamic> toJSON() => {
        '_id': id,
        'user': user,
        'text': text,
        'source': source,
        'updatedAt': updatedAt.toIso8601String(),
        'type': type,
        'createdAt': createdAt.toIso8601String(),
        'deleted': deleted,
        'used': used,
      };
}
