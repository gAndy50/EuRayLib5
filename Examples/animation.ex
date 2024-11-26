include std/ffi.e
include raylib.e

constant MAX_FRAME_SPEED = 15
constant MIN_FRAME_SPEED = 1

constant WIDTH = 800
constant HEIGHT = 450

public enum tex_id,
	 tex_width,
	 tex_height,
	 tex_mipmaps,
	 tex_format

InitWindow(WIDTH,HEIGHT,"Sprite Animation")

sequence scarfy = LoadTexture("scarfy.png")

sequence pos = {350.0,280.0}
sequence frameRec = {0.0, 0.0, scarfy[tex_width] / 6, scarfy[tex_height]}

integer currentFrame = 0

integer framesCounter = 0
integer framesSpeed = 8

SetTargetFPS(60)

while not WindowShouldClose() do
	framesCounter += 1
	
	if framesCounter >= 60 / framesSpeed then
		framesCounter = 0
		currentFrame += 1
		
		if currentFrame > 5 then
			currentFrame = 0
		end if
		
		frameRec[1] = currentFrame * scarfy[tex_width] / 6
	end if
	
	if IsKeyPressed(KEY_RIGHT) then
		framesSpeed += 1
		elsif IsKeyPressed(KEY_LEFT) then
			framesSpeed -= 1
	end if
	
	if framesSpeed > MAX_FRAME_SPEED then
		framesSpeed = MAX_FRAME_SPEED
		elsif framesSpeed < MIN_FRAME_SPEED then
			framesSpeed = MIN_FRAME_SPEED
	end if
	
	BeginDrawing()
	
	ClearBackground(RAYWHITE)
	
	DrawTexture(scarfy,15,40,WHITE)
	DrawRectangleLines(15,40,scarfy[tex_width],scarfy[tex_height],LIME)
	DrawRectangleLines(15 + frameRec[1],40 + frameRec[2], frameRec[3], frameRec[4], RED)
	
	for i = 1 to MAX_FRAME_SPEED do
		if i < framesSpeed then
			DrawRectangle(250 + 21 * i, 205,20,20,RED)
			DrawRectangleLines(250 + 21 * i,205,20,20,MAROON)
		end if
	end for
	
	DrawTextureRec(scarfy,frameRec,pos,WHITE)
	
	EndDrawing()
end while

UnloadTexture(scarfy)

CloseWindow()
­76.21