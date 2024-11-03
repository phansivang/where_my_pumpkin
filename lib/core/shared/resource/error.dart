import 'package:equatable/equatable.dart';

/// A model for error message
class ErrorModel extends Equatable {
  /// This is the endpoint path
  final String path;

  /// This is the error message
  final String message;

  /// Creates an instance of [ErrorModel]
  const ErrorModel(
    this.path,
    this.message,
  );

  @override
  List<Object?> get props => [path, message];

  /// A factory method for converting [json] to [ErrorModel]
  factory ErrorModel.fromJSON(Map<String, dynamic> json) {
    return ErrorModel(
      json['path'],
      json['message'],
    );
  }
}
