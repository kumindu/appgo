package app

import (
	"net/http"
	"encoding/json"
	 "GO/libs"
)


func main() {
	http.HandleFunc("/animal", getValue)
	http.ListenAndServe(":8000", nil)
}

func getValue(w http.ResponseWriter, r *http.Request) {
	keys, ok := r.URL.Query()["name"]
	animal, err := database(string(keys[0]))
	js, err := json.Marshal(animal)
	if err != nil {
	  http.Error(w, err.Error(), http.StatusInternalServerError)
	  return
	}
	w.Header().Set("Content-Type", "application/json")
	w.Write(js)
}