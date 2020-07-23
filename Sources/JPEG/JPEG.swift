import Foundation
import ImageOps

let numScalingFactors = 0;

let path = "/Users/ayushitiwari/Downloads/Dog.jpg"
let url = (path as NSString).utf8String
let filenamepointer = UnsafeMutablePointer<Int8>(mutating: url)!

func testing() {
    
    var width: Int32 = 0
    var align: Int32 = 0
    var height: Int32 = 0
    var pixelFormat: Int32 = 0
    let inSubsamp: Int32 = 0
    
    let imgBuffer = tjJPEGLoadCompressedImage(filename: filenamepointer, width: &width, align: &align, height: &height, pixelFormat: &pixelFormat, inSubsamp: inSubsamp, flags: 0)
    print(width)
    print(align)
    print(height)
    print(pixelFormat)
    print(inSubsamp)
    
    let path2 = "/Users/ayushitiwari/Downloads/DogNEWCMAKE.jpg"
    let url2 = (path2 as NSString).utf8String
    let filenamepointer2 = UnsafeMutablePointer<Int8>(mutating: url2)!
    
    let retVal = tjJPEGSaveImage(filename: filenamepointer2, buffer: imgBuffer, width: width, pitch: 0, height: height, pixelFormat: 0, outSubsamp: inSubsamp, flags: 0)
    print(retVal)
}

testing()
