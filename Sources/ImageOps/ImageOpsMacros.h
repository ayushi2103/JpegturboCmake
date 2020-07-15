
#ifndef ImageOps_Macros_h
#define ImageOps_Macros_h

#if defined(__ELF__) || defined(__MACH__) || defined(__WASM__)
  #if defined(ImageOps_EXPORTS)
    #define ImageOps_ABI __attribute__((__visibility__("default")))
  #else
    #define ImageOps_ABI __attribute__((__visibility__("default")))
  #endif
#else // assume PE/COFF
  #if defined(ImageOps_EXPORTS)
    #define ImageOps_ABI __declspec(dllexport)
  #else
    #define ImageOps_ABI __declspec(dllimport)
  #endif
#endif

#endif
