ioke-json provides serialization and de-serialization to JSON for Ioke  objects.

## Important

This is a proof of concept implementation. It **evaluates JSON code as Ioke code which is DANGEROUS** and should be used to parse trusted content only.

## Requirements

* Supports ikj only.
* Needs following patches to Ioke: http://github.com/bragi/ioke/tree/java_based_extensions, http://github.com/bragi/ioke/tree/dict_removeAt,
http://github.com/bragi/ioke/tree/use_from_jar_file

## Building

Clone the repository in the same directory where you have ioke installed:

    git clone git://github.com/bragi/ioke-json.git

You should have following directory structure:

    ioke/
      bin/
      build/
      ...
    ioke-json/
      lib/
      src/
      ...

Run ant:

    ant

Extension will be built in ioke-json/lib/ioke-json-1.0.1.jar

## Usage

Put ioke-json-1.0.1.jar in you load path. In you .ik file do:

    use("ioke-json-1.0.1.jar")

Then following works:

    true toJson # => "true"
    "json" toJson # => "\"json\""
    {0 => 1, "a" => "b"} toJson # => "{0 : 1, \"a\" : \"b\"}"
    Origin mimic toJson # => "{\"kind\" : \"Origin\"}"

De-serialization is supported as well:

    JSON fromText("[]") # => list
    JSON fromText("{}") # =>  dict
    JSON fromText("{\"kind\" : \"Origin\"}") # => "Origin"

**Note** that when JavaScript hash has the key "kind" then it will be treated as serialized Ioke object and will be de-serialized to proper mimic rather than dict

## Kudos

Thanks to Martin Elwin for creating to evaluation-based JSON parser: http://martin.elwin.com/blog/2009/01/simple-json-parser-in-ioke/

## Version

Current version is 1.0.1 released on 2009-05-27. See CHANGES.markdown for details.
