part of 'cat_cubit.dart';

/// A sealed cubit state class of [CatCubit]
sealed class CatState extends Equatable {
  const CatState();

  @override
  List<Object> get props => [];
}

/// A final cubit state class for initial state of cat facts
final class CatInitial extends CatState {}

/// A final cubit state class for loading state of cat facts
final class CatLoading extends CatState {}

/// A final cubit state class for loaded state of cat facts
final class CatLoaded extends CatState {
  /// This is the cat fats
  final List<CatFactEntity> facts;

  /// Creates an instance of [CatLoaded]
  const CatLoaded(this.facts);

  @override
  List<Object> get props => [facts];
}

/// A final cubit state class for error state of cat facts
final class CatError extends CatState {
  /// This is the error message
  final String message;

  /// Creates an instance of [CatError]
  const CatError(this.message);

  @override
  List<Object> get props => [message];
}
