module {
  "name": "jq-yaml-module",
  "description": "Converts JSON into YAML",
  "repository": {
    "type": "git",
    "url": "https://github.com/mike-neck/jq-yaml-module.git",
    "license": "MIT",
    "author": "Shinya Mochida(mike-neck)"
  }
};


def toYaml:
  if type == "object" then
    "object-\(to_entries | map(.key) | join(", "))"
  elif type == "array" then
    "array-\(length)"
  elif type == "string" then
    "string-\(.)"
  elif type == "null" then
    "null"
  else
    "\(.)"
  end
;

def indent(ident):
  [range(0; ident) | " "] | join("")
;

def toYamlStringEntry(ident):
  if .value | contains("\n") then
    indent(ident) as $keyIndent |
    indent(ident + 2) as $valueIndent |
    ["\($keyIndent)\(.key): |", (.value | split("\n") | "\($valueIndent)\(.)")] |
    join("\n")
  elif .value | contains(":") then
    "\(indent(ident))\(.key): \"\(.value)\""
  else
    "\(indent(ident))\(.key): \(.value)"
  end
;

