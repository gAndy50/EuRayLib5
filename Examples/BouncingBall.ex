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
­58.14
