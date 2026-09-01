import 'package:bloc/bloc.dart';
import 'package:chat_shop/src/features/search/bloc/searc_bloc/search_event.dart';
import 'package:chat_shop/src/features/search/bloc/searc_bloc/search_state.dart';
import 'package:chat_shop/src/features/search/domain/search_usecases.dart/search_usecases.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUsecases searchUsecases;
  SearchBloc(this.searchUsecases) : super(SearchState.initial()) {
    on<OnloadDailyDeals>((event, emit) async {
      emit(state.copyWith(isloading: true));
      try {
        final results = await searchUsecases.feedItem();
        if (results.data!.isNotEmpty) {
          emit(
            state.copyWith(
              isloading: false,
              results: results.data,
              isdailydeals: true,
            ),
          );
        } else {
          emit(state.copyWith(error: 'Some Wente Wrong'));
        }
      } catch (e) {
        emit(state.copyWith(isloading: false, error: e.toString()));
      }
    });
    on<OnSearchSumbmit>((event, emit) async {
      if (event.query.isEmpty) return;
      try {
        emit(
          state.copyWith(
            isloading: true,
            categoryname: null,
            query: state.query,
            error: null,
          ),
        );
        final results = await searchUsecases.searchItem(event.query);
        if (results.data!.isNotEmpty) {
          emit(state.copyWith(results: results.data, isloading: false));
        } else {
          emit(state.copyWith(error: 'no item found', isloading: false));
        }
      } catch (e) {
        emit(state.copyWith(error: e.toString(), isloading: false));
      }
    });

    on<OnCategorySubmit>((event, emit) async {
      try {
        emit(state.copyWith(isloading: true, categoryid: state.categoryid));
        final results = await searchUsecases.getCategoryItem(event.id);
        if (results.data!.isNotEmpty) {
          emit(
            state.copyWith(
              results: results.data,
              isloading: false,
              categoryname: event.categoryname,
            ),
          );
        } else {
          emit(state.copyWith(error: 'no item found', isloading: false));
        }
      } catch (e) {
        emit(state.copyWith(error: e.toString(), isloading: false));
      }
    });
    on<OnClear>((event, emit) async {
      emit(SearchState.initial().copyWith(isloading: true));
      try {
        final results = await searchUsecases.feedItem();
        if (results.data!.isNotEmpty) {
          emit(
            state.copyWith(
              isloading: false,
              results: results.data,
              isdailydeals: true,
            ),
          );
        } else {
          emit(state.copyWith(error: 'Some Wente Wrong'));
        }
      } catch (e) {
        emit(state.copyWith(isloading: false, error: e.toString()));
      }
    });
  }
}
