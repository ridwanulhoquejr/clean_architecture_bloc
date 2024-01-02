import 'dart:io' show File;

String fixture(String fileName) =>
    File('test/fixtures/$fileName').readAsStringSync();
