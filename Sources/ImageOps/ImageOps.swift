
import Foundation
import TurboJPEG

public func tjJPEGLoadCompressedImage( filename: UnsafePointer<Int8>?, width: inout Int32, align: inout Int32,  height: inout Int32, pixelFormat: inout Int32, inSubsamp: Int32, flags: Int) -> UnsafeMutablePointer<UInt8>? {
  
    pixelFormat = -1
 
    /* Read the JPEG file into memory. */
    var jpegFile = fopen(filename, "rb")
    fseek(jpegFile, 0, SEEK_END)
    let size = ftell(jpegFile)
    fseek(jpegFile, 0, SEEK_SET)
    let jpegSize = CUnsignedLongLong(size)
    var jpegBuf = (tjAlloc(Int32(jpegSize)))
    fread(jpegBuf, Int(jpegSize), 1, jpegFile)
    fclose(jpegFile)
    jpegFile = nil
    
    var tjInstance = tjInitDecompress()
    tjDecompressHeader(tjInstance, jpegBuf, UInt(jpegSize), &width, &height)
    
    let imgBuf = tjAlloc(3 * width * height)
    tjDecompress2(tjInstance, jpegBuf, UInt(jpegSize), imgBuf, width, 0, height, 0, 0)
    tjFree(jpegBuf)
    jpegBuf = nil
    tjDestroy(tjInstance)
    tjInstance = nil
    
    return imgBuf
}


public func tjJPEGSaveImage(filename: UnsafePointer<Int8>?, buffer: UnsafePointer<UInt8>?, width: Int32, pitch: Int32, height: Int32, pixelFormat: Int32, outSubsamp: Int32, flags: Int32) -> Int32 {
    
    var jpegFile = fopen(filename, "wb")
    var jpegBuf: UnsafeMutablePointer<UInt8>?
    
    var retVal: Int32 = -1
    let outQual: Int32 = 95
    var jpegSize: CUnsignedLong = 0
    
    var tjInstance = tjInitCompress();
    tjCompress2(tjInstance, buffer, width, 0, height, pixelFormat, &jpegBuf, &jpegSize, outSubsamp, outQual, flags)
    tjDestroy(tjInstance)
    tjInstance = nil
    
    if (fwrite(jpegBuf, Int(jpegSize), 1, jpegFile) == 1){
        retVal = 0
        
    }
    tjDestroy(tjInstance)
    tjInstance = nil
    fclose(jpegFile)
    jpegFile = nil
    tjFree(jpegBuf)
    jpegBuf = nil
    
    return retVal;
    
}
