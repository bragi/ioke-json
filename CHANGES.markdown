# Version Information for ioke-json

## Version 1.0.2 - 2009-06-05

Fixed issue where de-serialization modified kinds instead of their mimics.

## Version 1.0.1 - 2009-05-27

Uses init.ik file to initialize JSON library after use()ing jar file. No manual extension registration necessary.

## Version 1.0 - 2009-05-22

Initial version, beta quality software, alpha quality package. Supports:

* serialization of basic Ioke data types (excluding code)
* serialization of Origin mimics
* de-serialization of serialized types

**WARNING**

Uses Ioke evaluation to de-serialization and thus should only be used for trusted content.
