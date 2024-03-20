import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:message_list/util/wechat_date_format.dart';

void main() {
  test('wechat date format', () {
    debugPrint(WechatDateFormat.format(1972058683000).toString());
    debugPrint(WechatDateFormat.format(1772052683000).toString());
  });
}
