import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class TestConst {
  final String UT_TAG = "QCloudTest";

  late String COS_APP_ID="";
  late String SECRET_ID="";
  late String SECRET_KEY="";
  late String PERSIST_BUCKET_REGION="";

  late String PERSIST_BUCKET = "mobile-ut-1253960454";
  late String PERSIST_BUCKET_PIC_PATH = "do_not_remove/image.png";
  late String PERSIST_BUCKET_QR_PATH = "do_not_remove/qr.png";
  late String PERSIST_BUCKET_VIDEO_PATH = "do_not_remove/video.mp4";
  late String PERSIST_BUCKET_SELECT_JSON_PATH = "do_not_remove/select.json";
  late String PERSIST_BUCKET_SELECT_CSV_PATH = "do_not_remove/select.csv";
  late String PERSIST_BUCKET_DOCUMENT_PATH = "do_not_remove/document.docx";
  late String PERSIST_BUCKET_POST_OBJECT_PATH = "do_not_remove/post_object";
  late String PERSIST_BUCKET_APPEND_OBJECT_PATH = "do_not_remove/append_object";
  late String PERSIST_BUCKET_COPY_OBJECT_DST_PATH = "do_not_remove/copy_dst_object";
  late String PERSIST_BUCKET_DEEP_ARCHIVE_OBJECT_PATH = "do_not_remove/small_object_archive";

  TestConst._internal();
  factory TestConst() => _instance;
  static final TestConst _instance = TestConst._internal();

  init() async{
    try{
      String data = await rootBundle.loadString("assets/config.json");
      final jsonConfig = jsonDecode(data);
      COS_APP_ID = jsonConfig['COS_APP_ID'];
      SECRET_ID = jsonConfig['COS_SECRET_ID'];
      SECRET_KEY = jsonConfig['COS_SECRET_KEY'];
      PERSIST_BUCKET_REGION = jsonConfig['PERSIST_BUCKET_REGION'];
    }catch(e){
      print(e);
    }

    if (kDebugMode) {
      print('COS_APP_ID=$COS_APP_ID SECRET_ID=$SECRET_ID SECRET_KEY=$SECRET_KEY PERSIST_BUCKET_REGION=$PERSIST_BUCKET_REGION');
    }
  }
}