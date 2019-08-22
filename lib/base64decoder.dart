import 'dart:convert';
import 'dart:typed_data';

Uint8List decodeBytes(stringOfBytes) {
  return base64Decode(stringOfBytes);
}

String encodeBytes(bytes) {
  return base64Encode(bytes);
}
