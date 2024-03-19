package main

import (
	"fmt"
)

func main() {
	fmt.Println("hello go")
}

// functions

func add(a int, b int) int {
	return a + b
}

// pass by value or reference?

// general rule: pass by value
// special cases:
//   * slices (as "reference" to underlying array)
//   * maps (again, "reference" to underlying data structure)
//   * channels

// variables

func f1() {
	var x = 5
	var y = "string"

	z := 7 // short
}

// lists

func f2() {
	a := []int{1, 2, 3}
	b := []string{}
}

// maps

func f3() {
	m := map[int]string{1: "1", 2: "2"}
	n := map[int]string{}
}

// if

func f4() {
	x := 1
	var y int
	if x > 5 {
		y = 3
	} else if x > 2 {
		y = 2
	} else {
		y = 1
	}

	// with short statement
	if z := 2 * x; z > 10 {
		y = 7
	}
}

// switch

func f5() {
	var y int
	switch x := 4; x {
	case 1:
		y = x - 1
		// no break necessary!
	case 2:
		y = x + 1
	case 4:
		y = x
	default:
		y = 0
	}

	// also with evaluated expressions
	// (all checked expressions are evaluated, up to a match)
	switch x := 3; x {
	case add(1, 1):
		y = 4
	case add(1, 2):
		y = 6
	default:
		y = 0
	}
}

// strings

func f5_5() {
	s := "string"
	r := 'a' // rune - no string!
	r = rune(s[0])
}

// structs

type Struct struct {
	a int
	s string
}

func f6() {
	x := Struct{1, "b"}
	var y Struct
}

// classes

// by defining methods on structs

type Class struct {
	a int
	s string
}

func (s *Class) generate() string {
	ret := ""
	if s.a < 0 {
		return ret
	}
	for i := 0; i < s.a; i++ {
		ret += s.s
	}
	return ret
}

func (s *Class) incr() {
	s.a++
}

func f7() {
	s := Class{2, "test"}
	s.incr()
	p := s.generate() // testtesttest
}

// function objects

func apply(x int, h func(int) int) int {
	return h(x)
}

func f8() {
	double := func(a int) int {
		return 2 * a
	}
	x := apply(3, double) // 6
	y := apply(4, func(i int) int { return i * i }) // 16
}
