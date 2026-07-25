import 'dart:math' as math;
import 'dart:typed_data';

class SemanticSearchService {
  const SemanticSearchService();

  double cosineSimilarity(Float32List a, Float32List b) {
    if (a.length != b.length) throw ArgumentError('Embedding dimensions differ');
    var dot = 0.0, normA = 0.0, normB = 0.0;
    for (var i = 0; i < a.length; i++) {
      dot += a[i] * b[i];
      normA += a[i] * a[i];
      normB += b[i] * b[i];
    }
    if (normA == 0 || normB == 0) return 0;
    return dot / (math.sqrt(normA) * math.sqrt(normB));
  }
}
