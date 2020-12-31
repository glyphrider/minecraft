package main

import (
    "io/ioutil"
    "os"
    "text/template"
    "encoding/json"
)

func main() {
    var tfstate interface{}
    raw_inventory, _ := ioutil.ReadFile("terraform.tfstate")
    raw_template, _ := ioutil.ReadFile("mkinventory.tmpl")
    json.Unmarshal([]byte(raw_inventory), &tfstate)
    inventory, _ := os.Create("inventory.yml")
    template, _ := template.New("inventory").Parse(string(raw_template))
    _ = template.Execute(inventory,tfstate)
    inventory.Close()
}
