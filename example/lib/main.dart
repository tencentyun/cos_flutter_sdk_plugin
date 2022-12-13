import 'package:cos_plugin/cos.dart';
import 'package:cos_plugin/pigeon.dart';
import 'routers/delegate.dart';
import 'routers/route_parser.dart';
import 'test_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'common/constant.dart';
import 'common/handle_error_utils.dart';
import 'cos/fetch_credentials.dart';

void main() async {
  /// 确保初始化完成
  WidgetsFlutterBinding.ensureInitialized();

  //初始化测试常量 账号信息等
  await TestConst().init();

  //初始化COS
  Cos().iFetchCredentials = FetchCredentials();
  await Cos().registerDefaultService(Constant.serviceConfig);
  await Cos().registerDefaultTransferManger(Constant.serviceConfig, TransferConfig());

  handleError(() => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'COS 传输实践',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routeInformationParser: MyRouteParser(),
      routerDelegate: MyRouterDelegate(),
      backButtonDispatcher: RootBackButtonDispatcher(),
      builder: EasyLoading.init(),
    );
  }
}


