import Foundation


public struct HexDump {
  
  /*
    leaving this public so we can add/remove chars
    if we feel like it
  */
  public var unwanted : CharacterSet
  
  /*
    I can't believe we actually have to do this, but string will happily encode
    non printable chars as utf8 and I hate it
  */
  private let printables = UInt8(0x21)...UInt8(0x7e)
  
  public init() {
    unwanted = .whitespacesAndNewlines
    unwanted.remove(charactersIn: " ")  // keep spaces
    unwanted.insert(charactersIn: "\0") // ate nulls
  }
  
  func chunk(bytes:[UInt8], size: Int) -> [[UInt8]] {
    return stride(from: 0, to: bytes.count, by: size).map {
        Array(bytes[$0 ..< Swift.min($0 + size, bytes.count)])
    }
  }
  
  /*
   TODO: --
      make this work for BinaryInteger please, it will be a bit more involved, but
      hey, you can do it
   */
  public func dump (bytes: [UInt8], width: Int = 16 ) -> String {
    
    var hexdump : [String] = []
    
    for line in chunk(bytes: bytes, size: width) {
      
      // hexify
      var hexes = line.map { String(format: "%02x", $0) }
                      .joined(separator: " ")
      
      // pad.
      // each hex element takes up 2 chars plus a space
      hexes += String(repeating: " ", count: (width - line.count) * 3)
      
     
      let chars = line.map {
        
        guard printables.contains($0) else { return "." } // sigh
        
        guard // non UTF8 (which is'nt much as it tuens out)
          let char = String(bytes: [$0], encoding: .utf8),
              char.rangeOfCharacter(from: unwanted) == nil
        
        else { return  "." }
        
        
        return char
      }
      .joined(separator: "")

      
      
      hexdump += ["\(hexes)  \(chars)"]
    }
    
    return hexdump.joined(separator: "\n")
  }
}
