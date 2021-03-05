import 'dart:io';

import 'package:args/args.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

import 'calculator_service.dart';

void main(List<String> args) async {
  var port = int.tryParse(Platform.environment['PORT'] ?? '8080');

  var server = await io.serve(CalculatorService().router, InternetAddress.anyIPv4, port);
  print('Serving at http://${server.address.host}:${server.port}');
}
