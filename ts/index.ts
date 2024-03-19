console.log("hello ts");

// functions

function add(a: number, b: number): number {
  return a + b;
}

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
}
