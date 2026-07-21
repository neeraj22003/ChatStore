import 'package:chat_shop/src/features/search/domain/search_repo.dart';

import 'package:chat_shop/src/features/search/domain/search_usecases.dart/feed_item.dart';
import 'package:chat_shop/src/features/search/domain/search_usecases.dart/get_category_item.dart';

import 'package:chat_shop/src/features/search/domain/search_usecases.dart/search_item.dart';

class SearchUsecases {
  final FeedItem feedItem;
  final GetCategoryItem getCategoryItem;
  final SearchItem searchItem;

  SearchUsecases(SearchRepo repo)
    : feedItem = FeedItem(repo),
      getCategoryItem = GetCategoryItem(repo),
      searchItem = SearchItem(repo);
      
}
