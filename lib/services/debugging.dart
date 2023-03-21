import 'package:flutter/foundation.dart';

debugShow(textToPrint){
  if (!kDebugMode) return;

    final stackTrace = StackTrace.current;
    final _sourceFileLink = stackTrace.toString().split("\n")[1];
    final _regexCodeLine = RegExp(r" (\(.*\))$");
    final _matchData = _regexCodeLine.stringMatch(_sourceFileLink);

    debugPrint(
        '\x1B[32m[${DateTime.now()}] $_matchData\n$textToPrint\x1B[0m\n\n');
}