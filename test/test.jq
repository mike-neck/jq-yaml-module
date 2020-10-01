module {
  "name": "test"
};

# type-name: TestTitle
# properties:
# - name: string

# type-name: TestInput
# properties:
# - name: string
# - input: object | array | string | number | boolean | null

# type-name: TestSubject
# properties:
# - name: string
# - subject: object | array | string | number | boolean | null
# - error: object | null

# type-name: Test
# properties:
# - name: string
# - subject: object | array | string | number | boolean | null
# - test: boolean

# argument: string
# input: N/A
# output: TestTitle
def test(title):
  {name: "\(title)"}
;

# argument: object | array | string | number | boolean | null
# input: TestTitle
# output: TestSubject
def expect(object):
  { name: .name, subject: object }
;

# argument: filter(boolean)
# input: TestSubject
# output: Test
def satisfies(conditionFilter):
  if .error == null then
    {
      name: .name,
      subject: .subject,
      test: (.subject | conditionFilter)
    }
  else
    {
      name: .name,
      subject: .error,
      test: false
    }
  end
;

def Given(input):
  { name: .name, input: input }
;

def When(operation):
  . as $input |
  try
    { name: $input.name, subject: ($input.input | operation) }
  catch
    { name: $input.name, error: "\(.)" }
;

def Then(condition):
  satisfies(condition)
;
