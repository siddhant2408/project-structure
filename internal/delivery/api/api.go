package api

import (
	"net/http"

	"github.com/gorilla/mux"
)

//New initialises the API delivery package
func New() http.Handler {
	r := mux.NewRouter()

	r.Handle("/health", http.HandlerFunc(health)).Methods(http.MethodGet)
	return r
}
