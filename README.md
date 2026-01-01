# Raylib 5.0 Euphoria Wrapper

Written by Andy P. (Icy_Viking)
Raylib Version: 5.5
Euphoria Version: 4.1.0 Beta 2

(c) EuRayLib 5 2026

Contact: g_andy <at> live.com
Paypal:paypal.me/IcyViking

# ABOUT

This is a wrapper of Raylib version 5.5 for the Euphoria programming language. It is a multimedia
library that can be used to make games. You'll need a good handling on the Euphoria programming
language to use this wrapper sucessfully. This wrapper uses the Visual Studio 32-bit build of the
Raylib DLL. Some examples are included to help you use this wrapper.

This uses the new FFI library for handling structs. 

# LICENSE

This software is provided as-is. There is no warranty for this software. You use this software at
your own risk. You may not hold the author/developer or Euphoria community responsible for any
wrong-doing while using this software. You may use this wrapper to make Euphoria based programs
that use Raylib. Programs you create with this wrapper are yours to distribute as you please. You
may not claim you wrote the original EuRayLib5 wrapper. 

# EXAMPLE
``` euphoria
--Bouncing ball example
include raylib.e

 atom width = 800
atom height = 600

 InitWindow(width,height,"Bouncing Ball")
 
 sequence ballPos = {GetScreenWidth() / 2.0, GetScreenHeight() / 2.0}
 sequence ballSpeed = {5.0, 4.0}
 atom ballRadius = 20.0
 
 integer paused = 0
 integer framesCount = 0
 
 SetTargetFPS(60)
 
 while not WindowShouldClose() do
 
 if IsKeyPressed(KEY_SPACE) and paused = 0  then
 	paused = 1
 	elsif IsKeyPressed(KEY_SPACE) and paused = 1 then
 		paused = 0
 end if
 
 if paused = 0 then
 
 	ballPos[1] += ballSpeed[1] --[1] is x
 	ballPos[2] += ballSpeed[2] --[2] is y
 	

	if ballPos[1] >= GetScreenWidth() - ballRadius or ballPos[1] <= ballRadius then
		ballSpeed[1] *= -1.0

	elsif ballPos[2] >= GetScreenHeight() - ballRadius or ballPos[2] <= ballRadius then
		ballSpeed[2] *= -1.0

	else
		framesCount += 1
	end if
 end if
 
 BeginDrawing()
 
 ClearBackground(RAYWHITE)
 
 DrawCircleV(ballPos,ballRadius,MAROON)
 
 DrawFPS(1,1)
 
 if paused = 1 then
 	DrawText("Paused",GetScreenWidth() / 2,GetScreenHeight() / 2,50,LIGHTGRAY)
 end if
 
 EndDrawing()
 	
 end while
 
 CloseWindow()
```

Thanks for using EuRayLib5!

