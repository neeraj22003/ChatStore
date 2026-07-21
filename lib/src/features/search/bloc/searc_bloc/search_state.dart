class SearchState {
  final String? query;
  final List<dynamic>? results;
  final bool isloading;
  final String? categoryid;
  final String? error;
  final String? categoryname;
  final bool isdailydeals;
  SearchState({
    this.query,
    this.results,
    this.isloading = false,
    this.categoryid,
    this.error,
    this.categoryname,
    this.isdailydeals=false
  });
  factory SearchState.initial() {
    return SearchState(
      query: null,
      results: [],
      isloading: false,
      categoryid: null,
      error: null,
      categoryname: null,
      isdailydeals: false
    );
  }

  SearchState copyWith({
    final String? query,
    final List<dynamic>? results,
    final bool? isloading,
    final String? categoryid,
    final String? error,
    final String? categoryname,
    final bool? isdailydeals
  }) {
    return SearchState(
      query: query ?? this.query,
      results: results ?? this.results,
      isloading: isloading ?? this.isloading,
      categoryid: categoryid ?? this.categoryid,
      error: error ?? this.error,
      categoryname: categoryname ?? this.categoryname,
      isdailydeals: isdailydeals??this.isdailydeals
    );
  }
}
