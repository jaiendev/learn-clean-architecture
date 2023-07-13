// Package imports:
import 'package:dio/dio.dart';
import 'package:project_learn_clean_architecture/core/app/constants/constants.dart';
import 'package:project_learn_clean_architecture/core/util/logger.dart';

class StopWatch {
  static Future<Response> stopWatchApi(
      Future<Response> Function() next, String method, String endpoint) async {
    DateTime startTime = DateTime.now();
    var result = await next();
    DateTime endTime = DateTime.now();
    int duration = endTime.difference(startTime).inMilliseconds;
    if (duration >= delayASecond) {
      UtilLogger.log(
          'WARNING RESPONSE TIME', '**********************************');
      UtilLogger.log(
          'WARNING RESPONSE TIME', '$method: $endpoint - ${duration}ms\n');
      UtilLogger.log(
          'WARNING RESPONSE TIME', '**********************************');
    }
    return result;
  }
}
