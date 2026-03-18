import 'package:flutter_experiments/features/search/data/ebay_service.dart';

class SearchDataSource {
  final EbuyService _service=EbuyService();
  Future <List<dynamic>?> searchItems(String query)async{
    return await _service.searchItems(query);
  }
  Future <Map<String,dynamic>?> itemDetails(String itemId)async{
    return await  _service.itemDiscription(itemId);
  }
}