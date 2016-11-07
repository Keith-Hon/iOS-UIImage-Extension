# iOS-UIImage-Extension
An extension on iOS UIImage class to perform conversion between byte, float array.

# Extended functions
1. initWithBytes
  * Initiailize an UIImage object with a byte array, which can have either 3 or 4 components/ channels

  ```ruby
  -(id) initWithBytes:(unsigned char*) bytes image_height:(int)height image_width:(int) width numberOfComponents:(int) numberOfComponents releaseData:(bool) releaseData;
  ```

2. initWithFloats
  * Initiailize an UIImage object with a float array, which can have either 3 or 4 components/ channels

  ```ruby
 -(id) initWithFloats:(float*) data image_height:(int)height image_width:(int) width numberOfComponents:(int) numberOfComponents releaseData:(bool) releaseData;
  ```
