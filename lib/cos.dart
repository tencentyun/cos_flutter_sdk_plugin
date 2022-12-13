import 'dart:collection';

import 'pigeon.dart';

import 'cos_service.dart';
import 'cos_transfer_manger.dart';
import 'exceptions.dart';
import 'fetch_credentials.dart';
import 'impl_flutter_cos_api.dart';

class Cos {
  static const String DEFAULT_KEY = "";

  late IFetchCredentials iFetchCredentials;

  Cos._internal() {
    FlutterCosApi.setup(ImplFlutterCosApi());
  }

  factory Cos() => _instance;
  static final Cos _instance = Cos._internal();

  final CosApi _cosApi = CosApi();

  final Map<String, CosService> _cosServices = HashMap();
  final Map<String, CosTransferManger> _cosTransferMangers = HashMap();

  Future<void> setCloseBeacon(bool isCloseBeacon) async {
    return await _cosApi.setCloseBeacon(isCloseBeacon);
  }

  Future<CosService> registerDefaultService(CosXmlServiceConfig config) async {
    await _cosApi.registerDefaultService(config);
    var cosService = CosService(DEFAULT_KEY);
    _cosServices[DEFAULT_KEY] = cosService;
    return cosService;
  }

  Future<CosTransferManger> registerDefaultTransferManger(
      CosXmlServiceConfig config, TransferConfig transferConfig) async {
    await _cosApi.registerDefaultTransferManger(config, transferConfig);
    var cosTransferManger = CosTransferManger(DEFAULT_KEY);
    _cosTransferMangers[DEFAULT_KEY] = cosTransferManger;
    return cosTransferManger;
  }

  Future<CosService> registerService(
      String serviceKey, CosXmlServiceConfig config) async {
    if (serviceKey == DEFAULT_KEY) {
      throw IllegalArgumentException("register key Cannot be empty");
    }

    await _cosApi.registerService(serviceKey, config);
    var cosService = CosService(serviceKey);
    _cosServices[serviceKey] = cosService;
    return cosService;
  }

  Future<CosTransferManger> registerTransferManger(String serviceKey,
      CosXmlServiceConfig config, TransferConfig transferConfig) async {
    if (serviceKey == DEFAULT_KEY) {
      throw IllegalArgumentException("register key Cannot be empty");
    }

    await _cosApi.registerTransferManger(serviceKey, config, transferConfig);
    var cosTransferManger = CosTransferManger(serviceKey);
    _cosTransferMangers[serviceKey] = cosTransferManger;
    return cosTransferManger;
  }

  bool hasDefaultService() {
    return _cosServices.containsKey(DEFAULT_KEY);
  }

  CosService getDefaultService() {
    if(_cosServices.containsKey(DEFAULT_KEY)){
      return _cosServices[DEFAULT_KEY]!;
    } else {
      throw IllegalArgumentException("default service unregistered");
    }
  }

  bool hasDefaultTransferManger() {
    return _cosTransferMangers.containsKey(DEFAULT_KEY);
  }

  CosTransferManger getDefaultTransferManger() {
    if(_cosTransferMangers.containsKey(DEFAULT_KEY)){
      return _cosTransferMangers[DEFAULT_KEY]!;
    } else {
      throw IllegalArgumentException("default transfer manger unregistered");
    }
  }

  bool hasService(String key) {
    return _cosServices.containsKey(key);
  }

  CosService getService(String key) {
    if(_cosServices.containsKey(key)){
      return _cosServices[key]!;
    } else {
      throw IllegalArgumentException("$key service unregistered");
    }
  }

  bool hasTransferManger(String key) {
    return _cosTransferMangers.containsKey(key);
  }

  CosTransferManger getTransferManger(String key) {
    if(_cosTransferMangers.containsKey(key)){
      return _cosTransferMangers[key]!;
    } else {
      throw IllegalArgumentException("$key transfer manger unregistered");
    }
  }
}
