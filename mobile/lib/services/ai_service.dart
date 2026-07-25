import 'dart:typed_data';

class ClassificationResult {
  const ClassificationResult(this.label, this.confidence);
  final String label;
  final double confidence;
}

class FaceDetectionResult {
  const FaceDetectionResult({required this.box, required this.embedding, required this.confidence});
  final List<double> box;
  final Float32List embedding;
  final double confidence;
}

abstract interface class ImageClassifier {
  Future<List<ClassificationResult>> classify(Uint8List bytes);
}

abstract interface class OcrEngine {
  Future<String> extractText(Uint8List bytes);
}

abstract interface class FaceEngine {
  Future<List<FaceDetectionResult>> detect(Uint8List bytes);
}

abstract interface class EmbeddingEngine {
  Future<Float32List> imageEmbedding(Uint8List bytes);
  Future<Float32List> textEmbedding(String text);
}

class AiPipelineResult {
  const AiPipelineResult({required this.tags, required this.ocrText, required this.faces, required this.embedding});
  final List<ClassificationResult> tags;
  final String ocrText;
  final List<FaceDetectionResult> faces;
  final Float32List embedding;
}

class AiService {
  const AiService({required this.classifier, required this.ocr, required this.faces, required this.embeddings});
  final ImageClassifier classifier;
  final OcrEngine ocr;
  final FaceEngine faces;
  final EmbeddingEngine embeddings;

  Future<AiPipelineResult> process(Uint8List bytes) async {
    final results = await Future.wait<Object>([
      classifier.classify(bytes),
      ocr.extractText(bytes),
      faces.detect(bytes),
      embeddings.imageEmbedding(bytes),
    ]);
    return AiPipelineResult(
      tags: results[0] as List<ClassificationResult>,
      ocrText: results[1] as String,
      faces: results[2] as List<FaceDetectionResult>,
      embedding: results[3] as Float32List,
    );
  }
}

class PlaceholderClassifier implements ImageClassifier {
  @override Future<List<ClassificationResult>> classify(Uint8List bytes) async => const [];
}
class PlaceholderOcr implements OcrEngine {
  @override Future<String> extractText(Uint8List bytes) async => '';
}
class PlaceholderFaces implements FaceEngine {
  @override Future<List<FaceDetectionResult>> detect(Uint8List bytes) async => const [];
}
class PlaceholderEmbeddings implements EmbeddingEngine {
  @override Future<Float32List> imageEmbedding(Uint8List bytes) async => Float32List(512);
  @override Future<Float32List> textEmbedding(String text) async => Float32List(512);
}
