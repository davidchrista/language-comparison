import 'package:dart/dart.dart' as dart;

void main(List<String> arguments) {
  print('hello ${dart.name()}');
}

// functions

int add(int a, int b) {
  return a + b;
}

// variables

void f1() {
  var x = 5;
  var y = 'string';
}

// lists

void f2() {
  var a = [1, 2, 3];
  var b = <String>[];
}

// maps

void f3() {
  var m = {1: '1', 2: '2'};
  Map<int, String> n;
}

// if

void f4() {
  var x = 1;
  int y;
  if (x > 5) {
    y = 3;
  } else if (x > 2) {
    y = 2;
  } else {
    y = 1;
  }

  // if-case
  if (x case 1 || 4) {
    // x "matches" the "pattern" 1 || 4
    y = 3;
  } else if (x case 2 || 5) {
    y = 9;
  }
}

// switch

void f5() {
  var x = 1;
  int y;
  switch (x) {
    case 1:
      y = x - 1;
      // no break necessary!
    case 2:
      y = x + 1;
    case 4:
      y = x;
    default:
      y = 0;
  }
}
