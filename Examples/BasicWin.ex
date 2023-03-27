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
­14.58
