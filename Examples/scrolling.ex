include std/ffi.e
include raylib.e

constant WIDTH = 800
constant HEIGHT = 450

InitWindow(WIDTH,HEIGHT,"Background scrolling")

enum back_id,
	 back_width,
	 back_height,
	 back_mipmaps,
	 back_format
	 
enum mid_id,
	 mid_width,
	 mid_height,
	 mid_mipmaps,
	 mid_format
	 
enum fore_id,
	 fore_width,
	 fore_height,
	 fore_mipmaps,
	 fore_format

sequence background = LoadTexture("cyberpunk_street_background.png")
sequence midground = LoadTexture("cyberpunk_street_midground.png")
sequence foreground = LoadTexture("cyberpunk_street_foreground.png")

atom scrollingBack = 0.0
atom scrollingMid = 0.0
atom scrollingFore = 0.0

SetTargetFPS(60)

while not WindowShouldClose() do

	scrollingBack -= 0.1
	scrollingMid -= 0.5
	scrollingFore -= 1.0
	
	if scrollingBack <= -background[back_width] * 2 then
		scrollingBack = 0
	end if
	
	if scrollingMid <= -midground[mid_width] * 2 then
		scrollingMid = 0
	end if
	
	if scrollingFore <= -foreground[fore_width] * 2 then
		scrollingFore = 0
	end if
	
	BeginDrawing()

	ClearBackground(GetColor(0x052c46ff))
	
	DrawTextureEx(background,{scrollingBack,20},0.0,2.0,WHITE)
	DrawTextureEx(background,{background[back_width] * 2 + scrollingBack,20},0.0,2.0,WHITE)
	
	DrawTextureEx(midground,{scrollingMid,20},0.0,2.0,WHITE)
	DrawTextureEx(midground,{midground[mid_width] * 2 + scrollingMid,20},0.0,2.0,WHITE)
	
	DrawTextureEx(foreground,{scrollingFore,70},0.0,2.0,WHITE)
	DrawTextureEx(foreground,{foreground[fore_width] * 2 + scrollingFore,70},0.0,2.0,WHITE)
	
	EndDrawing()
end while

UnloadTexture(background)
UnloadTexture(midground)
UnloadTexture(foreground)

CloseWindow()
­60.50