import 'dart:async';

import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

part 'calculator_service.g.dart';

class CalculatorService {
  Router get router => _$CalculatorServiceRouter(this);

  @Route.get('/calculator/prefix')
  Future<Response> _getPrefixCalculate(Request request) async {
    var input = request.url.queryParameters['equation'];
    var result = prefixCalculate(input);
    return Response.ok(result);
  }

  @Route.get('/calculator/infix')
  Future<Response> _infixCalculate(Request request) async {
    var input = request.url.queryParameters['equation'];
    var result = infixCalculate(input);
    return Response.ok(result);
  }

  void examplesFromMarkdown() {
    // Task 1
    print(prefixCalculate('3'));
    print(prefixCalculate('+ 1 2'));
    print(prefixCalculate('+ 1 * 2 3'));
    print(prefixCalculate('+ * 1 2 3'));
    print(prefixCalculate('- / 10 + 1 1 * 1 2'));
    print(prefixCalculate('- 0 3'));
    print(prefixCalculate('/ 3 2'));

    // Task 2
    print(infixCalculate('( 1 + 2 )'));
    print(infixCalculate('( 1 + ( 2 * 3 ) )'));
    print(infixCalculate('( ( 1 * 2 ) + 3 )'));
    print(infixCalculate('( ( ( 1 + 1 ) / 10 ) - ( 1 * 2 ) )'));
  }

// I assume I don't need to support inputs without paranthesis
  String infixCalculate(String input) {
    var tokens = input.split(' ');
    while (tokens.length != 1) {
      var start = 0;
      var end = 0;
      for (var i = 0; i < tokens.length; i++) {
        if (tokens[i] == '(') {
          start = i;
        } else if (tokens[i] == ')') {
          end = i;
          var first = double.tryParse(tokens[start + 1]);
          var second = double.tryParse(tokens[start + 3]);
          var operator = tokens[start + 2];
          var result = calculate(operator, first, second);
          tokens = tokens.getRange(0, start).toList() +
              [removeTrailingZeros(result)] +
              tokens.getRange(end + 1, tokens.length).toList();
        }
      }
    }
    return tokens.join(' ');
  }

  String prefixCalculate(String input) {
    var tokens = input.trim().split(' ');
    if (tokens.isEmpty) {
      throw FormatException('No numbers provided');
    }
    while (tokens.length != 1) {
      // try to find 2 digits next to each other
      for (var i = 0; i < tokens.length - 2; i++) {
        var first = double.tryParse(tokens[i + 1]);
        var second = double.tryParse(tokens[i + 2]);
        if (first != null && second != null) {
          var operator = tokens[i];
          var result = calculate(operator, first, second);
          tokens =
              tokens.getRange(0, i).toList() + [removeTrailingZeros(result)] +
                  tokens.getRange(i + 3, tokens.length).toList();
        }
      }
    }
    return tokens[0];
  }

// A Dart hack from https://stackoverflow.com/questions/55152175/how-to-remove-trailing-zeros-using-dart
  String removeTrailingZeros(double result) {
    return result.toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
  }

  double calculate(String operator, double first, double second) {
    switch (operator) {
      case '+':
        return first + second;
      case '-':
        return first - second;
      case '*':
        return first * second;
      case '/':
        return first / second;
      default:
        throw FormatException(
            '$operator was given, only +, -, * and / operators are supported.');
    }
  }
}
