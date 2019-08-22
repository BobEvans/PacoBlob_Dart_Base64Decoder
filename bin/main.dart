import 'package:Base64Decoder/base64decoder.dart' as Base64Decoder;
import 'dart:io';
import 'dart:convert';
import 'package:image/image.dart';
import 'package:args/args.dart';
import 'package:Base64Decoder/event.dart';
import 'package:Base64Decoder/runner.dart';
import 'package:path/path.dart';

main(List<String> arguments) {
  var parser = createArgParser();
  var result = parser.parse(arguments);
  var inputFileArg = result['inputFile'];
  var outputDirArg = result['outputDirectory'];
  if (inputFileArg == null || outputDirArg == null) {
    print(parser.usage);
    return;
  }
  var inputFile = File(inputFileArg);
  var outputDir = Directory(outputDirArg);

  if (!inputFile.existsSync()) {
    print("input file does not exist");
    return;
  }

  if (!outputDir.existsSync()) {
    print("output directory does not exist");
    return;
  }

  realRun(inputFile, outputDir);

//  runStringDecoderTest();
//
//  runImgLoadEncodeAndDecodeTest();
  print("done");
}

ArgParser createArgParser() {
  var parser = ArgParser();

  parser.addOption("inputFile",
      abbr: 'i', help: 'The filepath to the json data');
  parser.addOption("outputDirectory",
      abbr: 'o', help: 'The directory to write all binary encoded data');
  return parser;
}

void runImgLoadEncodeAndDecodeTest() {
  print("Reading img and creating base");
  var inputFilepath = "bin/tiny-image.png";
  var stringOfImgBytes = encode(inputFilepath);
  print("ENCODED bits:\n ${stringOfImgBytes}\n");

  print("creating img from base64 encoded string");
  Image image = decodeImageFromBase64String(stringOfImgBytes);
  var outputFilepath = "out.png";
  print("writing img file to disk");
  writePng(outputFilepath, image);
}

void runStringDecoderTest() {
  var stringOfBytes = "SW5kZXg6IC9Vc2Vycy9ib2JldmFucy9JZGVhUHJvamVjdHMvbXlf"
      "dGVzdF9mbHV0dGVyL2xpYi9tYWluLmRhcnQKPT09PT09PT09PT09PT09PT09"
      "PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09"
      "PT09PQotLS0gL1VzZXJzL2JvYmV2YW5zL0lkZWFQcm9qZWN0cy9teV90ZXN0"
      "X2ZsdXR0ZXIvbGliL21haW4uZGFydAkoZGF0ZSAxNTY0MDkzOTQwMDAwKQor"
      "KysgL1VzZXJzL2JvYmV2YW5zL0lkZWFQcm9qZWN0cy9teV90ZXN0X2ZsdXR0"
      "ZXIvbGliL21haW4uZGFydAkoZGF0ZSAxNTY0MDkzOTQwMDAwKQpAQCAtMTMs"
      "NyArMTMsNyBAQAogICBAb3ZlcnJpZGUKICAgV2lkZ2V0IGJ1aWxkKEJ1aWxk"
      "Q29udGV4dCBjb250ZXh0KSB7CiAgICAgcmV0dXJuIG5ldyBNYXRlcmlhbEFw"
      "cCgKLSAgICAgIHRpdGxlOiAnRmx1dHRlciBEZW1vIDgnLAorICAgICAgdGl0"
      "bGU6ICdGbHV0dGVyIERlbW8gMTAnLAogICAgICAgdGhlbWU6IG5ldyBUaGVt"
      "ZURhdGEoCiAgICAgICAgIC8vIFRoaXMgaXMgdGhlIHRoZW1lIG9mIHlvdXIg"
      "YXBwbGljYXRpb24uCiAgICAgICAgIC8vCg==";
  var decodedBytes = Base64Decoder.decodeBytes(stringOfBytes);
  var stringFromBytes = String.fromCharCodes(decodedBytes);
  print('DECODED:\n ${stringFromBytes}\n');
}

void writePng(String outputFilepath, Image image) {
  File(outputFilepath)..writeAsBytesSync(encodePng(image));
}

Image decodeImageFromBase64String(String imgBytesString) {
  var imgBytes = Base64Decoder.decodeBytes(imgBytesString);
  //encode();
  var image = decodeImage(imgBytes);
  return image;
}

// used to generate base64 string from img on disk
String encode(inputFilepath) {
  List<int> bytes = readBytesFromFile(inputFilepath);
  return Base64Decoder.encodeBytes(bytes);
}

List<int> readBytesFromFile(inputFilepath) {
  var f = File(inputFilepath);
  return f.readAsBytesSync();
}
