import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';

class EbuyService {
  Future<String?> getproductiontoken() async {
    final String clientId = dotenv.env['ebuy_client_id']!;
    final String certid = dotenv.env['Cert_id']!;

    final String authEncode = base64Encode(utf8.encode('$clientId:$certid'));

    final String authUrl = 'https://api.ebay.com/identity/v1/oauth2/token';
    final response = await http.post(
      Uri.parse(authUrl),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Basic $authEncode',
      },
      body: {
        'grant_type': 'client_credentials',
        'scope': 'https://api.ebay.com/oauth/api_scope',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['access_token'];
    }
    return null;
  }

  Future<List<dynamic>?> ebayservice(String? query, String? categoryid) async {
    try {
      final check = await http.get(Uri.parse('https://www.google.com'));
      if (check.statusCode != 200) {
        throw Exception('no internet');
      }

      final token = await getproductiontoken();
      final url = query != null
          ? 'https://api.ebay.com/buy/browse/v1/item_summary/search?q=$query'
          : categoryid != null
          ? 'https://api.ebay.com/buy/browse/v1/item_summary/search?category_ids=$categoryid'
          : 'https://api.ebay.com/buy/browse/v1/item_summary/search'
                '?q=best+sellers'
                '&filter=priceDiscount:[10..90]'
                '&limit=20';
      if (token == null) return null;
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'X-EBAY-C-MARKETPLACE-ID': 'EBAY-US',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return data['itemSummaries'] ?? [];
      }

      return null;
    } catch (e) {
      throw Exception('No internet');
    }
  }

  Future<Map<String, dynamic>?> itemDiscription(String itemid) async {
    final token = await getproductiontoken();
    final browsurl = 'https://api.ebay.com/buy/browse/v1/item/';
    final response = await http.get(
      Uri.parse('$browsurl$itemid'),
      headers: {
        'Authorization': "Bearer $token",
        "X-EBAY-C-MARKETPLACE-ID": "EBAY-US",
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      
      return data;
    } else {
      return null;
    }
  }
}
