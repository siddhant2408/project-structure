package main

import (
	"fmt"
	"net/http"

	"github.com/siddhant2408/project-structure/internal/delivery/api"
)

func main() {
	fmt.Println("Starting Server...")
	err := http.ListenAndServe(":8080", api.New())
	if err != nil {
		panic(err)
	}
}
