Raylib 4.5 Euphoria Wrapper
Written by Andy P. (Icy_Viking)
Raylib Version: 4.5
Euphoria Version: 4.1.0 Beta 2

(c) EuRayLib 4 2023

Contact: g_andy <at> live.com
Paypal:paypal.me/IcyViking

ABOUT:

This is a wrapper of Raylib version 4.5 for the Euphoria programming language. It is a multimedia
library that can be used to make games. You'll need a good handling on the Euphoria programming
language to use this wrapper sucessfully. This wrapper uses the Visual Studio 32-bit build of the
Raylib DLL. Some examples are included to help you use this wrapper.

This uses the new FFI library for handling structs. 

EXAMPLE:

include raylib.e

constant Width = 800
constant Height = 600

InitWindow(Width,Height,"Simple Window")

SetTargetFPS(60)

while not WindowShouldClose() do
	BeginDrawing()
	
	ClearBackground(BLACK)
	DrawText("Simple Window Program",Width /2.5, Height /2.5 ,20,YELLOW)
	
	EndDrawing()
end while

CloseWindow()

LICENSE:

This software is provided as-is. There is no warranty for this software. You use this software at
your own risk. You may not hold the author/developer or Euphoria community responsible for any
wrong-doing while using this software. You may use this wrapper to make Euphoria based programs
that use Raylib. Programs you create with this wrapper are yours to distribute as you please. You
may not claim you wrote the original EuRayLib4 wrapper. 

Thanks for using EuRayLib4!
