import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'lib/config.dart';

main(List<String> args) {
  var parser = new ArgParser()..addOption(ENDPOINT_OPTION, abbr: ENDPOINT_OPTION_ABBR, help: ENDPOINT_OPTION_HELP);
  var result = parser.parse(args);

  var config = new Config(getEndpointUrl(result, parser.getUsage()));
  stdin.transform(UTF8.decoder).listen((data) { post(data, config); });
}

String getEndpointUrl(ArgResults result, String usageMessage) {
  var url = result[ENDPOINT_OPTION];
  if( url == null || url.isEmpty ) {
    if (Platform.environment[ENV_ENDPOINT] == null || Platform.environment[ENV_ENDPOINT].isEmpty) {
      print("HTTP endpoint URL must be provided either using flag or ${ENV_ENDPOINT} environment variable");
      print(usageMessage);
      exit(1);
    }
    url = Platform.environment[ENV_ENDPOINT];
  };
  return url;
}

post(String data, Config config) {
  HttpClient client = new HttpClient();
  var valueMap = JSON.decode(data);
  var module = valueMap["module"];
  var name = valueMap["name"];
  var score = valueMap["value"];
  var handleRequest = (HttpClientRequest request) {
    request.write(score);
    return request.close();
  };
  var handleResponse = (HttpClientResponse resp ) {
    resp.transform(UTF8.decoder)
    .listen((body) => print("${resp.statusCode} - ${body}") )
    .onDone(() => client.close());
  };
  client.openUrl("POST", Uri.parse("${config.url}/${module}/${name}.json"))
      .then(handleRequest).then(handleResponse);
}