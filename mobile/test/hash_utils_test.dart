import 'package:flutter_test/flutter_test.dart';
import 'package:photosync/services/hash_utils.dart';

void main() {
  test('hamming distance is zero for equal hashes', () {
    expect(PerceptualHash.hammingDistance('ffffffffffffffff', 'ffffffffffffffff'), 0);
  });
  test('hamming distance counts changed bits', () {
    expect(PerceptualHash.hammingDistance('0000000000000000', '000000000000000f'), 4);
  });
}
