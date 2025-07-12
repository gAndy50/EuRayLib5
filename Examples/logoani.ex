include raylib.e

constant screenWidth = 800,
         screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [shapes] example - raylib logo animation")

integer logoPositionX = screenWidth / 2 - 128
integer logoPositionY = screenHeight / 2 - 128

integer framesCounter = 0,
        lettersCount = 0

integer topSideRecWidth = 16,
        leftSideRecHeight = 16

integer bottomSideRecWidth = 16,
        rightSideRecHeight = 16

integer state = 0
atom alpha = 1.0

SetTargetFPS(60)

while not WindowShouldClose() do
    -- Update
    if state = 0 then
        framesCounter += 1
        if framesCounter = 120 then
            state = 1
            framesCounter = 0
        end if

    elsif state = 1 then
        topSideRecWidth += 4
        leftSideRecHeight += 4
        if topSideRecWidth >= 256 then
            state = 2
        end if

    elsif state = 2 then
        bottomSideRecWidth += 4
        rightSideRecHeight += 4
        if bottomSideRecWidth >= 256 then
            state = 3
        end if

    elsif state = 3 then
        framesCounter += 1
        if remainder(framesCounter, 12) = 0 and lettersCount < 10 then
            lettersCount += 1
        end if

        if lettersCount >= 10 then
            alpha -= 0.02
            if alpha <= 0.0 then
                alpha = 0.0
                state = 4
            end if
        end if

    elsif state = 4 then
        if IsKeyPressed(KEY_R) then
            framesCounter = 0
            lettersCount = 0
            topSideRecWidth = 16
            leftSideRecHeight = 16
            bottomSideRecWidth = 16
            rightSideRecHeight = 16
            alpha = 1.0
            state = 0
        end if
    end if

    -- Draw
    BeginDrawing()
    ClearBackground(RAYWHITE)

    if state = 0 then
        if remainder(framesCounter, 30) < 15 then
            DrawRectangle(logoPositionX, logoPositionY, 16, 16, BLACK)
        end if

    elsif state = 1 then
        DrawRectangle(logoPositionX, logoPositionY, topSideRecWidth, 16, BLACK)
        DrawRectangle(logoPositionX, logoPositionY, 16, leftSideRecHeight, BLACK)

    elsif state = 2 then
        DrawRectangle(logoPositionX, logoPositionY, topSideRecWidth, 16, BLACK)
        DrawRectangle(logoPositionX, logoPositionY, 16, leftSideRecHeight, BLACK)
        DrawRectangle(logoPositionX + 240, logoPositionY, 16, rightSideRecHeight, BLACK)
        DrawRectangle(logoPositionX, logoPositionY + 240, bottomSideRecWidth, 16, BLACK)

    elsif state = 3 then
        DrawRectangle(logoPositionX, logoPositionY, topSideRecWidth, 16, Fade(BLACK, alpha))
        DrawRectangle(logoPositionX, logoPositionY + 16, 16, leftSideRecHeight - 32, Fade(BLACK, alpha))
        DrawRectangle(logoPositionX + 240, logoPositionY + 16, 16, rightSideRecHeight - 32, Fade(BLACK, alpha))
        DrawRectangle(logoPositionX, logoPositionY + 240, bottomSideRecWidth, 16, Fade(BLACK, alpha))

        DrawRectangle(screenWidth / 2 - 112, screenHeight / 2 - 112, 224, 224, Fade(RAYWHITE, alpha))

        DrawText(TextSubtext("Raylib Logo Animation", 0, lettersCount), screenWidth / 2 - 44, screenHeight / 2 + 48, 50, Fade(BLACK, alpha))

    elsif state = 4 then
        DrawText("[R] REPLAY", 340, 200, 20, GRAY)
    end if

    EndDrawing()
end while

CloseWindow()
­102.31