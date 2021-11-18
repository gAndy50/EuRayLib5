EuRayLib 4
Written by Andy P. (Icy_Viking)
Raylib Version: 4.0
Euphoria Version: 4.1.0 Beta 2

(c) EuRayLib 4 2021

Contact: g_andy <at> live.com
Paypal:paypal.me/IcyViking

ABOUT:

This is a wrapper of Raylib version 4 for the Euphoria programming language. It is a multimedia
library that can be used to make games. You'll need a good handling on the Euphoria programming
language to use this wrapper sucessfully. This wrapper uses the Visual Studio 32-bit build of the
Raylib DLL. Some examples are included to help you use this wrapper.

NOTE: In Raylib color values are assigned a unsigned char value. However to get this to work in
Euphoria, in the wrapper, they are declared as a unsigned integer. You can use byes_to_int()
for color values, for example:

byes_to_init({255,0,0,255}) - This will give you the color red. 

The basic colors in Raylib have been pre-assigned in the wrapper using this method. 

LICENSE:

This software is provided as-is. There is no warranty for this software. You use this software at
your own risk. You may not hold the author/developer or Euphoria community responsible for any
wrong-doing while using this software. You may use this wrapper to make Euphoria based programs
that use Raylib. Programs you create with this wrapper are yours to distribute as you please. You
may not claim you wrote the original EuRayLib4 wrapper. 

Thanks for using EuRayLib4!