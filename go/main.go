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
}
