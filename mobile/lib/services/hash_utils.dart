import 'dart:typed_data';
import 'package:image/image.dart' as img;

class PerceptualHash {
  static String dHash(Uint8List bytes) {
    final decoded = img.decodeImage(bytes);
    if (decoded == null) throw const FormatException('Unsupported image');
    final small = img.copyResize(img.grayscale(decoded), width: 9, height: 8);
    var value = BigInt.zero;
    var bit = 0;
    for (var y = 0; y < 8; y++) {
      for (var x = 0; x < 8; x++) {
        final left = small.getPixel(x, y).r;
        final right = small.getPixel(x + 1, y).r;
        if (left > right) value |= BigInt.one << bit;
        bit++;
      }
    }
    return value.toRadixString(16).padLeft(16, '0');
  }

  static int hammingDistance(String first, String second) {
    var xor = BigInt.parse(first, radix: 16) ^ BigInt.parse(second, radix: 16);
    var count = 0;
    while (xor > BigInt.zero) {
      count += (xor & BigInt.one).toInt();
      xor >>= 1;
    }
    return count;
  }
}
