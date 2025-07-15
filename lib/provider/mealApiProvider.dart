
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/model/meal_moudel.dart';
import 'package:recipe_app/servise/apiService.dart';
import 'package:http/http.dart' as http;

class MealapiNotifire extends StateNotifier<List<MealMoudel>> {
  MealapiNotifire(this.api) : super([]);
  final Apiservice api;

  Future<void> featchdata() async {
    final meals = await api.featchData();
    state = meals;
  }
}

final _httpClientProvider = Provider.autoDispose((ref) {
  final client = http.Client();
  ref.onDispose(() {
    client.close();
  });
  return client;
});
final _apiServiceProvider = Provider<Apiservice>((ref) {
  final client = ref.watch(_httpClientProvider);
  return Apiservice(client: client);
});

final mealApiProvider =
    StateNotifierProvider<MealapiNotifire, List<MealMoudel>>((ref) {
      final api = ref.watch(_apiServiceProvider);
      return MealapiNotifire(api);
    });
