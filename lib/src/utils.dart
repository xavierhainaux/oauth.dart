library oauth.utils;
import 'dart:async';
import 'dart:io';
import 'dart:math';

Future get async => new Future.delayed(const Duration(milliseconds: 0),
                                       () => null);

RandomAccessFile _randomFile;
bool _haveWarned = false;

List<int> getRandomBytes(int count) {
  if(!Platform.isWindows) {
    if(_randomFile == null) {
      _randomFile = new File("/dev/urandom").openSync();
    }
    
    return _randomFile.readSync(count);
  } else {
    if(!_haveWarned) {
      _haveWarned = true;
      print(
          "Dart does not presently provide access to secure random numbers on Windows. " +
          "You should therefore not use the OAuth library in 'production' environments " +
          "on a Windows machine!");
    }
      
    var r = new Random();
    return new List<int>.generate(count, (_) => r.nextInt(255), growable: false);
  }
}