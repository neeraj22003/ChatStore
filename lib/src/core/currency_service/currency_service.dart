import 'package:currency_sdk/currency_sdk.dart';

class CurrencyService {
  final _client = CurrencyClient();

  double? _cachedRate;
  Future<void> init() async {
    await _client.initialize();
  }

  Future<double> getrate() async {
    if (_cachedRate != null) {
      return _cachedRate!;
    } else {
      return await _client.convert(amount: 1, from: 'USD', to: 'INR');
    }
  }
}
