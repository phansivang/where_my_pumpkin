import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/resource/usecase.dart';
import '../../domain/entities/cat_fact_entity.dart';
import '../../domain/usecases/get_cat_facts_use_case.dart';

part 'cat_state.dart';

/// A cubit class for cat facts business logic
class CatCubit extends Cubit<CatState> {
  /// A use case class for getting cat facts
  final GetCatFactsUseCase getCatFactsUseCase;

  /// Creates an instance of [CatCubit]
  CatCubit({
    required this.getCatFactsUseCase,
  }) : super(CatInitial());

  /// Fetches cat facts
  Future<void> fetchCatFacts() async {
    emit(CatLoading());
    final result = await getCatFactsUseCase(NoParams());
    result.fold(
      (failure) => emit(CatError(failure.message)),
      (facts) => emit(CatLoaded(facts)),
    );
  }
}
