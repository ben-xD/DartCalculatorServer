// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculator_service.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$CalculatorServiceRouter(CalculatorService service) {
  final router = Router();
  router.add('GET', r'/calculator/prefix', service._getPrefixCalculate);
  router.add('GET', r'/calculator/infix', service._infixCalculate);
  return router;
}
