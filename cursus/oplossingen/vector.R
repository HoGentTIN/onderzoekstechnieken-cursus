> v = c("Mary", "Sue")
> v
[1] "Mary" "Sue"

> names(v) = c("First", "Last")
> v
 First   Last
"Mary"  "Sue"

> v["First"]
[1] "Mary"

> v[c("Last", "First")]
  Last  First
 "Sue" "Mary"
