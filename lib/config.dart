import 'dart:io';

const String LOCAL_CHANNEL = "local";
const String ENV_ENDPOINT = "BENCHMARK_ENDPOINT_URL";
const String ENDPOINT_OPTION = "endpoint";
const String ENDPOINT_OPTION_ABBR = "e";
const String ENDPOINT_OPTION_HELP = "HTTP endpoint to which to log information";

class Config {
  final String url;

  Config([this.url]);

  String get channel {
    var channel = Platform.environment["JOB"];
    if(channel != null && channel.isNotEmpty) {
      return channel;
    } else {
      return LOCAL_CHANNEL;
    }
  }
}