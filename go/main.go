package main

import (
	"errors"
	"fmt"
	"strconv"
)

func main() {
	fmt.Println("hello go")
}

///// functions

func add(a int, b int) int {
	return a + b
}

// there are no named parameters!

///// pass by value or reference?

// general rule: pass by value
// special cases:
//   * slices (as "reference" to underlying array)
//   * maps (again, "reference" to underlying data structure)
//   * channels

///// variables

func f1() {
	var x = 5
	var y = "string"

	z := 7 // short
}

///// lists

func f2() {
	a := []int{1, 2, 3}
	b := []string{}
}

///// maps

func f3() {
	m := map[int]string{1: "1", 2: "2"}
	n := map[int]string{}
}

///// if

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

///// switch

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

	// empty switch as alternative to if-else chain
	x := 3
	switch {
	case x > 5:
		y = x - 2
	case x > 2:
		y = x
	default:
		y = x + 2
	}
}

///// loops

func f5_0_5() {
	// basic loop
	s := ""
	for i := 0; i < 10; i++ {
		s += "a"
	}
	j := 0
	for j < 10 { // "while"
		j++
		s += "b"
	}
	for { // "forever"
		break
	}

	// "for in"
	a := []int{1, 2, 3, 4, 5}
	s = ""
	for _, x := range a { // index unused in this case
		s += strconv.Itoa(x)
	}

	// there is no "forEach" on lists!
}

///// strings

func f5_5() {
	s := "string"
	r := 'a' // rune - no string!
	r = rune(s[0])
}

///// structs

type Struct struct {
	a int
	s string
}

func f6() {
	x := Struct{1, "b"}
	var y Struct
}

///// classes

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

///// function objects

func apply(x int, h func(int) int) int {
	return h(x)
}

func f8() {
	double := func(a int) int {
		return 2 * a
	}
	x := apply(3, double)                           // 6
	y := apply(4, func(i int) int { return i * i }) // 16
}

///// const/final

func f9() {
	const a = 100 // numeric constant can act as int a.w.a. float
	//a = 500 // error
	//const s = Struct{1, "a"}; // error - only primitives can be const
	//const x := 100 // error - ":=" not allowed for const
}

///// function return multiple values

func f10() {
	swap := func(a int, b int) (int, int) {
		return b, a
	}
	// or with named return:
	swap2 := func(a int, b int) (x int, y int) {
		x = b
		y = a
		return
	}
	const (
		a = 0
		b = 1
	)
	x, y := swap(a, b)
	x, y = swap2(x, y)
}

///// interfaces

type Shape interface {
	Area() float64
}

type Circle struct {
	r float64
}

// interface implementation is implicit
func (c Circle) Area() float64 {
	return 3.14 * c.r * c.r
}

func f11() {
	var s Shape
	s = Circle{3}
	area := s.Area()
}

///// type conversion/assertions

type TypeToTest struct {
	i int
}

func f12() {
	// simple number conversion
	i := 0
	d := float32(i)

	// type assertions
	var s interface{}
	s = TypeToTest{0}
	var u TypeToTest
	//u = s // error - different types; need assertion
	var success bool
	if u, success = s.(TypeToTest); success {
		x := u.i
	}
}

///// string conversion

func f13() {
	i := 3
	f := 3.14
	b := true
	// for simply types we can use strconf package in most cases
	s1 := strconv.Itoa(i)
	s2 := strconv.FormatFloat(f, 'f', -1, 64)
	s3 := strconv.FormatBool(b)
}

///// error handling

func f14() {
	// basic error handling: optional second returen value
	s := "3.14"
	if f, e := strconv.ParseFloat(s, 64); e == nil {
		fmt.Println(f)
	} else {
		if err, ok := e.(*strconv.NumError); ok {
			// specific error
			fmt.Printf("error: %s", err.Error())
		} else {
			// other error
			fmt.Printf("error: %s", err.Error())
		}
	}

	// throwing errors
	f := func(in float64) (out float64, err error) {
		if in < 0 {
			out = 1 / (-in)
		} else if in > 0 {
			out = 1 / in
		} else {
			err = errors.New("invalid value")
		}
		return
	}
}

// user defined errors: implement error interface

type UserError struct {
	id   int
	text string
}

func (e UserError) Error() string {
	return fmt.Sprintf("%d : %s", e.id, e.text)
}

func throws() (int, error) {
	return 0, UserError{123, "error"}
}

///// generics

// generic function

func Map[T, V any](in []T, f func(T) V) []V {
	r := make([]V, len(in))
	for i := range in {
		r[i] = f(in[i])
	}
	return r
}

func f15() {
	a := []int{1, 2, 3}
	b := Map(a, func(i int) float32 { return float32(i) / 2 })
}

// generic types

type List[T any] struct {
	items []T
}

func (l *List[T]) append(new T) {
	l.items = append(l.items, new)
}

func (l *List[T]) at(i int) (t T, e error) {
	if 0 <= i && i < len(l.items) {
		t = l.items[i]
	} else {
		e = errors.New("out of range")
	}
	return
}

///// json

func f16() {

}

///// enum

func f17() {

}

/////

func f() {

}

///// SPECIAL STUFF

// defer

func s1() {
	cleanup1 := func() {}
	cleanup2 := func() {}

	defer cleanup1()
	defer cleanup2()

	// ... function code ...

	// at the end the deferred functions get called (LIFO: 2 -> 1)
}

// method call on nil value is possible, if implemented

type Stru struct {
	i int
}

func (s *Stru) print() {
	if s == nil {
		fmt.Println("nil")
	} else {
		fmt.Println(s.i)
	}
}

func s2() {
	var s Stru
	s.print()
	s = Stru{3}
	s.print()
}
