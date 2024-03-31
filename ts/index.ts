console.log("hello ts");

///// functions

function add(a: number, b: number): number {
  return a + b;
}

// there are no named parameters!

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

function f1() {
  let x = 5;
  let y = "string";
}

///// lists

function f2() {
  const a = [1, 2, 3];
  let b: string[] = [];
  const c: Array<string> = [];

  // list literal
  b = ["bla", "ble"]

  a[0] = 0;

  c.push("3");
}

///// maps

function f3() {
  const m = { 1: "1", 2: "2" }; // no map, just an object

  const n: { [key: number]: string } = {1: "a"};// "map"
  n[5] = "b";

  // capacity is not considered

  const o = new Map<number, string>(); // Map type
  //o[3] = "4"; // error - not available
  o.set(3, "c");
  const a = o.get(3);
}

///// if

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

///// switch

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

  // empty switch as alternative to if-else chain
  x = 3;
  switch (true) {
    case x > 5:
      y = x - 2;
      break;
    case x > 2:
      y = x;
      break;
    default:
      y = x + 2;
      break;
  }
}

///// loops

function f5_0_5() {
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
  for (const x of a) {
    // ATTENTION: "of"
    s += x.toString();
  }

  // there's also for <field> in <object_fields>

  // forEach
  a.forEach((x) => {
    s += x.toString();
  });
}

///// strings

function f5_5() {
  let s = '"string"';
  let u = "string"; // both "" and '' allowed
  let r = s[0]; // no runes/characters
}

///// structs

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

///// classes

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

class Klass {
  // constructor shorthand: defines members a and s
  constructor(public a: number, public s: string) {}
}

function f7() {
  let s = new Class(2, "test"); // "new" required!
  s.incr();
  let p = s.generate();
}

///// inheritence

class Animal {
  constructor(private name: string) {}
  speak(text: string) {
    console.log(`${this.name} says. ${text}`);
  }
}

class Dog extends Animal {
  constructor(name: string, private bark: string) {
    super(name);
  }
  jump() {
    console.log("*dog jumps*");
  }
  greet() {
    this.speak(this.bark);
    this.jump();
  }
}

function f7_5() {
  const d = new Dog("Jack", "woof!");
  d.greet();
  d.speak("whrar!");
}

///// function objects

function apply(x: number, h: (a: number) => number) {
  return h(x);
}

function f8() {
  let double = (a: number) => {
    return 2 * a;
  };
  // or short
  double = (a: number) => 2 * a;
  var x = apply(3, double);
  var y = apply(4, (i) => i * i);
}

///// const/final

class C {
  // const class member: readonly
  readonly a: number;
  constructor(num: number) {
    this.a = num;
  }
}

function f9() {
  let a = 3;

  const x = 5;
  const y = a;
  const s = "string";
  //x = 6; // error

  const c = { a: 2, s: "string" };
  c.a = 3;
  // JS/TS const, like Dart final, only forbids reassignment
}

///// function return multiple values

function f10() {
  function swap(a: number, b: number): [number, number] {
    return [b, a];
  }
  const a = 0,
    b = 1;
  const [x, y] = swap(a, b);
}

///// interfaces

interface Shape {
  area(): number;
}

class Circle implements Shape {
  constructor(public r: number) {}
  area(): number {
    return 3.14 * this.r * this.r;
  }
}

function f11() {
  let s: Shape;
  s = new Circle(3);
  const area = s.area();
}

///// type conversion/assertions

class TypeToTest {
  constructor(public i: number) {}
}

function f12() {
  // simple number conversion not necessary (only number type)

  // type assertions
  let s: any;
  s = new TypeToTest(0);
  let v: TypeToTest;
  v = s; // no error in TS, but ugly/insecure
  let u: TypeToTest;
  u = s as TypeToTest;
  if (u !== undefined) {
    const x = u.i;
  }

  // sometimes we have to go the detour over "unknown":
  //const x = "hello" as number; // error
  const x = "hello" as unknown as number;
  // but we have to be careful with that!
}

