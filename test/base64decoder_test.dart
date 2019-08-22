import 'package:Base64Decoder/base64decoder.dart';
import 'package:Base64Decoder/runner.dart';
import 'package:test/test.dart';
import 'dart:io';

void main() {
  test('run', () {
    var inputFile = File("/Users/bobevans/IdeaProjects/Base64Decoder/test/testEvents.json");
    var outputDir = Directory("/Users/bobevans/IdeaProjects/Base64Decoder/output");
    realRun(inputFile, outputDir);
  });
}
