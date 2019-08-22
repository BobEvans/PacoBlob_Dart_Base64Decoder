import 'package:Base64Decoder/base64decoder.dart' as Base64Decoder;
import 'dart:io';
import 'dart:convert';
import 'package:Base64Decoder/event.dart';
import 'package:path/path.dart';

void realRun(File inputJsonFile, Directory outputDirectory) {
  // load json file, parse (into json object or ideally Taqo/PAL/Paco (TaPacol?) Event object
  var jsonMap = jsonDecode(inputJsonFile.readAsStringSync());
  var eventsJson = jsonMap["events"];
  var events = [];
  for (var eventJson in eventsJson) {
    var event = Event.fromJson(eventJson);
    events.add(event);
  }

  for (var event in events) {
    var responses = event.responses;
    for (var response in responses) {
      if (response.name == "diff") {
        var textdiffBase64 = response.answer;
        var decodedBytes = Base64Decoder.decodeBytes(textdiffBase64);
        var stringFromBytes = String.fromCharCodes(decodedBytes);
        var patchFile = File(join(
            outputDirectory.path, getDiffFileNameFromResponses(responses)));
        patchFile.writeAsStringSync(stringFromBytes);
        print("wrote patchFile ${patchFile.path}");
      } else if (response.name == "base_snapshot_contents") {
        var zipBase64 = response.answer;
        var decodedBytes = Base64Decoder.decodeBytes(zipBase64);
        var zipFile = File(
            join(outputDirectory.path, getZipFileNameFromResponses(responses)));
        zipFile.writeAsBytesSync(decodedBytes);
        print("wrote zip ${zipFile.path}");
      }
    }
  }
  // find each response named "diff" or "zipfile"
  // Base64Decode the answer to get one of a) string ("textdiff") or b) zipfile ("zipfile") or c) image ("input type=Image")
  // write the decoded object to the output directory, named from the name part of the 'file' property in the json responses (e.g., foo.zip or foo.patch)
}

String getDiffFileNameFromResponses(responses) {
  for (var response in responses) {
    if (response.name == "diff_file") {
      return basename(response.answer);
    }
  }
  return "unkown_diff_file_name.patch";
}

String getZipFileNameFromResponses(responses) {
  for (var response in responses) {
    if (response.name == "snapshot_file") {
      return basename(response.answer);
    }
  }
  return "unkown_zip_file_name.zip";
}

