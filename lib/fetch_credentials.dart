import 'package:cos/pigeon.dart';

abstract class IFetchCredentials{
  Future<SessionQCloudCredentials> fetchSessionCredentials();
}