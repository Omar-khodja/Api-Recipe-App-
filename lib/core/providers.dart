import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/core/dio/dioCcientapi.dart';

final dioClientProvider = Provider<DioClientApi>((ref) {
  return DioClientApi();
});