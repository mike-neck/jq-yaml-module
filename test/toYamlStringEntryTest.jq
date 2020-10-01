import "test/test" as testing;
import "test/all" as run;
import "src/jq-yaml-module" as yaml;

def testWhenInputNotContainsNewLineNorColon:
  testing::test("testWhenInputNotContainsNewLineNorColon") |
  testing::expect( {key: "item", value: "normal string"} | yaml::toYamlStringEntry(2)) |
  testing::satisfies( . == "  item: normal string" )
;

def testWhenInputNotContainsNewLineNorColonWithoutIndent:
  testing::test("gwt style") |
  testing::Given( {key: "item", value: "normal string"} ) |
  testing::When( yaml::toYamlStringEntry(0) ) |
  testing::Then( . == "item: normal string" )
;

def runAll:
  run::all(
    testWhenInputNotContainsNewLineNorColon,
    testWhenInputNotContainsNewLineNorColonWithoutIndent
  )
;
