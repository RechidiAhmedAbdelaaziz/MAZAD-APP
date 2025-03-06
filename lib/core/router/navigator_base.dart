part of 'router.dart';

abstract class AppNavigatorBase {
  final String name;
  final Map<String, String> pathParams;
  final Map<String, String> queryParams;

  AppNavigatorBase({
    required this.name,
    this.pathParams = const {},
    this.queryParams = const {},
  });
}
