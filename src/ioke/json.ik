JSON = Origin mimic

JSON CircularReferenceError = Condition Error mimic

JSON do(
  encode = method(
    "Provides JSON representation for given object",
    object,
    seen,

    if(seen include?(object),
      error!(CircularReferenceError, "Object references itself")
    )

    ensure(
      seen push!(object)
      jsonCells(object) toJson(seen),

      seen pop!
    )
  )
  
  private:buildObject = method(d,
    k = d removeAt!("kind")
    o = Ground send(k) mimic
    d each(pair,
      o cell(pair key) = pair value
    )
    o
  )
  
  private:object? = method(d,
    d key?("kind") && d keys all?(kind?("Text"))
  )
  
  private:dict = macro(
    d = call resendToMethod(:dict)
    if(JSON private:object?(d),
      JSON private:buildObject(d),
      
      d
    )
  )
  
  fromIoke = macro(
    let(Text cell(":"), DefaultBehavior cell("=>"),
      Ground cell("{}"), JSON cell("private:dict"),
      call argAt(0)
    )
  )
  
  fromText = method(
    "parses provided text as JSON and returns Ioke objects reflecting content",
    text,
    fromIoke(Message fromText(text) evaluateOn(Ground))
  )

  jsonCells = method(
    "returns object's cells that can be exported to JSON",
    object,

    {kind: object kind} merge(object cells)
  )

  supportsJson? = method(
    "Helper method that decides if given object can be expressed in JSON",
    object,
    if(object is?(Pair),
      JSON supportsJson?(object key) && JSON supportsJson?(object value),

      !["DefaultMethod", "DefaultMacro", "LexicalMacro", "LexicalBlock", "DefaultSyntax"] include?(object kind)
    )
  )
)

Origin toJson = method(
  "Returns JSON representation of the object",
  seen list,
  JSON encode(self, seen)
)

nil toJson = macro(
  "Returns JSON representation of the object",
  "null"
)

true toJson = macro(
  "Returns JSON representation of the object",
  "true"
)

false toJson = macro(
  "Returns JSON representation of the object",
  "false"
)

Symbol toJson = macro(
  "Returns JSON representation of the object",
  asText toJson
)

Number toJson = macro(
  "Returns JSON representation of the object",
  asText
)

Number Ratio toJson = macro(
  "Returns JSON representation of the object",
  (0.0 + self) asText
)

List toJson = macro(
  "Returns JSON representation of the object",
  "[%s]" % select(cell?(:toJson)) map(toJson) join(", ")
)

Dict toJson = method(
  "Returns JSON representation of the object",
  visitedItems list,
  availableItems = select(pair, JSON supportsJson?(pair))
  jsonisedItems = availableItems map(pair, "%s : %s" % list(pair key toJson, pair value toJson))
  "{%s}" % jsonisedItems join(", ")
)

Regexp toJson = macro(
  "Returns JSON representation of the object",
  inspect[1..-1]
)

DateTime toJson = macro(
  "Returns JSON representation of the object",
  asText
)
