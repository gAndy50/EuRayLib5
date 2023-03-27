include raylib.e

constant Width = 800
constant Height = 600

InitWindow(Width,Height,"Simple Input")

enum x,y --x and y pos of ball
sequence ballPos = {Width / 2, Height / 2}
atom ballRad = 30

SetTargetFPS(60)

while not WindowShouldClose() do

	if IsKeyDown(KEY_RIGHT) then
		ballPos[x] += 2.0
	end if	
	if IsKeyDown(KEY_LEFT) then
		ballPos[x] -= 2.0
	end if
	
	if IsKeyDown(KEY_UP) then
		ballPos[y] -= 2.0
	end if
	if IsKeyDown(KEY_DOWN) then
		ballPos[y] += 2.0
	end if
	
	--Check screen bounds
	--[1] is x pos, [2] is y pos
	if ballPos[x] - ballRad <= 0 then
		ballPos[x] *= 1.5
		elsif ballPos[x] + ballRad > GetScreenWidth() then
			ballPos[x] -= 2.0
	end if
	
	if ballPos[y] - ballRad <= 0 then
		ballPos[y] += 2.0
		elsif ballPos[y] + ballRad > GetScreenHeight() then
			ballPos[y] -= 2.0
	end if

	BeginDrawing()
	
	ClearBackground(BLACK)
	DrawText("Move Ball with arrow keys",10,10,ballRad,YELLOW)
	
	DrawCircleV(ballPos,ballRad,RED)

	EndDrawing()
end while

CloseWindow()
­8.30