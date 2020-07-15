
#ifndef ImageOps_Version_h
#define ImageOps_Version_h

#include "ImageOpsMacros.h"

unsigned char* tjJPEGSaveImage(unsigned char *buffer,
                                         int width, int pitch, int height, int pixelFormat, int outSubsamp,
                                         int flags);
 
unsigned char* tjJPEGLoadCompressedImage(const char *filename, int *width,
                                                   int align, int *height, int *pixelFormat, int *inSubsamp,
                                                   int flags);

#endif
