import strutils

proc perc(val: float, p=80.0): float =
  result = val * p / 100

proc readNumber(prompt: string): float =
  result = 0.0
  var
    input: string
    lst: seq[string]

  while result == 0.0:
    echo prompt
    input = stdin.readLine()
    if "," in input:
      input = input.replace(",", ".")

    lst = input.split(' ')
    if lst.len > 1:
      input = lst[0]

    try:
      result = parseFloat(input)
    except ValueError:
      echo "Please enter a number."


var
  percent, val, new_val: float

echo "Enter the percentage which should be applied to the values following..."
echo "Press Ctrl-C to exit."
percent = readNumber("percentage> ")

while true:
  val = readNumber("\nenter value> ")
  new_val = perc(val, percent)
  echo "       ", new_val







try:
  echo parseFloat("3.1")
except ValueError:
  echo "That was no number!"
