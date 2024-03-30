import 'dart:convert';

import 'package:dart/dart.dart' as dart;

void main(List<String> arguments) {
  print('hello ${dart.name()}');
}

///// functions

int add(int a, int b) {
  return a + b;
}

// we can also use named parameters

int plusmult(int a, int b, {int aMult = 1, int bMult = 1}) {
  // named parameters must either have default or be "required"!
  return a * aMult + b * bMult;
}

void f0() {
  var x = plusmult(2, 4, aMult: 5);
}

///// pass by value or reference?

// general rule: pass by "creating an additional name for a variable"
// reassigning a name to something different, lets it point to a new
// variable, leaving the passed variable unchanged
// but: when passing an object, the "content" of the object can be
// modified!
// We conclude:
//   * primitives act always like "pass by value"
//   * objects act like "pass by reference", as long as not reassigned
//   * reassignment causes the "reference" to be lost.

///// variables

void f1() {
  int z; // initial value: null !
  var x = 5;
  var y = 'string';
}

///// lists

void f2() {
  var a = [1, 2, 3];
  var b = <String>[];
}

///// maps

void f3() {
  var m = {1: '1', 2: '2'};
  Map<int, String> n;
}

///// if

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

///// switch

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

  // NO empty switch as alternative to if-else chain!
}

///// loops

void f5_0_5() {
  // basic loop
  var s = "";
  for (var i = 0; i < 10; i++) {
    s += "a";
  }
  var j = 0;
  while (j++ < 10) {
    s += "b";
  }
  while (true) {
    break;
  }

  // "for in"
  var a = [1, 2, 3, 4, 5];
  s = "";
  for (final x in a) {
    s += x.toString();
  }

  // forEach
  a.forEach((x) {
    s += x.toString();
  });
}

///// strings

void f5_5() {
  var s = 'string';
  var u = "string"; // both "" and '' allowed
  var r = '\u{1f606}'; // still a string; no rune literal!
  r = s[0];
}

///// structs

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

///// classes

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

///// inheritence

class Animal {
  final String _name;
  const Animal(this._name);
  void speak(String text) {
    print('$_name says: $text');
  }
}

class Dog extends Animal {
  final String _bark;
  const Dog(String name, this._bark) : super(name);
  void jump() {
    print('*dog jumps*');
  }
  void greet() {
    speak(_bark);
    jump();
  }
}

void f7_5() {
  var d = Dog('Jack', 'woof!');
  d.greet();
  d.speak("whrar!");
}

///// function objects

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

///// const/final

class ConstStruct {
  final int a, b;
  // all fields need to be final to enable const constructor
  const ConstStruct(this.a, this.b);
  // need to have const constructor to create const objects
}

void f9() {
  var a = 3;

  // const for compile time constants
  const x = 5;
  //const y = a; // error - a is not compile time constant
  const s = 'string';
  //const y = Struct(1, 'string'); // error - no const constructor
  const y = ConstStruct(1, 2);

  // final for run time constants
  final c = a;
  //c = 4; // error
  final u = Struct(1, 'string');
  u.a = 3; // final only forbids reassignment
}

///// function return multiple values

void f10() {
  (int, int) swap(int a, int b) {
    return (b, a);
  }

  const a = 0, b = 1;
  final (x, y) = swap(a, b);
}

///// interfaces

abstract class Shape {
  double area();
}

class Circle implements Shape {
  double r;
  Circle(this.r);
  @override
  double area() {
    return 3.14 * r * r;
  }
}

void f11() {
  Shape s;
  s = Circle(3);
  var area = s.area();
}

///// type conversion/assertions

class TypeToTest {
  int i;
  TypeToTest(this.i);
}

void f12() {
  // simple number conversion
  var i = 0;
  double d = i.toDouble();

  // type assertions
  Object s;
  s = TypeToTest(0);
  TypeToTest u;
  //u = s; // error - different types; need assertion
  if (s is TypeToTest) {
    // in this scope, s is now implicitly of type TypeToTest
    var x = s.i;
  }
}

///// string conversion

void f13() {
  var i = 3;
  var f = 3.14;
  var b = true;
  var d = DateTime(2024);
  // all simple types and most library types have "toString"
  var s1 = i.toString();
  var s2 = f.toString();
  var s3 = b.toString();
  var s4 = d.toString();
}

///// error handling

void f14() {
  // basic error handling: try-catch
  var s = "3.14";
  try {
    print(double.parse(s));
  } on FormatException catch (e) {
    // specific exception
    print("error: $e");
  } on Exception catch (e) {
    // some other exception
    print("error: $e");
    rethrow; // optional: needs to be handled by caller
  } catch (e, s) {
    // something else
    print("error: $e");
    print("stack: $s");
  } finally {
    // some cleanup after any error case
  }

  // throwing errors
  double f(double d) {
    if (d < 0) {
      return 1 / (-d);
    } else if (d > 0) {
      return 1 / d;
    }
    throw ArgumentError('invalid value');
  }
}

// user defined errors: implement Exception interface

class UserError implements Exception {
  final String message;
  const UserError(int id, String t) : message = '$id : $t';
  @override
  String toString() {
    return message;
  }
}

int throws() {
  throw UserError(123, "error");
}

///// generics

// generic fuction

List<V> map<T, V>(List<T> inp, V Function(T) f) {
  List<V> r = [];
  for (final x in inp) {
    r.add(f(x));
  }
  return r;
}

void f15() {
  var a = <int>[1, 2, 3];
  var b = map(a, (i) => i.toDouble() / 2.0);
}

// generic types

class MyList<T> {
  final List<T> _l = [];
  void append(T x) {
    _l.add(x);
  }

  T at(int i) {
    if (0 <= i && i <= _l.length) {
      return _l[i];
    }
    throw IndexError.withLength(i, _l.length);
  }
}

///// json

class JsonStruct {
  int id;
  String name;
  JsonStruct(this.id, this.name);
  Map<String, dynamic> toJson() => {'id': id, 'name': name};
  factory JsonStruct.fromJson(Map<String, dynamic> json) {
    return JsonStruct(json['id'] as int, json['name'] as String);
  }
}

class JsonComplexStruct {
  int id;
  List<JsonStruct> entries;
  JsonComplexStruct(this.id, this.entries);
  Map<String, dynamic> toJson() =>
      {'id': id, 'entries': entries.map((e) => e.toJson()).toList()};
  factory JsonComplexStruct.fromJson(Map<String, dynamic> json) {
    List<dynamic> entries = json['entries'];
    List<JsonStruct> entryList =
        entries.map((e) => JsonStruct.fromJson(e)).toList();
    return JsonComplexStruct(json['id'] as int, entryList);
  }
}

void f16() {
  var j = JsonComplexStruct(1, [JsonStruct(1, 'name'), JsonStruct(2, 'name2')]);
  print(j);
  var jsonDataStr = json.encode(j);
  print(jsonDataStr);
  var jj = JsonComplexStruct.fromJson(json.decode(jsonDataStr));
  print(jj);
}

///// enum

enum Color { Red, Green, Blue }

void f17() {
  Color d;
  var c = Color.Red;
  print(c);
  if (c == Color.Blue) {
    print('something\'s wrong');
  }
}

///// SPECIAL STUFF

// optional positional parameters

void s1() {
  int sum(int a, int? b) {
    return a + (b ?? 0);
  }

  var i = sum(1, 2);
  //i = sum(1); // error: b can be null but must be provided
  int sum2(int a, [int? b]) {
    return a + (b ?? 0);
  }

  i = sum2(1);
}
