import 'package:equatable/equatable.dart';

/// An entity class for cat fact
class CatFactEntity extends Equatable {
  /// This is the id of the fact
  final String id;

  /// This is the user who created the fact
  final String user;

  /// This is the fact text
  final String text;

  /// This is the source of the fact
  final String source;

  /// This is the time when the fact was updated
  final DateTime updatedAt;

  /// This is the type of the fact
  final String type;

  /// This is the time when the fact was created
  final DateTime createdAt;

  /// This is the flag for deleted fact
  final bool deleted;

  /// This is the flag for used fact
  final bool used;

  /// Creates an instance of [CatFactEntity]
  const CatFactEntity({
    required this.id,
    required this.user,
    required this.text,
    required this.source,
    required this.updatedAt,
    required this.type,
    required this.createdAt,
    required this.deleted,
    required this.used,
  });

  @override
  List<Object?> get props => [
        id,
        user,
        text,
        source,
        updatedAt,
        type,
        createdAt,
        deleted,
        used,
      ];
}