///// string conversion

function f13() {
  const i = 3;
  const f = 3.14;
  const b = true;
  const d = new Date(2024);
  // all simple types and most library types have "toString"
  const s1 = i.toString();
  const s2 = f.toString();
  const s3 = b.toString();
  const s4 = d.toString();
}

///// error handling

function f14() {
  // basic error handling: try-catch
  const s = '{"a":123,"b":true,"c":"string"}';
  try {
    console.log(JSON.parse(s).c);
  } catch (e) {
    if (e instanceof SyntaxError) {
      console.log(`error: ${e}`);
    } else if (e instanceof Error) {
      // some other exception
      console.log(`error: ${e}`);
      throw e; // rethrow
    } else {
      // something else
      console.log(`error: ${e}`);
    }
  } finally {
    // some cleanup after any error case
  }

  // throwing errors
  const f = (d: number): number => {
    if (d < 0) {
      return 1 / -d;
    } else if (d > 0) {
      return 1 / d;
    }
    throw Error("invalid value");
  };
}

// user defined errors: im

class UserError extends Error {
  constructor(id: number, text: string) {
    super(`${id} : ${text}`);
  }
}

function throws(): number {
  throw new UserError(123, "error");
}

///// generics

// generic fuction

function map<T, V>(inp: Array<T>, f: (x: T) => V): Array<V> {
  const r: Array<V> = [];
  for (const x of inp) {
    r.push(f(x));
  }
  return r;
}

function f15() {
  const a: number[] = [1, 2, 3];
  const b = map(a, (i) => (i / 2.0).toString());
}

// generic types

class MyList<T> {
  private l: T[] = [];
  public append(x: T) {
    this.l.push(x);
  }
  public at(i: number): T {
    if (0 <= i && i <= this.l.length) {
      return this.l[i];
    }
    throw RangeError("out of range");
  }
}

///// json

interface JsonStruct {
  id: number;
  name: string;
}

interface JsonStructComplex {
  id: number;
  entries: JsonStruct[];
}

function f16() {
  const j: JsonStructComplex = {
    id: 1,
    entries: [
      { id: 1, name: "name" },
      { id: 1, name: "name2" },
    ],
  };
  console.log(j);
  const jsonDataString = JSON.stringify(j);
  console.log(jsonDataString);
  const jj = JSON.parse(jsonDataString) as JsonStructComplex;
  console.log(jj);
}

///// enum

// we can choose between enum and union type

enum Enum {
  Red = 0,
  Blue,
  Green,
}

type Union = "Red" | "Blue" | "Green";

function f17() {
  let d: Union;
  const c: Union = "Blue";
  console.log(c);
  if (c != "Blue") {
    console.log("something's wrong");
  }
  let f: Enum;
  const e: Enum = Enum.Blue;
  console.log(e);
  if (e != Enum.Blue) {
    console.log("something's wrong");
  }
}

///// asynchronicity

// need awaitable wrapper ...
async function delay(ms: number): Promise<void> {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

async function task1(): Promise<string> {
  console.log("Task 1 started");
  await delay(2000);
  return "Task 1 completed";
}

async function task2(): Promise<string> {
  console.log("Task 2 started");
  await delay(1000);
  return "Task 2 completed";
}

async function f18() {
  const p = task1();
  p.then((value) => console.log(value));
  const q = task2();
  q.then((value) => console.log(value));
  await Promise.all([p, q]);
}

///// SPECIAL STUFF

/// type definitions vs interfaces

// practically quite similar
// * general rule:
//   * interfaces for describing object structure
//   * type definitions for aliases, comples types
//     (unions, intersections), utility types or
//     generic types
// * interfaces can be extended, types cannot

interface Interface {
  a: number;
  b: string;
  f: (x: string) => number;
}

type Type = number | string;
