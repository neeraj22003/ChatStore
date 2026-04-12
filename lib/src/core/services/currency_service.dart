import 'package:currency_sdk/currency_sdk.dart';

class CurrencyService {
  final _client = CurrencyClient();

  CurrencyService() {
    init();
  }
  Future<void> init() async {
    await _client.initialize();
  }

  Future<double> getrate() async {
    return await _client.convert(amount: 1, from: 'USD', to: 'INR');
  }
}
