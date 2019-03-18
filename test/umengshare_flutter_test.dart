import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:umengshare_flutter/umengshare.dart';

void main() {
  const MethodChannel channel = MethodChannel('umengshare_flutter');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });


}
