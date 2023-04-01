include raylib.e

constant WIDTH = 800,
		 HEIGHT = 450
		 
InitWindow(WIDTH,HEIGHT,"Simple Texture")

sequence tex = LoadTexture("raylib_128x128.png")

enum tex_id = 1,
	 tex_width,
	 tex_height,
	 tex_mipmaps,
	 tex_format

while not WindowShouldClose() do
	BeginDrawing()
	ClearBackground(RAYWHITE)
	DrawTexture(tex,WIDTH / 2 - tex[tex_width] / 2, HEIGHT / 2 - tex[tex_height] / 2, WHITE)
	EndDrawing()
end while

UnloadTexture(tex)

CloseWindow()
