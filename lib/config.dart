import 'dart:io';

const String ENV_ENDPOINT = "BENCHMARK_ENDPOINT_URL";
const String ENDPOINT_OPTION = "endpoint";
const String ENDPOINT_OPTION_ABBR = "e";
const String ENDPOINT_OPTION_HELP = "HTTP endpoint to which to log information";

class Config {
  final String url;

  Config([this.url]);
}