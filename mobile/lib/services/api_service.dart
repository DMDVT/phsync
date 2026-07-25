import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  ApiService({String baseUrl='http://10.0.2.2:8000'}):dio=Dio(BaseOptions(baseUrl: baseUrl));
  final Dio dio; final _storage=const FlutterSecureStorage();
  Future<Options> _auth() async => Options(headers:{'Authorization':'Bearer ${await _storage.read(key:'access_token') ?? ''}'});
  Future<List<dynamic>> friends() async => (await dio.get('/friends',options:await _auth())).data as List;
  Future<List<dynamic>> pendingShares() async => (await dio.get('/share/pending',options:await _auth())).data as List;
  Future<List<dynamic>> notifications() async => (await dio.get('/notifications',options:await _auth())).data as List;
  Future<void> sendFile({required int recipientId,required File file,String? caption}) async { final form=FormData.fromMap({'recipient_id':recipientId,'caption':caption,'file':await MultipartFile.fromFile(file.path)}); await dio.post('/share/send',data:form,options:await _auth()); }
  Future<void> downloadShare(String id,String target) async { await dio.download('/share/download/$id',target,options:await _auth()); await dio.post('/share/confirm/$id',options:await _auth()); }
}
