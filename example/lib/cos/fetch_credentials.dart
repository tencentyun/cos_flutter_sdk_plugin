import 'dart:convert';
import 'dart:io';

import 'package:cos/fetch_credentials.dart';
import 'package:cos/pigeon.dart';

class FetchCredentials implements IFetchCredentials{
  @override
  Future<SessionQCloudCredentials> fetchSessionCredentials() async {
    var url = 'http://9.135.33.98:3000/sts';
    var httpClient = HttpClient();

    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var json = await response.transform(utf8.decoder).join();
        print(json);
        var data = jsonDecode(json);
        return SessionQCloudCredentials(
            secretId: data['credentials']['tmpSecretId'],
            secretKey: data['credentials']['tmpSecretKey'],
            token: data['credentials']['sessionToken'],
            startTime: data['startTime'],
            expiredTime: data['expiredTime']
        );
      } else {
        throw ArgumentError();
      }
    } catch (exception) {
      throw ArgumentError();
    }
  }
}