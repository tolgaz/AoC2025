import 'dart:io';
import 'package:test/test.dart';
import '../lib/solution.dart';

void main() {
  late String exampleInput;

  setUpAll(() async {
    exampleInput = await File('example.txt').readAsString();
  });

  group('Day 5', () {
    test('Part 1 - Example', () {
      final result = solvePart1(exampleInput);
      expect(result, equals(3));
    });

    test('Part 2 - Example', () {
      final result = solvePart2(exampleInput);
      expect(result, equals(14));
    });
  });
}
