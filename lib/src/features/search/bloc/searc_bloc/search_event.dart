abstract class SearchEvent {}

class OnSearchSumbmit extends SearchEvent {
  final String query;
  OnSearchSumbmit(this.query);
}

class OnCategorySubmit extends SearchEvent {
  final String? id;
  final String?categoryname;
  OnCategorySubmit(this.id,this.categoryname);
}

class OnClear extends SearchEvent {}

class OnloadDailyDeals extends SearchEvent{}
