include raylib.e

constant NUM_FRAMES_PER_LINE = 5,
		 NUM_LINES = 5
		 
constant WIDTH = 800,
		 HEIGHT = 450
		 
InitWindow(WIDTH,HEIGHT,"Explosion - [Click Left Mouse Button to Play Explosion]")

InitAudioDevice()

sequence explosion = LoadTexture("explosion.png")
sequence fxBoom = LoadSound("boom.wav")

enum tex_id = 1,
	 tex_width,
	 tex_height,
	 tex_mipmaps,
	 tex_format

atom frameWidth = explosion[tex_width] / NUM_FRAMES_PER_LINE
atom frameHeight = explosion[tex_height] / NUM_LINES

integer currentFrame = 0
integer currentLine = 0

sequence frameRec = {0,0, frameWidth, frameHeight}
sequence pos = {0.0,0.0}

integer active = 0
integer framesCounter = 0

SetTargetFPS(120)

while not WindowShouldClose() do
	
	if IsMouseButtonPressed(MOUSE_BUTTON_LEFT) and active = 0 then
		pos = GetMousePosition()
		active = 1
		
		pos[1] -= frameWidth / 2.0
		pos[2] -= frameHeight / 2.0
		
		PlaySound(fxBoom)
	end if
	
	if active = 1 then
		framesCounter += 1
		
		if framesCounter > 2 then
			currentFrame += 1
			
			if currentFrame >= NUM_FRAMES_PER_LINE then
				currentFrame = 0
				currentLine += 1
				
				if currentLine >= NUM_LINES then
					currentLine = 0
					active = 0
				end if
			end if
			
			framesCounter = 0
		end if
	end if

	frameRec[1] = frameWidth * currentFrame
	frameRec[2] = frameHeight * currentLine
	
	BeginDrawing()
	
	ClearBackground(RAYWHITE)
	
	if active = 1 then
		DrawTextureRec(explosion,frameRec,pos,WHITE)
	end if

	EndDrawing()
end while

UnloadTexture(explosion)
UnloadSound(fxBoom)

CloseAudioDevice()
CloseWindow()
­10.80
