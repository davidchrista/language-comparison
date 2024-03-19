console.log("hello ts");

// functions

function add(a: number, b: number): number {
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

function f1() {
  let x = 5;
  let y = "string";
}

// lists

function f2() {
  const a = [1, 2, 3];
  const b: string[] = [];
}

// maps

function f3() {
  const m = { 1: "1", 2: "2" };
  const n: { [key: number]: string } = {};
}

// if

function f4() {
  let x = 1;
  let y: number;
  if (x > 5) {
    y = 3;
  } else if (x > 2) {
    y = 2;
  } else {
    y = 1;
  }
}

// switch

function f5() {
  let x = 1;
  let y: number;
  switch (x) {
    case 1:
      y = x - 1;
      break; // break necessary!
    case 2:
      y = x + 1;
      break;
    case 4:
      y = x;
      break;
    default:
      y = 0;
  }

  // also with evaluated expressions
  switch (x) {
    case add(0, 1):
      y = 4;
    case add(1, 2):
      y = 6;
    default:
      y = 0;
  }
}

// strings

function f5_5() {
  let s = '"string"';
  let u = "string"; // both "" and '' allowed
  let r = s[0]; // no runes/characters
}

// structs

// in JS/TS objects come first, so structs are just
// interfaces/types for objects

interface Struct {
  a: number;
  s: string;
}

type Struct2 = {
  a: number;
  s: string;
};

function f6() {
  let x: Struct = { a: 1, s: "b" };
  let y: Struct;
  let v: Struct2 = { a: 1, s: "b" };
  let w: Struct2;
}

// classes

class Class {
  a: number;
  s: string;
  constructor(x: number, v: string) {
    this.a = x;
    this.s = v;
  }
  generate(): string {
    var ret = "";
    if (this.a < 0) {
      return ret;
    }
    for (var i = 0; i < this.a; i++) {
      ret += this.s;
    }
    return ret;
  }
  incr() {
    this.a++;
  }
}

function f7() {
  let s = new Class(2, "test"); // "new" required!
  s.incr();
  let p = s.generate();
}

// function objects

function apply(x: number, h: (a: number) => number) {
  return h(x);
}

function f8() {
  let double = (a: number) => {
    return 2 * a;
  }
  // or short
  double = (a: number) => 2 * a;
  var x = apply(3, double);
  var y = apply(4, (i) => i * i);
}
