
use("ispec")
use("ioke-json-latest.jar")

describe(true, 
  it("should have JSON representation",
    true toJson should == "true"
  )
)

describe(false, 
  it("should have JSON representation",
    false toJson should == "false"
  )
)

describe(nil, 
  it("should have JSON representation",
    nil toJson should == "null"
  )
)

describe(Regexp,
  it("should have JSON representation",
    #/.*/ toJson should == "/.*/"
  )
)

describe(Symbol,
  it("should have json representation",
    :json toJson should == "\"json\""
  )
)

describe(Text,
  it("should have json representation",
    "json" toJson should == "\"json\""
  )
)

describe(Number,
  it("should have JSON representation",
    0 toJson should == "0"
  )
)

describe(Number Ratio,
  it("should have JSON representation",
    (1/2) toJson should == "0.5"
  )
)  

describe(Number Real,
  it("should have JSON representation",
    0.5 toJson should == "0.5"
  )
)

describe(List,
  it("has JSON representation of empty List",
    [] toJson should = "[]"
  )

  it("calls toJson on each element and concatenates them with comma",
    obj = Origin with(toJson: "foo")
    [1, (1/2), 0.5, 4, obj] toJson should == "[1, 0.5, 0.5, 4, foo]"
  )

  it("ignores items that do not have JSON representation",
    obj = Origin mimic
    obj undefineCell!(:toJson)
    [obj] toJson should == "[]"
  )
)

describe(Dict,
  it("should have JSON representation of empty dict",
    {} toJson should == "{}"
  )
  
  it("should have JSON representation",
    {"a" => "b", 0 => 1} toJson should == "{\"a\" : \"b\", 0 : 1}"
  )

  it("calls toJson on each key and value",
    key = Origin with(toJson: "key")
    value = Origin with(toJson: "value")
    {key => value} toJson should == "{key : value}"
  )
)

describe(Origin,
  it("should have JSON representation",
    Origin mimic toJson should == "{\"kind\" : \"Origin\"}"
  )
)

describe(DateTime,
  it("should have JSON representation",
    date = DateTime now
    date toJson should == date asText
  )
)

describe(JSON,
  describe("fromIoke",
    it("should create an empty list",
      JSON fromIoke([]) should == list
    )
    
    it("should create an empty dict",
      JSON fromIoke({}) should == dict
    )
  )

  describe("fromText",
    it("should create an empty list",
      JSON fromText("[]") should == list
    )

    it("should create an empty dict",
      JSON fromText("{}") should == dict
    )

    it("should not create Origin",
      JSON fromText("{\"kind\" : \"Origin\"}") should == dict("kind" => "Origin")
    )
  )
)