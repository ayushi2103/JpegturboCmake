import Foundation
import HelloWorldCore

func test() {
   print("Hello, World!")

   let path = "/Users/ayushitiwari/Downloads/tiger.jpg"
   let url = (path as NSString).utf8String
   let _ = UnsafeMutablePointer<Int8>(mutating: url)!

   var width: Int32 = 0
    var height: Int32 = 0
    var pixelFormat: Int32 = 0
    var inSubsamp: Int32 = 0

    var _ = tjJPEGLoadCompressedImage(path, &width, 0, &height, &pixelFormat, &inSubsamp, 0)
    print(width)
    print(height)
    print(pixelFormat)
    print(inSubsamp)
}

test()
