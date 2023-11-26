import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_v2_tutorial/model/activity.dart';

part 'activity_with_type_provider.g.dart';

@riverpod
Future<Activity> activityWithType(
  ActivityWithTypeRef ref,
  String activityType,
) async {
  final response = await http.get(
    Uri(
      scheme: 'https',
      host: 'boredapi.com',
      path: '/api/activity',
      queryParameters: {'type': activityType},
    ),
  );

  final json = jsonDecode(response.body) as Map<String, dynamic>;
  return Activity.fromJson(json);
}
