include raylib.e

constant SCREEN_WIDTH = 800
constant SCREEN_HEIGHT = 600
constant NUM_LINKS = 10
constant LINK_LENGTH = 30.0
constant GRAVITY = 980.0    -- pixels/s^2
constant TIME_STEP = 1.0 / 60.0
constant DAMPING = 0.99     -- velocity damping to reduce oscillation

-- Each link holds current and previous position for verlet integration
object positions = repeat({0.0, 0.0}, NUM_LINKS)
object prev_positions = repeat({0.0, 0.0}, NUM_LINKS)

-- Initialize chain positions vertically hanging from pivot
constant PIVOT = {SCREEN_WIDTH/2, 100.0}
for i = 1 to NUM_LINKS do
    positions[i] = {PIVOT[1], PIVOT[2] + (i-1) * LINK_LENGTH}
    prev_positions[i] = positions[i]
end for

InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Chain Swinging in Euphoria + raylib")
SetTargetFPS(60)

procedure applyGravity()
    for i = 2 to NUM_LINKS do
        -- Verlet velocity = current - previous
        object velocity = positions[i] - prev_positions[i]

        -- Save current position before update
        prev_positions[i] = positions[i]

        -- Update position with velocity and gravity
        positions[i][1] += velocity[1] * DAMPING
        positions[i][2] += velocity[2] * DAMPING + GRAVITY * TIME_STEP * TIME_STEP
    end for
end procedure

procedure applyConstraints()
    -- The first link is fixed at the pivot
    positions[1] = PIVOT

    for iter = 1 to 5 do  -- iterate constraints multiple times for stability
        for i = 1 to NUM_LINKS - 1 do
            object p1 = positions[i]
            object p2 = positions[i+1]

            -- Calculate vector between links
            object delta = p2 - p1
            object delta_length = sqrt(power(delta[1],2) + power(delta[2],2))
            object diff = (delta_length - LINK_LENGTH) / delta_length

            -- Move points to satisfy constraint (fixed first link, so move only second)
            if i = 1 then
                -- Move only p2
                positions[i+1] = p2 - delta * diff
            else
                -- Move both points equally
                positions[i] = p1 + delta * 0.5 * diff
                positions[i+1] = p2 - delta * 0.5 * diff
            end if
        end for
    end for
end procedure

procedure drawChain()
    for i = 1 to NUM_LINKS do
        DrawCircle(positions[i][1], positions[i][2], 8, BLUE)
        if i < NUM_LINKS then
            DrawLine(positions[i][1], positions[i][2],
                     positions[i+1][1], positions[i+1][2], BLACK)
        end if
    end for
end procedure

while not WindowShouldClose() do

	if IsKeyDown(KEY_RIGHT) then
		positions[NUM_LINKS][1] += 5
		elsif IsKeyDown(KEY_LEFT) then
			positions[NUM_LINKS][1] -= 5
	end if
	
    applyGravity()
    applyConstraints()

    BeginDrawing()
        ClearBackground(RAYWHITE)
        drawChain()
        DrawText("Chain swinging physics with verlet integration", 10, 10, 20, DARKGRAY)
    EndDrawing()
end while

CloseWindow()
­80.6