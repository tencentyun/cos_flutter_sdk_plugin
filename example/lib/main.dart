import 'package:cos/cos.dart';
import 'package:cos/pigeon.dart';
import 'package:cos_example/routers/delegate.dart';
import 'package:cos_example/routers/route_parser.dart';
import 'package:cos_example/test_const.dart';
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

// class _MyAppState extends State<MyApp> {
//   String _platformVersion = 'Unknown';
//
//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }
//
//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initPlatformState() async {
//     String platformVersion;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     // We also handle the message potentially returning null.
//
//
//
//     try {
//
//
//
//
//       bool preBuildConnection = await Cos().getDefaultService().preBuildConnection(TestConst().PERSIST_BUCKET);
//       print(preBuildConnection);
//
//       String objectUrl = await Cos().getDefaultService().getObjectUrl(TestConst().PERSIST_BUCKET, TestConst().PERSIST_BUCKET_REGION, TestConst().PERSIST_BUCKET_PIC_PATH);
//       print(objectUrl);
//
//       CosXmlResultPigeon cosXmlResultPigeon = await Cos().getDefaultService().headObject(TestConst().PERSIST_BUCKET, TestConst().PERSIST_BUCKET_PIC_PATH);
//       print(cosXmlResultPigeon);
//
//       await Cos().getDefaultService().cancelAll();
//
//       platformVersion = 'preBuildConnection=$preBuildConnection objectUrl=$objectUrl headObjectResultPigeon=${cosXmlResultPigeon.httpMessage}';
//
//     } catch(e) {
//       platformVersion = e.toString();
//     }
//
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;
//
//     setState(() {
//       _platformVersion = platformVersion;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Center(
//           child: Text('Running on: $_platformVersion\n'),
//         ),
//       ),
//     );
//   }
// }



