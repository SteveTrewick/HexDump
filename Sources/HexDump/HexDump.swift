import Foundation



public func memhex<T: BinaryInteger>(_ value: T) -> String {
  
  var value = value
  var hex = ""
  
  withUnsafeBytes(of: &value) { bytes in
    for byte in bytes {
      hex += String(format:"%02x", byte) + " "
    }
  }
  return hex
}


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
  
  
  public enum Format {
    case regular, array
  }
  
  /*
   TODO: --
      make this work for BinaryInteger please, it will be a bit more involved, but
      hey, you can do it
   */
  
  public func dump (_ data: Data, format: Format = .regular, width: Int = 16) -> String {
    dump ( Array(data), format: format , width: width )
  }
  
  public func dump (_ bytes: [UInt8], format: Format = .regular, width: Int = 16 ) -> String {
    
    var pad = 3
    
    switch format {
      case .regular: break
      case .array  : pad += 3  // 0x ,
    }
    
    var hexdump : [String] = []
    
    for line in chunk(bytes: bytes, size: width) {
      
      
      
      
      // hexify
      var hexes = line.map {
        if case .array = format {
          return "0x" + String(format: "%02x", $0) + ","
        }
        else {
          return String(format: "%02x", $0)
        }
      }
      .joined(separator: " ")
      
      // pad.
      hexes += String(repeating: " ", count: (width - line.count) * pad)
      
     
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
