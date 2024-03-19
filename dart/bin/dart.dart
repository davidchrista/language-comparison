import 'package:dart/dart.dart' as dart;

void main(List<String> arguments) {
  print('hello ${dart.name()}');
}

// functions

int add(int a, int b) {
  return a + b;
}

// pass by value or reference?

// general rule: pass by "creating an additional name for a variable"
// reassigning a name to something different, lets it point to a new
// variable, leaving the passed variable unchanged
// but: when passing an object, the "content" of the object can be
// modified!
// We conclude:
//   * primitives act always like "pass by value"
//   * objects act like "pass by reference", as long as not reassigned
//   * reassignment causes the "reference" to be lost.

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
    case 4 || 8: // patterns also possible
      y = x;
    default:
      y = 0;
  }

  // evaluated expressions not allowed!

  // switch expressions
  var z = switch (x) { 2 || 4 => 1, 3 => 3, _ => 0 };

  // guard clause: additional requirement
  switch (x) {
    case 1 || 3 when x * x < 9:
      y = x + 2;
    default:
      y = 0;
  }
}

// strings

void f5_5() {
  var s = 'string';
  var u = "string"; // both "" and '' allowed
  var r = '\u{1f606}'; // still a string; no rune literal!
  r = s[0];
}

// structs

// no distinct structs, only classes

class Struct {
  int a;
  String s;
  Struct(this.a, this.s);
}

void f6() {
  var x = Struct(1, 'b'); // no "new" required!
  Struct y;
}

// classes

class Class {
  int a;
  String s;
  Class(this.a, this.s);
  String generate() {
    var ret = '';
    if (a < 0) {
      return ret;
    }
    for (var i = 0; i < a; i++) {
      ret += s;
    }
    return ret;
  }

  void incr() {
    a++;
  }
}

void f7() {
  var s = Class(2, 'test');
  s.incr();
  var p = s.generate();
}

// function objects

int apply(int x, int Function(int) h) {
  return h(x);
}

void f8() {
  var double = (int a) {
    return 2 * a;
  };
  // or short
  double = (a) => 2 * a;
  var x = apply(3, double);
  var y = apply(4, (i) => i * i);
}
