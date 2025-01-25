# HexDump

Dump some hex, but from swift code. That's about it.

Sometimes you have a big bunch of otherwise inscrutable numbers that
would be more scrutable if you could just dump them to hex. 

This is not particularly great code, but I just really needed some hexies
and then I got sick of copypastaing this around so I made it a package.

You can customise the number of columns like dump ( bytes:..., width: 12).

```swift
import Foundation
import HexDump

let hex = HexDump()

/*
  Packet from network or simmilar nonsense
*/
let whut : [UInt8] = [
  234, 1, 0, 0, 1, 0, 0, 0, 8, 0, 0, 0, 6, 0, 0, 0, 60, 63, 120, 109, 108, 32, 118,
  101, 114, 115, 105, 111, 110, 61,
  34, 49, 46, 48, 34, 32, 101, 110, 99, 111, 100, 105, 110, 103, 61, 34, 85, 84, 70, 45,
  56, 34, 63, 62, 10, 60, 33, 68, 79, 67, 84, 89, 80, 69, 32,
  112, 108, 105, 115, 116, 32, 80, 85, 66, 76, 73, 67, 32, 34, 45, 47, 47,
  65, 112, 112, 108, 101, 47, 47, 68, 84, 68, 32, 80, 76, 73
]

let hexies = hex.dump(bytes: whut)

print(hexies)
/*

ea 01 00 00 01 00 00 00 08 00 00 00 06 00 00 00  ................
3c 3f 78 6d 6c 20 76 65 72 73 69 6f 6e 3d 22 31  <?xml.version="1
2e 30 22 20 65 6e 63 6f 64 69 6e 67 3d 22 55 54  .0".encoding="UT
46 2d 38 22 3f 3e 0a 3c 21 44 4f 43 54 59 50 45  F-8"?>.<!DOCTYPE
20 70 6c 69 73 74 20 50 55 42 4c 49 43 20 22 2d  .plist.PUBLIC."-
2f 2f 41 70 70 6c 65 2f 2f 44 54 44 20 50 4c 49  //Apple//DTD.PLI

*/
```

