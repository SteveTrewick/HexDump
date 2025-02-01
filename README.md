# HexDump

Dump some hex, but from swift code. That's about it.

Sometimes you have a big bunch of otherwise inscrutable numbers that
would be more scrutable if you could just dump them to hex. 

This is not particularly great code, but I just really needed some hexies
and then I got sick of copypastaing this around so I made it a package.

You can customise the number of columns like `dump ( ..., width: 12)`.

You can get output suitable for pasting into an array like `dump (..., format: .array )`

You can feed it `Data` or `[UInt8]`

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


let hexies = hex.dump ( whut )

print( hexies )
/*

ea 01 00 00 01 00 00 00 08 00 00 00 06 00 00 00  ................
3c 3f 78 6d 6c 20 76 65 72 73 69 6f 6e 3d 22 31  <?xml.version="1
2e 30 22 20 65 6e 63 6f 64 69 6e 67 3d 22 55 54  .0".encoding="UT
46 2d 38 22 3f 3e 0a 3c 21 44 4f 43 54 59 50 45  F-8"?>.<!DOCTYPE
20 70 6c 69 73 74 20 50 55 42 4c 49 43 20 22 2d  .plist.PUBLIC."-
2f 2f 41 70 70 6c 65 2f 2f 44 54 44 20 50 4c 49  //Apple//DTD.PLI

*/


let arrayhexies = hex.dump (whut, format: .array )
print ( arrayhexies )

/*
0xea, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00,  ................
0x3c, 0x3f, 0x78, 0x6d, 0x6c, 0x20, 0x76, 0x65, 0x72, 0x73, 0x69, 0x6f, 0x6e, 0x3d, 0x22, 0x31,  <?xml.version="1
0x2e, 0x30, 0x22, 0x20, 0x65, 0x6e, 0x63, 0x6f, 0x64, 0x69, 0x6e, 0x67, 0x3d, 0x22, 0x55, 0x54,  .0".encoding="UT
0x46, 0x2d, 0x38, 0x22, 0x3f, 0x3e, 0x0a, 0x3c, 0x21, 0x44, 0x4f, 0x43, 0x54, 0x59, 0x50, 0x45,  F-8"?>.<!DOCTYPE
0x20, 0x70, 0x6c, 0x69, 0x73, 0x74, 0x20, 0x50, 0x55, 0x42, 0x4c, 0x49, 0x43, 0x20, 0x22, 0x2d,  .plist.PUBLIC."-
0x2f, 0x2f, 0x41, 0x70, 0x70, 0x6c, 0x65, 0x2f, 0x2f, 0x44, 0x54, 0x44, 0x20, 0x50, 0x4c, 0x49,  //Apple//DTD.PLI
*/
```

