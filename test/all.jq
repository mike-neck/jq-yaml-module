module {
  "name": "all"
};

# test type
# name: a name of test
# test: boolean value (true - pass, false - fail)

def all(tests):
  . as $input |
  [tests] |
  length as $testSize |
  map(select(.test != true)) |
  if length == 0
  then "ok - tests: \($testSize)"
  else
    ["test failed", (map( "test: \(.name) [unexpected-value: \(.subject)]" ) | .[]), "count: \(length)/\($testSize)"] |
    join("\n") |
    error(.)
  end
;
