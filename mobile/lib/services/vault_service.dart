import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class VaultService {
  static const _pinKey='vault_pin_hash'; final _storage=const FlutterSecureStorage();
  String _hash(String pin)=>sha256.convert(utf8.encode(pin)).toString();
  Future<bool> hasPin()=>_storage.containsKey(key:_pinKey);
  Future<void> setPin(String pin) async { if(!RegExp(r'^\d{4,8}$').hasMatch(pin)) throw ArgumentError('PIN must be 4–8 digits'); await _storage.write(key:_pinKey,value:_hash(pin)); }
  Future<bool> unlock(String pin) async => await _storage.read(key:_pinKey)==_hash(pin);
  Future<void> clearPin()=>_storage.delete(key:_pinKey);
}
