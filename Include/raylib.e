-------------------------------------------
--Euraylib 
--Written by Andy P. 
--Copyright (c) 2024
--Wrapper of Raylib 5.5 for OpenEuphoria
--OpenEuphoria v. 4.1.0 Beta 2
-------------------------------------------
include std/ffi.e
include std/machine.e
include std/os.e

--Load the shared library
public atom ray 

ifdef WINDOWS then
	ray = open_dll("raylib.dll")
	elsifdef LINUX or FREEBSD then
	ray = open_dll("libraylib.so")
	elsifdef OSX then
	ray = open_dll("libraylib.dylib")
end ifdef

if ray = 0 then
	puts(1,"Unable to load Raylib!\n")
	abort(0)
end if

--Raylib Version
public constant RAYLIB_VERSION_MAJOR = 5
public constant RAYLIB_VERSION_MINOR = 5
public constant RAYLIB_VERSION_PATCH = 0
public constant RAYLIB_VERSION = "5.5"

--Basic Defines
public constant PI = 3.14159265358979323846

ifdef DEG2RAD then
	public constant DEG2RAD = PI / 180.0
end ifdef

ifdef RAD2DEG then
	public constant RAD2DEG = 180.0 / PI
end ifdef

--Colors
public constant LIGHTGRAY = {200,200,200,255},
				GRAY      = {130,130,130,255},
				DARKGRAY  = {80,80,80,255},
				YELLOW    = {253,249,9,255},
				GOLD      = {255,203,0,255},
				ORANGE	  = {255,161,0,255},
				PINK	  = {255,109,194,255},
				RED 	  = {230,41,55,255},
				MAROON 	  = {190,33,55,255},
				GREEN 	  = {0,228,48,255},
				LIME	  = {0,158,47,255},
				DARKGREEN = {0,117,44,255},
				SKYBLUE	  = {102,191,255,255},
				BLUE	  = {0,121,241,255},
				DARKBLUE  = {0,82,172,255},
				PURPLE	  = {200,122,255,255},
				VIOLET	  = {135,60,190,255},
				DARKPURPLE = {112,31,126,255},
				BEIGE	  = {211,176,131,255},
				BROWN	  = {127,106,79,255},
				DARKBROWN = {76,63,47,255}
				
public constant WHITE = {255,255,255,255},
				BLACK = {0,0,0,255},
				MAGENTA = {255,0,255,255},
				RAYWHITE = {245,245,245,255}
				
--Structs

public constant Vector2 = define_c_struct({
	C_FLOAT, --x [1]
	C_FLOAT  --y [2]
})

public constant Vector3 = define_c_struct({
	C_FLOAT, --x [1]
	C_FLOAT, --y [2]
	C_FLOAT  --z [3]
})

public constant Vector4 = define_c_struct({
	C_FLOAT, --x [1]
	C_FLOAT, --y [2]
	C_FLOAT, --z [3]
	C_FLOAT  --w [4]
})

public constant Quaternion = Vector4

public constant Matrix = define_c_struct({
	C_FLOAT, C_FLOAT, C_FLOAT, C_FLOAT, --m0,m4,m8,m12 [1][2][3][4]
	C_FLOAT, C_FLOAT, C_FLOAT, C_FLOAT, --m1,m5,m9,m13 [5][6][7][8]
	C_FLOAT, C_FLOAT, C_FLOAT, C_FLOAT, --m2,m6,m10,m14 [9][10][11][12]
	C_FLOAT, C_FLOAT, C_FLOAT, C_FLOAT  --m3,m7,m11,m15 [13][14][15][16]
})

public constant Color = define_c_struct({
	C_UCHAR, --r [1]
	C_UCHAR, --g [2]
	C_UCHAR, --b [3]
	C_UCHAR  --a [4]
})

public constant Rectangle = define_c_struct({
	C_FLOAT, --x [1]
	C_FLOAT, --y [2]
	C_FLOAT, --width [3]
	C_FLOAT  --height [4]
})

public constant Image = define_c_struct({
	C_POINTER, --data [1]
	C_INT, --width [2]
	C_INT, --height [3]
	C_INT, --mipmaps [4]
	C_INT  --format [5]
})

public constant Texture = define_c_struct({
	C_UINT, --id [1]
	C_INT, --width [2]
	C_INT, --height [3]
	C_INT, --mipmaps [4]
	C_INT  --format [5]
})

public constant Texture2D = Texture

public constant TextureCubemap = Texture

public constant RenderTexture = define_c_struct({
	C_UINT, --id [1]
	Texture, --texture [2]
	Texture --depth [3]
})

public constant RenderTexture2D = RenderTexture

public constant NPatchInfo = define_c_struct({
	Rectangle, --source [1]
	C_INT, --left [2]
	C_INT, --top [3]
	C_INT, --right [4]
	C_INT, --bottom [5]
	C_INT  --layout [6]
})

public constant GlyphInfo = define_c_struct({
	C_INT, --value [1]
	C_INT, --offsetX [2]
	C_INT, --offsetY [3]
	C_INT, --advanceX [4]
	Image  --image [5]
})

public constant Font = define_c_struct({
	C_INT, --baseSize [1]
	C_INT, --glyphCount [2]
	C_INT, --glyphPadding [3]
	Texture2D, --texture [4]
	C_POINTER, --recs [5]
	C_POINTER  --glyphs [6]
})

public constant Camera3D = define_c_struct({
	Vector3, --position [1][2][3]
	Vector3, --target [4][5][6]
	Vector3, --up [7][8][9]
	C_FLOAT, --fovy [10]
	C_INT   --projection [11]
})

public constant Camera = Camera3D

public constant Camera2D = define_c_struct({
	Vector2, --offset [1][2]
	Vector2, --target [3][4]
	C_FLOAT, --rotation [5]
	C_FLOAT  --zoom [6]
})

public constant Mesh = define_c_struct({
	C_INT, --vertexCount [1]
	C_INT, --triangleCount [2]
	
	--Vertex attributes data
	C_POINTER, --vertices [3]
	C_POINTER, --texcoords [4]
	C_POINTER, --texcoords2 [5]
	C_POINTER, --normals [6]
	C_POINTER, --tangents [7]
	C_POINTER, --colors [8]
	C_POINTER, --indices [9]
	
	--Animation vertex data
	C_POINTER, --animVertices [10]
	C_POINTER, --animNormals [11]
	C_POINTER, --boneIds [12]
	C_POINTER, --boneWeights [13]
	C_POINTER, --boneMatrices [14]
	C_INT,	   --boneCount [15]
	
	--OpenGL identifiers
	C_UINT, --vaoId [16]
	C_POINTER --vboId [17]
})

public constant Shader = define_c_struct({
	C_UINT, --id [1]
	C_POINTER --locs [2]
})

public constant MaterialMap = define_c_struct({
	Texture2D, --texture 
	Color,     --color
	C_FLOAT    --value
})

public constant Material = define_c_struct({
	Shader, --shader
	C_POINTER, --maps --MaterialMaps
	{C_FLOAT, 4} --params[4]
})

public constant Transform = define_c_struct({
	Vector3, --translation
	Quaternion, --rotation
	Vector3    --scale
})

public constant BoneInfo = define_c_struct({
	{C_CHAR,32}, --name[32]
	C_INT        --parent
})

public constant Model = define_c_struct({
	Matrix, --transform
	C_INT, --meshCount
	C_INT, --materialCount
	C_POINTER, --meshes
	C_POINTER, --materials
	C_POINTER, --meshMaterial
	C_INT, --boneCount
	C_POINTER, --bones
	C_POINTER --bindPose
})

public constant ModelAnimation = define_c_struct({
	C_INT, --boneCount
	C_INT, --frameCount
	C_POINTER, --bones
	C_POINTER, --framePoses
	{C_CHAR,32} --name[32]
})

public constant Ray = define_c_struct({
	Vector3, --position
	Vector3  --direction
})

public constant RayCollision = define_c_struct({
	C_BOOL, --hit
	C_FLOAT, --distance
	Vector3, --point
	Vector3  --normal
})

public constant BoundingBox = define_c_struct({
	Vector3, --min
	Vector3  --max
})

public constant Wave = define_c_struct({
	C_UINT, --frameCount
	C_UINT, --sampleRate
	C_UINT, --sampleSize
	C_UINT, --channels
	C_POINTER --data
})

public constant AudioStream = define_c_struct({
	C_POINTER, --buffer
	C_POINTER, --processor
	C_UINT, --sampleRate
	C_UINT, --sampleSize
	C_UINT --channels
})

public constant Sound = define_c_struct({
	AudioStream, --stream
	C_UINT --frameCount
})

public constant Music = define_c_struct({
	AudioStream, --stream
	C_UINT, --frameCount
	C_BOOL, --looping
	C_INT, --cxType
	C_POINTER --ctxData
})

public constant VrDeviceInfo = define_c_struct({
	C_INT, --hResolution
	C_INT, --vResolution
	C_FLOAT, --hScreenSize
	C_FLOAT, --vScreenSize
	C_FLOAT, --eyeToScreenDistance
	C_FLOAT, --lensSeparationDistance
	C_FLOAT, --interpupillaryDistance
	{C_FLOAT,4}, --lensDistortionValues[4]
	{C_FLOAT,4}  --chromaAbCorrection[4]
})

public constant VrStereoConfig = define_c_struct({
	{Matrix,2}, --projection[2]
	{Matrix,2}, --viewOffset[2]
	{C_FLOAT,2}, --leftLensCenter[2]
	{C_FLOAT,2}, --rightLensCenter[2]
	{C_FLOAT,2}, --leftScreenCenter[2]
	{C_FLOAT,2}, --rightScreenCenter[2]
	{C_FLOAT,2}, --scale[2]
	{C_FLOAT,2}  --scaleIn[2]
})

public constant FilePathList = define_c_struct({
	C_UINT, --capacity
	C_UINT, --count
	C_POINTER --paths
})

public constant AutomationEvent = define_c_struct({
	C_UINT, --frame
	C_UINT, --type
	{C_INT,4} --params[4]
})

public constant AutomationEventList = define_c_struct({
	C_UINT, --capacity
	C_UINT, --count
	C_POINTER --events
})

--Enums

public enum type ConfigFlags
	FLAG_VSYNC_HINT         = 0x00000040,   --// Set to try enabling V-Sync on GPU
    FLAG_FULLSCREEN_MODE    = 0x00000002,   --// Set to run program in fullscreen
    FLAG_WINDOW_RESIZABLE   = 0x00000004,   --// Set to allow resizable window
    FLAG_WINDOW_UNDECORATED = 0x00000008,   --// Set to disable window decoration (frame and buttons)
    FLAG_WINDOW_HIDDEN      = 0x00000080,   --// Set to hide window
    FLAG_WINDOW_MINIMIZED   = 0x00000200,   --// Set to minimize window (iconify)
    FLAG_WINDOW_MAXIMIZED   = 0x00000400,   --// Set to maximize window (expanded to monitor)
    FLAG_WINDOW_UNFOCUSED   = 0x00000800,   --// Set to window non focused
    FLAG_WINDOW_TOPMOST     = 0x00001000,   --// Set to window always on top
    FLAG_WINDOW_ALWAYS_RUN  = 0x00000100,   --// Set to allow windows running while minimized
    FLAG_WINDOW_TRANSPARENT = 0x00000010,   --// Set to allow transparent framebuffer
    FLAG_WINDOW_HIGHDPI     = 0x00002000,   --// Set to support HighDPI
    FLAG_WINDOW_MOUSE_PASSTHROUGH = 0x00004000, --// Set to support mouse passthrough, only supported when FLAG_WINDOW_UNDECORATED
    FLAG_BORDERLESS_WINDOWED_MODE = 0x00008000, --// Set to run program in borderless windowed mode
    FLAG_MSAA_4X_HINT       = 0x00000020,   --// Set to try enabling MSAA 4X
    FLAG_INTERLACED_HINT    = 0x00010000
end type

public enum type TraceLogLevel
	LOG_ALL = 0,       -- // Display all logs
    LOG_TRACE,          --// Trace logging, intended for internal use only
    LOG_DEBUG,          --// Debug logging, used for internal debugging, it should be disabled on release builds
    LOG_INFO,           --// Info logging, used for program execution info
    LOG_WARNING,        --// Warning logging, used on recoverable failures
    LOG_ERROR,          --// Error logging, used on unrecoverable failures
    LOG_FATAL,          --// Fatal logging, used to abort program: exit(EXIT_FAILURE)
    LOG_NONE
end type

public enum type KeyboardKey
	KEY_NULL            = 0,       -- // Key: NULL, used for no key pressed
   -- // Alphanumeric keys
    KEY_APOSTROPHE      = 39,      -- // Key: '
    KEY_COMMA           = 44,      -- // Key: ,
    KEY_MINUS           = 45,      -- // Key: -
    KEY_PERIOD          = 46,      -- // Key: .
    KEY_SLASH           = 47,      -- // Key: /
    KEY_ZERO            = 48,      -- // Key: 0
    KEY_ONE             = 49,      -- // Key: 1
    KEY_TWO             = 50,      -- // Key: 2
    KEY_THREE           = 51,       --// Key: 3
    KEY_FOUR            = 52,       --// Key: 4
    KEY_FIVE            = 53,       --// Key: 5
    KEY_SIX             = 54,       --// Key: 6
    KEY_SEVEN           = 55,       --// Key: 7
    KEY_EIGHT           = 56,       --// Key: 8
    KEY_NINE            = 57,       --// Key: 9
    KEY_SEMICOLON       = 59,       --// Key: ;
    KEY_EQUAL           = 61,       --// Key: =
    KEY_A               = 65,       --// Key: A | a
    KEY_B               = 66,       --// Key: B | b
    KEY_C               = 67,       --// Key: C | c
    KEY_D               = 68,       --// Key: D | d
    KEY_E               = 69,       --// Key: E | e
    KEY_F               = 70,       --// Key: F | f
    KEY_G               = 71,       --// Key: G | g
    KEY_H               = 72,       --// Key: H | h
    KEY_I               = 73,       --// Key: I | i
    KEY_J               = 74,       --// Key: J | j
    KEY_K               = 75,       --// Key: K | k
    KEY_L               = 76,       --// Key: L | l
    KEY_M               = 77,       --// Key: M | m
    KEY_N               = 78,       --// Key: N | n
    KEY_O               = 79,       --// Key: O | o
    KEY_P               = 80,       --// Key: P | p
    KEY_Q               = 81,       --// Key: Q | q
    KEY_R               = 82,       --// Key: R | r
    KEY_S               = 83,       --// Key: S | s
    KEY_T               = 84,       --// Key: T | t
    KEY_U               = 85,       --// Key: U | u
    KEY_V               = 86,       --// Key: V | v
    KEY_W               = 87,       --// Key: W | w
    KEY_X               = 88,       --// Key: X | x
    KEY_Y               = 89,       --// Key: Y | y
    KEY_Z               = 90,       --// Key: Z | z
    KEY_LEFT_BRACKET    = 91,       --// Key: [
    KEY_BACKSLASH       = 92,       --// Key: '\'
    KEY_RIGHT_BRACKET   = 93,       --// Key: ]
    KEY_GRAVE           = 96,       --// Key: `
    --// Function keys
    KEY_SPACE           = 32,       --// Key: Space
    KEY_ESCAPE          = 256,      --// Key: Esc
    KEY_ENTER           = 257,      --// Key: Enter
    KEY_TAB             = 258,      --// Key: Tab
    KEY_BACKSPACE       = 259,      --// Key: Backspace
    KEY_INSERT          = 260,      --// Key: Ins
    KEY_DELETE          = 261,      --// Key: Del
    KEY_RIGHT           = 262,      --// Key: Cursor right
    KEY_LEFT            = 263,      --// Key: Cursor left
    KEY_DOWN            = 264,      --// Key: Cursor down
    KEY_UP              = 265,      --// Key: Cursor up
    KEY_PAGE_UP         = 266,      --// Key: Page up
    KEY_PAGE_DOWN       = 267,      --// Key: Page down
    KEY_HOME            = 268,      --// Key: Home
    KEY_END             = 269,      --// Key: End
    KEY_CAPS_LOCK       = 280,      --// Key: Caps lock
    KEY_SCROLL_LOCK     = 281,      --// Key: Scroll down
    KEY_NUM_LOCK        = 282,      --// Key: Num lock
    KEY_PRINT_SCREEN    = 283,      --// Key: Print screen
    KEY_PAUSE           = 284,      --// Key: Pause
    KEY_F1              = 290,      --// Key: F1
    KEY_F2              = 291,      --// Key: F2
    KEY_F3              = 292,      --// Key: F3
    KEY_F4              = 293,      --// Key: F4
    KEY_F5              = 294,      --// Key: F5
    KEY_F6              = 295,      --// Key: F6
    KEY_F7              = 296,      --// Key: F7
    KEY_F8              = 297,      --// Key: F8
    KEY_F9              = 298,      --// Key: F9
    KEY_F10             = 299,      --// Key: F10
    KEY_F11             = 300,      --// Key: F11
    KEY_F12             = 301,      --// Key: F12
    KEY_LEFT_SHIFT      = 340,      --// Key: Shift left
    KEY_LEFT_CONTROL    = 341,      --// Key: Control left
    KEY_LEFT_ALT        = 342,      --// Key: Alt left
    KEY_LEFT_SUPER      = 343,      --// Key: Super left
    KEY_RIGHT_SHIFT     = 344,      --// Key: Shift right
    KEY_RIGHT_CONTROL   = 345,      --// Key: Control right
    KEY_RIGHT_ALT       = 346,      --// Key: Alt right
    KEY_RIGHT_SUPER     = 347,      --// Key: Super right
    KEY_KB_MENU         = 348,      --// Key: KB menu
    --// Keypad keys
    KEY_KP_0            = 320,     -- // Key: Keypad 0
    KEY_KP_1            = 321,     -- // Key: Keypad 1
    KEY_KP_2            = 322,     -- // Key: Keypad 2
    KEY_KP_3            = 323,     -- // Key: Keypad 3
    KEY_KP_4            = 324,     -- // Key: Keypad 4
    KEY_KP_5            = 325,      --// Key: Keypad 5
    KEY_KP_6            = 326,      --// Key: Keypad 6
    KEY_KP_7            = 327,      --// Key: Keypad 7
    KEY_KP_8            = 328,      --// Key: Keypad 8
    KEY_KP_9            = 329,      --// Key: Keypad 9
    KEY_KP_DECIMAL      = 330,      --// Key: Keypad .
    KEY_KP_DIVIDE       = 331,      --// Key: Keypad /
    KEY_KP_MULTIPLY     = 332,      --// Key: Keypad *
    KEY_KP_SUBTRACT     = 333,      --// Key: Keypad -
    KEY_KP_ADD          = 334,      --// Key: Keypad +
    KEY_KP_ENTER        = 335,      --// Key: Keypad Enter
    KEY_KP_EQUAL        = 336,      --// Key: Keypad =
    --// Android key buttons
    KEY_BACK            = 4,       -- // Key: Android back button
    KEY_MENU            = 5,       -- // Key: Android menu button
    KEY_VOLUME_UP       = 24,      -- // Key: Android volume up button
    KEY_VOLUME_DOWN     = 25
end type

public enum type MouseButton
	MOUSE_BUTTON_LEFT    = 0,     --  // Mouse button left
    MOUSE_BUTTON_RIGHT   = 1,     --  // Mouse button right
    MOUSE_BUTTON_MIDDLE  = 2,      -- // Mouse button middle (pressed wheel)
    MOUSE_BUTTON_SIDE    = 3,       --// Mouse button side (advanced mouse device)
    MOUSE_BUTTON_EXTRA   = 4,       --// Mouse button extra (advanced mouse device)
    MOUSE_BUTTON_FORWARD = 5,       --// Mouse button forward (advanced mouse device)
    MOUSE_BUTTON_BACK    = 6
end type

--backwards compatbility naming
public constant MOUSE_LEFT_BUTTON = MOUSE_BUTTON_LEFT
public constant MOUSE_RIGHT_BUTTON = MOUSE_BUTTON_RIGHT
public constant MOUSE_MIDDLE_BUTTON = MOUSE_BUTTON_MIDDLE

public enum type MouseCursor
	MOUSE_CURSOR_DEFAULT       = 0,    -- // Default pointer shape
    MOUSE_CURSOR_ARROW         = 1,    -- // Arrow shape
    MOUSE_CURSOR_IBEAM         = 2,    -- // Text writing cursor shape
    MOUSE_CURSOR_CROSSHAIR     = 3,    -- // Cross shape
    MOUSE_CURSOR_POINTING_HAND = 4,    -- // Pointing hand cursor
    MOUSE_CURSOR_RESIZE_EW     = 5,    -- // Horizontal resize/move arrow shape
    MOUSE_CURSOR_RESIZE_NS     = 6,    -- // Vertical resize/move arrow shape
    MOUSE_CURSOR_RESIZE_NWSE   = 7,    -- // Top-left to bottom-right diagonal resize/move arrow shape
    MOUSE_CURSOR_RESIZE_NESW   = 8,    -- // The top-right to bottom-left diagonal resize/move arrow shape
    MOUSE_CURSOR_RESIZE_ALL    = 9,    -- // The omnidirectional resize/move cursor shape
    MOUSE_CURSOR_NOT_ALLOWED   = 10
end type

public enum type GamepadButton
	GAMEPAD_BUTTON_UNKNOWN = 0,        -- // Unknown button, just for error checking
    GAMEPAD_BUTTON_LEFT_FACE_UP,       -- // Gamepad left DPAD up button
    GAMEPAD_BUTTON_LEFT_FACE_RIGHT,    -- // Gamepad left DPAD right button
    GAMEPAD_BUTTON_LEFT_FACE_DOWN,     -- // Gamepad left DPAD down button
    GAMEPAD_BUTTON_LEFT_FACE_LEFT,     -- // Gamepad left DPAD left button
    GAMEPAD_BUTTON_RIGHT_FACE_UP,      -- // Gamepad right button up (i.e. PS3: Triangle, Xbox: Y)
    GAMEPAD_BUTTON_RIGHT_FACE_RIGHT,   -- // Gamepad right button right (i.e. PS3: Circle, Xbox: B)
    GAMEPAD_BUTTON_RIGHT_FACE_DOWN,    -- // Gamepad right button down (i.e. PS3: Cross, Xbox: A)
    GAMEPAD_BUTTON_RIGHT_FACE_LEFT,     --// Gamepad right button left (i.e. PS3: Square, Xbox: X)
    GAMEPAD_BUTTON_LEFT_TRIGGER_1,      --// Gamepad top/back trigger left (first), it could be a trailing button
    GAMEPAD_BUTTON_LEFT_TRIGGER_2,      --// Gamepad top/back trigger left (second), it could be a trailing button
    GAMEPAD_BUTTON_RIGHT_TRIGGER_1,     --// Gamepad top/back trigger right (first), it could be a trailing button
    GAMEPAD_BUTTON_RIGHT_TRIGGER_2,     --// Gamepad top/back trigger right (second), it could be a trailing button
    GAMEPAD_BUTTON_MIDDLE_LEFT,         --// Gamepad center buttons, left one (i.e. PS3: Select)
    GAMEPAD_BUTTON_MIDDLE,              --// Gamepad center buttons, middle one (i.e. PS3: PS, Xbox: XBOX)
    GAMEPAD_BUTTON_MIDDLE_RIGHT,        --// Gamepad center buttons, right one (i.e. PS3: Start)
    GAMEPAD_BUTTON_LEFT_THUMB,          --// Gamepad joystick pressed button left
    GAMEPAD_BUTTON_RIGHT_THUMB 
end type

public enum type GamepadAxis
	GAMEPAD_AXIS_LEFT_X        = 0,   --  // Gamepad left stick X axis
    GAMEPAD_AXIS_LEFT_Y        = 1,   --  // Gamepad left stick Y axis
    GAMEPAD_AXIS_RIGHT_X       = 2,    -- // Gamepad right stick X axis
    GAMEPAD_AXIS_RIGHT_Y       = 3,    -- // Gamepad right stick Y axis
    GAMEPAD_AXIS_LEFT_TRIGGER  = 4,    -- // Gamepad back trigger left, pressure level: [1..-1]
    GAMEPAD_AXIS_RIGHT_TRIGGER = 5
end type

public enum type MaterialMapIndex
	MATERIAL_MAP_ALBEDO = 0,      --  // Albedo material (same as: MATERIAL_MAP_DIFFUSE)
    MATERIAL_MAP_METALNESS,        -- // Metalness material (same as: MATERIAL_MAP_SPECULAR)
    MATERIAL_MAP_NORMAL,           -- // Normal material
    MATERIAL_MAP_ROUGHNESS,        -- // Roughness material
    MATERIAL_MAP_OCCLUSION,        -- // Ambient occlusion material
    MATERIAL_MAP_EMISSION,         -- // Emission material
    MATERIAL_MAP_HEIGHT,           -- // Heightmap material
    MATERIAL_MAP_CUBEMAP,          -- // Cubemap material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
    MATERIAL_MAP_IRRADIANCE,        --// Irradiance material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
    MATERIAL_MAP_PREFILTER,         --// Prefilter material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
    MATERIAL_MAP_BRDF
end type

public constant MATERIAL_MAP_DIFFUSE = MATERIAL_MAP_ALBEDO
public constant MATERIAL_MAP_SPECULAR = MATERIAL_MAP_METALNESS

public enum type ShaderLocationIndex
	 SHADER_LOC_VERTEX_POSITION = 0, --// Shader location: vertex attribute: position
    SHADER_LOC_VERTEX_TEXCOORD01,  -- // Shader location: vertex attribute: texcoord01
    SHADER_LOC_VERTEX_TEXCOORD02,   --// Shader location: vertex attribute: texcoord02
    SHADER_LOC_VERTEX_NORMAL,       --// Shader location: vertex attribute: normal
    SHADER_LOC_VERTEX_TANGENT,      --// Shader location: vertex attribute: tangent
    SHADER_LOC_VERTEX_COLOR,        --// Shader location: vertex attribute: color
    SHADER_LOC_MATRIX_MVP,          --// Shader location: matrix uniform: model-view-projection
    SHADER_LOC_MATRIX_VIEW,         --// Shader location: matrix uniform: view (camera transform)
    SHADER_LOC_MATRIX_PROJECTION,   --// Shader location: matrix uniform: projection
    SHADER_LOC_MATRIX_MODEL,        --// Shader location: matrix uniform: model (transform)
    SHADER_LOC_MATRIX_NORMAL,       --// Shader location: matrix uniform: normal
    SHADER_LOC_VECTOR_VIEW,         --// Shader location: vector uniform: view
    SHADER_LOC_COLOR_DIFFUSE,       --// Shader location: vector uniform: diffuse color
    SHADER_LOC_COLOR_SPECULAR,      --// Shader location: vector uniform: specular color
    SHADER_LOC_COLOR_AMBIENT,       --// Shader location: vector uniform: ambient color
    SHADER_LOC_MAP_ALBEDO,          --// Shader location: sampler2d texture: albedo (same as: SHADER_LOC_MAP_DIFFUSE)
    SHADER_LOC_MAP_METALNESS,       --// Shader location: sampler2d texture: metalness (same as: SHADER_LOC_MAP_SPECULAR)
    SHADER_LOC_MAP_NORMAL,          --// Shader location: sampler2d texture: normal
    SHADER_LOC_MAP_ROUGHNESS,       --// Shader location: sampler2d texture: roughness
    SHADER_LOC_MAP_OCCLUSION,       --// Shader location: sampler2d texture: occlusion
    SHADER_LOC_MAP_EMISSION,        --// Shader location: sampler2d texture: emission
    SHADER_LOC_MAP_HEIGHT,          --// Shader location: sampler2d texture: height
    SHADER_LOC_MAP_CUBEMAP,         --// Shader location: samplerCube texture: cubemap
    SHADER_LOC_MAP_IRRADIANCE,      --// Shader location: samplerCube texture: irradiance
    SHADER_LOC_MAP_PREFILTER,       --// Shader location: samplerCube texture: prefilter
    SHADER_LOC_MAP_BRDF,            --// Shader location: sampler2d texture: brdf
    SHADER_LOC_VERTEX_BONEIDS,      --// Shader location: vertex attribute: boneIds
    SHADER_LOC_VERTEX_BONEWEIGHTS,  --// Shader location: vertex attribute: boneWeights
    SHADER_LOC_BONE_MATRICES
end type

public constant SHADER_LOC_MAP_DIFFUSE = SHADER_LOC_MAP_ALBEDO
public constant SHADER_LOC_MAP_SPECULAR = SHADER_LOC_MAP_METALNESS

public enum type ShaderUniformDataType
	 SHADER_UNIFORM_FLOAT = 0,   --    // Shader uniform type: float
    SHADER_UNIFORM_VEC2,          --  // Shader uniform type: vec2 (2 float)
    SHADER_UNIFORM_VEC3,           -- // Shader uniform type: vec3 (3 float)
    SHADER_UNIFORM_VEC4,           -- // Shader uniform type: vec4 (4 float)
    SHADER_UNIFORM_INT,            -- // Shader uniform type: int
    SHADER_UNIFORM_IVEC2,          -- // Shader uniform type: ivec2 (2 int)
    SHADER_UNIFORM_IVEC3,          -- // Shader uniform type: ivec3 (3 int)
    SHADER_UNIFORM_IVEC4,           --// Shader uniform type: ivec4 (4 int)
    SHADER_UNIFORM_SAMPLER2D
end type

public enum type ShaderAttributeDataType
	 SHADER_ATTRIB_FLOAT = 0,    --    // Shader attribute type: float
    SHADER_ATTRIB_VEC2,           --  // Shader attribute type: vec2 (2 float)
    SHADER_ATTRIB_VEC3,            -- // Shader attribute type: vec3 (3 float)
    SHADER_ATTRIB_VEC4 
end type

public enum type PixelFormat
	PIXELFORMAT_UNCOMPRESSED_GRAYSCALE = 1, --// 8 bit per pixel (no alpha)
    PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA,    --// 8*2 bpp (2 channels)
    PIXELFORMAT_UNCOMPRESSED_R5G6B5,        --// 16 bpp
    PIXELFORMAT_UNCOMPRESSED_R8G8B8,        --// 24 bpp
    PIXELFORMAT_UNCOMPRESSED_R5G5B5A1,      --// 16 bpp (1 bit alpha)
    PIXELFORMAT_UNCOMPRESSED_R4G4B4A4,      --// 16 bpp (4 bit alpha)
    PIXELFORMAT_UNCOMPRESSED_R8G8B8A8,      --// 32 bpp
    PIXELFORMAT_UNCOMPRESSED_R32,           --// 32 bpp (1 channel - float)
    PIXELFORMAT_UNCOMPRESSED_R32G32B32,     --// 32*3 bpp (3 channels - float)
    PIXELFORMAT_UNCOMPRESSED_R32G32B32A32,  --// 32*4 bpp (4 channels - float)
    PIXELFORMAT_UNCOMPRESSED_R16,           --// 16 bpp (1 channel - half float)
    PIXELFORMAT_UNCOMPRESSED_R16G16B16,     --// 16*3 bpp (3 channels - half float)
    PIXELFORMAT_UNCOMPRESSED_R16G16B16A16,  --// 16*4 bpp (4 channels - half float)
    PIXELFORMAT_COMPRESSED_DXT1_RGB,        --// 4 bpp (no alpha)
    PIXELFORMAT_COMPRESSED_DXT1_RGBA,       --// 4 bpp (1 bit alpha)
    PIXELFORMAT_COMPRESSED_DXT3_RGBA,       --// 8 bpp
    PIXELFORMAT_COMPRESSED_DXT5_RGBA,       --// 8 bpp
    PIXELFORMAT_COMPRESSED_ETC1_RGB,        --// 4 bpp
    PIXELFORMAT_COMPRESSED_ETC2_RGB,        --// 4 bpp
    PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA,  -- // 8 bpp
    PIXELFORMAT_COMPRESSED_PVRT_RGB,       -- // 4 bpp
    PIXELFORMAT_COMPRESSED_PVRT_RGBA,       --// 4 bpp
    PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA,   --// 8 bpp
    PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA
end type

public enum type TextureFilter
	TEXTURE_FILTER_POINT = 0,           --    // No filter, just pixel approximation
    TEXTURE_FILTER_BILINEAR,             --   // Linear filtering
    TEXTURE_FILTER_TRILINEAR,             --  // Trilinear filtering (linear with mipmaps)
    TEXTURE_FILTER_ANISOTROPIC_4X,         -- // Anisotropic filtering 4x
    TEXTURE_FILTER_ANISOTROPIC_8X,         -- // Anisotropic filtering 8x
    TEXTURE_FILTER_ANISOTROPIC_16X
end type

public enum type TextureWrap
	TEXTURE_WRAP_REPEAT = 0,            --    // Repeats texture in tiled mode
    TEXTURE_WRAP_CLAMP,                  --   // Clamps texture to edge pixel in tiled mode
    TEXTURE_WRAP_MIRROR_REPEAT,           --  // Mirrors and repeats the texture in tiled mode
    TEXTURE_WRAP_MIRROR_CLAMP
end type

public enum type CubemapLayout
	CUBEMAP_LAYOUT_AUTO_DETECT = 0,       --  // Automatically detect layout type
    CUBEMAP_LAYOUT_LINE_VERTICAL,         --  // Layout is defined by a vertical line with faces
    CUBEMAP_LAYOUT_LINE_HORIZONTAL,        -- // Layout is defined by a horizontal line with faces
    CUBEMAP_LAYOUT_CROSS_THREE_BY_FOUR,    -- // Layout is defined by a 3x4 cross with cubemap faces
    CUBEMAP_LAYOUT_CROSS_FOUR_BY_THREE
end type

public enum type FontType
	 FONT_DEFAULT = 0,           --    // Default font generation, anti-aliased
    FONT_BITMAP,             --       // Bitmap font generation, no anti-aliasing
    FONT_SDF
end type

public enum type BlendMode
	 BLEND_ALPHA = 0,          --      // Blend textures considering alpha (default)
    BLEND_ADDITIVE,             --    // Blend textures adding colors
    BLEND_MULTIPLIED,            --   // Blend textures multiplying colors
    BLEND_ADD_COLORS,             --  // Blend textures adding colors (alternative)
    BLEND_SUBTRACT_COLORS,         -- // Blend textures subtracting colors (alternative)
    BLEND_ALPHA_PREMULTIPLY,       -- // Blend premultiplied textures considering alpha
    BLEND_CUSTOM,                  -- // Blend textures using custom src/dst factors (use rlSetBlendFactors())
    BLEND_CUSTOM_SEPARATE
end type

public enum type Gesture
	 GESTURE_NONE        = 0,    --    // No gesture
    GESTURE_TAP         = 1,      --  // Tap gesture
    GESTURE_DOUBLETAP   = 2,       -- // Double tap gesture
    GESTURE_HOLD        = 4,        --// Hold gesture
    GESTURE_DRAG        = 8,        --// Drag gesture
    GESTURE_SWIPE_RIGHT = 16,       --// Swipe right gesture
    GESTURE_SWIPE_LEFT  = 32,       --// Swipe left gesture
    GESTURE_SWIPE_UP    = 64,       --// Swipe up gesture
    GESTURE_SWIPE_DOWN  = 128,     -- // Swipe down gesture
    GESTURE_PINCH_IN    = 256,      --// Pinch in gesture
    GESTURE_PINCH_OUT   = 512
end type

public enum type CameraMode
	CAMERA_CUSTOM = 0,        --      // Camera custom, controlled by user (UpdateCamera() does nothing)
    CAMERA_FREE,               --     // Camera free mode
    CAMERA_ORBITAL,             --    // Camera orbital, around target, zoom supported
    CAMERA_FIRST_PERSON,         --   // Camera first person
    CAMERA_THIRD_PERSON
end type

public enum type CameraProjection
	 CAMERA_PERSPECTIVE = 0,   --     // Perspective projection
    CAMERA_ORTHOGRAPHIC
end type

public enum type NPatchLayout
	NPATCH_NINE_PATCH = 0,        --  // Npatch layout: 3x3 tiles
    NPATCH_THREE_PATCH_VERTICAL,   -- // Npatch layout: 1x3 tiles
    NPATCH_THREE_PATCH_HORIZONTAL
end type

--Callbacks TODO

--Window Functions
public constant xInitWindow = define_c_proc(ray,"+InitWindow",{C_INT,C_INT,C_STRING}),
				xCloseWindow = define_c_proc(ray,"+CloseWindow",{}),
				xWindowShouldClose = define_c_func(ray,"+WindowShouldClose",{},C_BOOL),
				xIsWindowReady = define_c_func(ray,"+IsWindowReady",{},C_BOOL),
				xIsWindowFullscreen = define_c_func(ray,"+IsWindowFullscreen",{},C_BOOL),
				xIsWindowHidden = define_c_func(ray,"+IsWindowHidden",{},C_BOOL),
				xIsWindowMinimized = define_c_func(ray,"+IsWindowMinimized",{},C_BOOL),
				xIsWindowMaximized = define_c_func(ray,"+IsWindowMaximized",{},C_BOOL),
				xIsWindowFocused = define_c_func(ray,"+IsWindowFocused",{},C_BOOL),
				xIsWindowResized = define_c_func(ray,"+IsWindowResized",{},C_BOOL),
				xIsWindowState = define_c_func(ray,"+IsWindowState",{C_UINT},C_BOOL),
				xSetWindowState = define_c_proc(ray,"+SetWindowState",{C_UINT}),
				xClearWindowState = define_c_proc(ray,"+ClearWindowState",{C_UINT}),
				xToggleFullscreen = define_c_proc(ray,"+ToggleFullscreen",{}),
				xToggleBorderlessWindowed = define_c_proc(ray,"+ToggleBorderlessWindowed",{}),
				xMaximizeWindow = define_c_proc(ray,"+MaximizeWindow",{}),
				xMinimizeWindow = define_c_proc(ray,"+MinimizeWindow",{}),
				xRestoreWindow = define_c_proc(ray,"+RestoreWindow",{}),
				xSetWindowIcon = define_c_proc(ray,"SetWindowIcon",{Image}),
				xSetWindowIcons = define_c_proc(ray,"+SetWindowIcons",{C_POINTER,C_INT}),
				xSetWindowTitle = define_c_proc(ray,"+setWindowTitle",{C_STRING}),
				xSetWindowPosition = define_c_proc(ray,"+SetWindowPosition",{C_INT,C_INT}),
				xSetWindowMonitor = define_c_proc(ray,"+SetWindowMonitor",{C_INT}),
				xSetWindowMinSize = define_c_proc(ray,"+SetWindowMinSize",{C_INT,C_INT}),
				xSetWindowMaxSize = define_c_proc(ray,"+SetWindowMaxSize",{C_INT,C_INT}),
				xSetWindowSize = define_c_proc(ray,"+SetWindowSize",{C_INT,C_INT}),
				xSetWindowOpacity = define_c_proc(ray,"+SetWindowOpacity",{C_FLOAT}),
				xSetWindowFocused = define_c_proc(ray,"+SetWindowFocused",{}),
				xGetWindowHandle = define_c_func(ray,"+GetWindowHandle",{},C_POINTER),
				xGetScreenWidth = define_c_func(ray,"+GetScreenWidth",{},C_INT),
				xGetScreenHeight = define_c_func(ray,"+GetScreenHeight",{},C_INT),
				xGetRenderWidth = define_c_func(ray,"+GetRenderWidth",{},C_INT),
				xGetRenderHeight = define_c_func(ray,"+GetRenderHeight",{},C_INT),
				xGetMonitorCount = define_c_func(ray,"+GetMonitorCount",{},C_INT),
				xGetCurrentMonitor = define_c_func(ray,"+GetCurrentMonitor",{},C_INT),
				xGetMonitorPosition = define_c_func(ray,"+GetMonitorPosition",{C_INT},Vector2),
				xGetMonitorWidth = define_c_func(ray,"+GetMonitorWidth",{C_INT},C_INT),
				xGetMonitorHeight = define_c_func(ray,"+GetMonitorHeight",{C_INT},C_INT),
				xGetMonitorPhysicalWidth = define_c_func(ray,"+GetMonitorPhysicalWidth",{C_INT},C_INT),
				xGetMonitorPhysicalHeight = define_c_func(ray,"+GetMonitorPhysicalHeight",{C_INT},C_INT),
				xGetMonitorRefreshRate = define_c_func(ray,"+GetMonitorRefreshRate",{C_INT},C_INT),
				xGetWindowPosition = define_c_func(ray,"+GetWindowPosition",{},Vector2),
				xGetWindowScaleDPI = define_c_func(ray,"+GetWindowScaleDPI",{},Vector2),
				xGetMonitorName = define_c_func(ray,"+GetMonitorName",{C_INT},C_STRING),
				xSetClipboardText = define_c_proc(ray,"+SetClipboardText",{C_STRING}),
				xGetClipboardText = define_c_func(ray,"+GetClipboardText",{},C_STRING),
				xGetClipboardImage = define_c_func(ray,"+GetClipboardImage",{},Image),
				xEnableEventWaiting = define_c_proc(ray,"+EnableEventWaiting",{}),
				xDisableEventWaiting = define_c_proc(ray,"+DisableEventWaiting",{})

public procedure InitWindow(atom width,atom height,sequence title)
	c_proc(xInitWindow,{width,height,title})
end procedure

public procedure CloseWindow()
	c_proc(xCloseWindow,{})
end procedure

public function WindowShouldClose()
	return c_func(xWindowShouldClose,{})
end function

public function IsWindowReady()
	return c_func(xIsWindowReady,{})
end function

public function IsWindowFullscreen()
	return c_func(xIsWindowFullscreen,{})
end function

public function IsWindowHidden()
	return c_func(xIsWindowHidden,{})
end function

public function IsWindowMinimized()
	return c_func(xIsWindowMinimized,{})
end function

public function IsWindowMaximized()
	return c_func(xIsWindowMaximized,{})
end function

public function IsWindowFocused()
	return c_func(xIsWindowFocused,{})
end function

public function IsWindowResized()
	return c_func(xIsWindowResized,{})
end function

public function IsWindowState(atom flag)
	return c_func(xIsWindowState,{flag})
end function

public procedure SetWindowState(atom flags)
	c_proc(xSetWindowState,{flags})
end procedure

public procedure ClearWindowState(atom flags)
	c_proc(xClearWindowState,{flags})
end procedure

public procedure ToggleFullscreen()
	c_proc(xToggleFullscreen,{})
end procedure

public procedure ToggleBorderlessWindowed()
	c_proc(xToggleBorderlessWindowed,{})
end procedure

public procedure MaximizeWindow()
	c_proc(xMaximizeWindow,{})
end procedure

public procedure MinimizeWindow()
	c_proc(xMinimizeWindow,{})
end procedure

public procedure RestoreWindow()
	c_proc(xRestoreWindow,{})
end procedure

public procedure SetWindowIcon(sequence image)
	c_proc(xSetWindowIcon,{image})
end procedure

public procedure SetWindowIcons(atom images,atom count)
	c_proc(xSetWindowIcons,{images,count})
end procedure

public procedure SetWindowTitle(sequence title)
	c_proc(xSetWindowTitle,{title})
end procedure

public procedure SetWindowPosition(atom x,atom y)
	c_proc(xSetWindowPosition,{x,y})
end procedure

public procedure SetWindowMonitor(atom monitor)
	c_proc(xSetWindowMonitor,{monitor})
end procedure

public procedure SetWindowMinSize(atom width,atom height)
	c_proc(xSetWindowMinSize,{width,height})
end procedure

public procedure SetWindowMaxSize(atom width,atom height)
	c_proc(xSetWindowMaxSize,{width,height})
end procedure

public procedure SetWindowSize(atom width,atom height)
	c_proc(xSetWindowSize,{width,height})
end procedure

public procedure SetWindowOpacity(atom opacity)
	c_proc(xSetWindowOpacity,{opacity})
end procedure

public procedure SetWindowFocused()
	c_proc(xSetWindowFocused,{})
end procedure

public function GetWindowHandle()
	return c_func(xGetWindowHandle,{})
end function

public function GetScreenWidth()
	return c_func(xGetScreenWidth,{})
end function

public function GetScreenHeight()
	return c_func(xGetScreenHeight,{})
end function

public function GetRenderWidth()
	return c_func(xGetRenderWidth,{})
end function

public function GetRenderHeight()
	return c_func(xGetRenderHeight,{})
end function

public function GetMonitorCount()
	return c_func(xGetMonitorCount,{})
end function

public function GetCurrentMonitor()
	return c_func(xGetCurrentMonitor,{})
end function

public function GetMonitorPosition(atom monitor)
	return c_func(xGetMonitorPosition,{monitor})
end function

public function GetMonitorWidth(atom monitor)
	return c_func(xGetMonitorWidth,{monitor})
end function

public function GetMonitorHeight(atom monitor)
	return c_func(xGetMonitorHeight,{monitor})
end function

public function GetMonitorPhysicalWidth(atom monitor)
	return c_func(xGetMonitorPhysicalWidth,{monitor})
end function

public function GetMonitorPhysicalHeight(atom monitor)
	return c_func(xGetMonitorPhysicalHeight,{monitor})
end function

public function GetMonitorRefreshRate(atom monitor)
	return c_func(xGetMonitorRefreshRate,{monitor})
end function

public function GetWindowPosition()
	return c_func(xGetWindowPosition,{})
end function

public function GetWindowScaleDPI()
	return c_func(xGetWindowScaleDPI,{})
end function

public function GetMonitorName(atom monitor)
	return c_func(xGetMonitorName,{monitor})
end function

public procedure SetClipboardText(sequence text)
	c_proc(xSetClipboardText,{text})
end procedure

public function GetClipboardText()
	return c_func(xGetClipboardText,{})
end function

public function GetClipboardImage()
	return c_func(xGetClipboardImage,{})
end function

public procedure EnableEventWaiting()
	c_proc(xEnableEventWaiting,{})
end procedure

public procedure DisableEventWaiting()
	c_proc(xDisableEventWaiting,{})
end procedure

--Cursor functions

public constant xShowCursor = define_c_proc(ray,"+ShowCursor",{}),
				xHideCursor = define_c_proc(ray,"+HideCursor",{}),
				xIsCursorHidden = define_c_func(ray,"+IsCursorHidden",{},C_BOOL),
				xEnableCursor = define_c_proc(ray,"+EnableCursor",{}),
				xDisableCursor = define_c_proc(ray,"+DisableCursor",{}),
				xIsCursorOnScreen = define_c_func(ray,"+IsCursorOnScreen",{},C_BOOL)
				
public procedure ShowCursor()
	c_proc(xShowCursor,{})
end procedure

public procedure HideCursor()
	c_proc(xHideCursor,{})
end procedure

public function IsCursorHidden()
	return c_func(xIsCursorHidden,{})
end function

public procedure EnableCursor()
	c_proc(xEnableCursor,{})
end procedure

public procedure DisableCursor()
	c_proc(xDisableCursor,{})
end procedure

public function IsCursorOnScreen()
	return c_func(xIsCursorOnScreen,{})
end function

--Drawing Functions

public constant xClearBackground = define_c_proc(ray,"+ClearBackground",{Color}),
				xBeginDrawing = define_c_proc(ray,"+BeginDrawing",{}),
				xEndDrawing = define_c_proc(ray,"+EndDrawing",{}),
				xBeginMode2D = define_c_proc(ray,"+BeginMode2D",{Camera2D}),
				xEndMode2D = define_c_proc(ray,"+EndMode2D",{}),
				xBeginMode3D = define_c_proc(ray,"+BeginMode3D",{Camera3D}),
				xEndMode3D = define_c_proc(ray,"+EndMode3D",{}),
				xBeginTextureMode = define_c_proc(ray,"+BeginTextureMode",{RenderTexture2D}),
				xEndTextureMode = define_c_proc(ray,"+EndTextureMode",{}),
				xBeginShaderMode = define_c_proc(ray,"+BeginShaderMode",{Shader}),
				xEndShaderMode = define_c_proc(ray,"+EndShaderMode",{}),
				xBeginBlendMode = define_c_proc(ray,"+BeginBlendMode",{C_INT}),
				xEndBlendMode = define_c_proc(ray,"+EndBlendMode",{}),
				xBeginScissorMode = define_c_proc(ray,"+BeginScissorMode",{C_INT,C_INT,C_INT,C_INT}),
				xEndScissorMode = define_c_proc(ray,"+EndScissorMode",{}),
				xBeginVrStereoMode = define_c_proc(ray,"+BeginVrStereoMode",{VrStereoConfig}),
				xEndVrStereoMode = define_c_proc(ray,"+EndVrStereoMode",{})
				
public procedure ClearBackground(sequence color)
	c_proc(xClearBackground,{color})
end procedure

public procedure BeginDrawing()
	c_proc(xBeginDrawing,{})
end procedure

public procedure EndDrawing()
	c_proc(xEndDrawing,{})
end procedure

public procedure BeginMode2D(sequence camera2D)
	c_proc(xBeginMode2D,{camera2D})
end procedure

public procedure EndMode2D()
	c_proc(xEndMode2D,{})
end procedure

public procedure BeginMode3D(sequence camera3D)
	c_proc(xBeginMode3D,{camera3D})
end procedure

public procedure EndMode3D()
	c_proc(xEndMode3D,{})
end procedure

public procedure BeginTextureMode(sequence target)
	c_proc(xBeginTextureMode,{target}) --target is RenderTexture2D
end procedure

public procedure EndTextureMode()
	c_proc(xEndTextureMode,{})
end procedure

public procedure BeginShaderMode(sequence shader)
	c_proc(xBeginShaderMode,{shader})
end procedure

public procedure EndShaderMode()
	c_proc(xEndShaderMode,{})
end procedure

public procedure BeginBlendMode(atom mode)
	c_proc(xBeginBlendMode,{mode})
end procedure

public procedure EndBlendMode()
	c_proc(xEndBlendMode,{})
end procedure

public procedure BeginScissorMode(atom x,atom y,atom width,atom height)
	c_proc(xBeginScissorMode,{x,y,width,height})
end procedure

public procedure EndScissorMode()
	c_proc(xEndScissorMode,{})
end procedure

public procedure BeginVrStereoMode(sequence config)
	c_proc(xBeginVrStereoMode,{config}) --config is VrStereoConfig
end procedure

public procedure EndVrStereoMode()
	c_proc(xEndVrStereoMode,{})
end procedure

--VR Stereo config functions
public constant xLoadVrStereoConfig = define_c_func(ray,"+LoadVrStereoConfig",{VrDeviceInfo},VrStereoConfig),
				xUnloadVrStereoConfig = define_c_proc(ray,"+UnloadVrStereoConfig",{VrStereoConfig})
				
public function LoadVrStereoConfig(sequence device)
	return c_func(xLoadVrStereoConfig,{device}) --device is VrDeviceInfo
end function

public procedure UnloadVrStereoConfig(sequence config)
	c_proc(xUnloadVrStereoConfig,{config}) --config is VrStereoConfig
end procedure

--Shader functions
public constant xLoadShader = define_c_func(ray,"+LoadShader",{C_STRING,C_STRING},Shader),
				xLoadShaderFromMemory = define_c_func(ray,"+LoadShaderFromMemory",{C_STRING,C_STRING},Shader),
				xIsShaderValid = define_c_func(ray,"+IsShaderValid",{Shader},C_BOOL),
				xGetShaderLocation = define_c_func(ray,"+GetShaderLocation",{Shader,C_STRING},C_INT),
				xGetShaderLocationAttrib = define_c_func(ray,"+GetShaderLocationAttrib",{Shader,C_STRING},C_INT),
				xSetShaderValue = define_c_proc(ray,"+SetShaderValue",{Shader,C_INT,C_POINTER,C_INT}),
				xSetShaderValueV = define_c_proc(ray,"+SetShaderValueV",{Shader,C_INT,C_POINTER,C_INT,C_INT}),
				xSetShaderValueMatrix = define_c_proc(ray,"+SetShaderValueMatrix",{Shader,C_INT,Matrix}),
				xSetShaderValueTexture = define_c_proc(ray,"+SetShaderValueTexture",{Shader,C_INT,Texture2D}),
				xUnloadShader = define_c_proc(ray,"+UnloadShader",{Shader})
				
public function LoadShader(sequence vsFileName,sequence fsFileName)
	return c_func(xLoadShader,{vsFileName,fsFileName})
end function

public function LoadShaderFromMemory(sequence vsCode,sequence fsCode)
	return c_func(xLoadShaderFromMemory,{vsCode,fsCode})
end function

public function IsShaderValid(sequence shader)
	return c_func(xIsShaderValid,{shader})
end function

public function GetShaderLocation(sequence shader,sequence uniformName)
	return c_func(xGetShaderLocation,{shader,uniformName})
end function

public function GetShaderLocationAttrib(sequence shader,sequence attribName)
	return c_func(xGetShaderLocationAttrib,{shader,attribName})
end function

public procedure SetShaderValue(sequence shader,atom locIndex,object val,atom uniformType)
	c_proc(xSetShaderValue,{shader,locIndex,val,uniformType})
end procedure

public procedure SetShaderValueV(sequence shader,atom locIndex,object val,atom uniformType,atom count)
	c_proc(xSetShaderValueV,{shader,locIndex,val,uniformType,count})
end procedure

public procedure SetShaderValueMatrix(sequence shader,atom locIndex,sequence mat)
	c_proc(xSetShaderValueMatrix,{shader,locIndex,mat})
end procedure

public procedure SetShaderValueTexture(sequence shader,atom locIndex,sequence texture)
	c_proc(xSetShaderValueTexture,{shader,locIndex,texture})
end procedure

public procedure UnloadShader(sequence shader)
	c_proc(xUnloadShader,{shader})
end procedure

--Screen space functions
public constant xGetScreenToWorldRay = define_c_func(ray,"+GetScreenToWorldRay",{Vector2,Camera},Ray),
				xGetScreenToWorldRayEx = define_c_func(ray,"+GetScreenToWorldRayEx",{Vector2,Camera,C_INT,C_INT},Ray),
				xGetWorldToScreen = define_c_func(ray,"+GetWorldToScreen",{Vector3,Camera},Vector2),
				xGetWorldToScreenEx = define_c_func(ray,"+GetWorldToScreenEx",{Vector3,Camera,C_INT,C_INT},Vector2),
				xGetWorldToScreen2D = define_c_func(ray,"+GetWorldToScreen2D",{Vector2,Camera2D},Vector2),
				xGetScreenToWorld2D = define_c_func(ray,"+GetScreenToWorld2D",{Vector2,Camera2D},Vector2),
				xGetCameraMatrix = define_c_func(ray,"+GetCameraMatrix",{Camera},Matrix),
				xGetCameraMatrix2D = define_c_func(ray,"+GetCameraMatrix2D",{Camera2D},Matrix)
				
public function GetScreenToWorldRay(sequence pos,sequence camera)
	return c_func(xGetScreenToWorldRay,{pos,camera})
end function

public function GetScreenToWorldRayEx(sequence pos,sequence camera,atom width,atom height)
	return c_func(xGetScreenToWorldRayEx,{pos,camera,width,height})
end function

public function GetWorldToScreen(sequence pos,sequence camera)
	return c_func(xGetWorldToScreen,{pos,camera})
end function

public function GetWorldToScreenEx(sequence pos,sequence camera,atom width,atom height)
	return c_func(xGetWorldToScreenEx,{pos,camera,width,height})
end function

public function GetWorldToScreen2D(sequence pos,sequence camera2D)
	return c_func(xGetWorldToScreen2D,{pos,camera2D})
end function

public function GetScreenToWorld2D(sequence pos,sequence camera2D)
	return c_func(xGetScreenToWorld2D,{pos,camera2D})
end function

public function GetCameraMatrix(sequence camera)
	return c_func(xGetCameraMatrix,{camera})
end function

public function GetCameraMatrix2D(sequence camera)
	return c_func(xGetCameraMatrix2D,{camera})
end function

--Timing functions

public constant xSetTargetFPS = define_c_proc(ray,"+SetTargetFPS",{C_INT}),
				xGetFrameTime = define_c_func(ray,"+GetFrameTime",{},C_FLOAT),
				xGetTime = define_c_func(ray,"+GetTime",{},C_DOUBLE),
				xGetFPS = define_c_func(ray,"+GetFPS",{},C_INT)
				
public procedure SetTargetFPS(atom fps)
	c_proc(xSetTargetFPS,{fps})
end procedure

public function GetFrameTime()
	return c_func(xGetFrameTime,{})
end function

public function GetTime()
	return c_func(xGetTime,{})
end function

public function GetFPS()
	return c_func(xGetFPS,{})
end function

--Custom frame control functions
public constant xSwapScreenBuffer = define_c_proc(ray,"+SwapScreenBuffer",{}),
				xPollInputEvents = define_c_proc(ray,"+PollInputEvents",{}),
				xWaitTime = define_c_proc(ray,"+WaitTime",{C_DOUBLE})
				
public procedure SwapScreenBuffer()
	c_proc(xSwapScreenBuffer,{})
end procedure

public procedure PollInputEvents()
	c_proc(xPollInputEvents,{})
end procedure

public procedure WaitTime(atom seconds)
	c_proc(xWaitTime,{seconds})
end procedure

--Random value generation functions
public constant xSetRandomSeed = define_c_proc(ray,"+SetRandomSeed",{C_UINT}),
				xGetRandomValue = define_c_func(ray,"+GetRandomValue",{C_INT,C_INT},C_INT),
				xLoadRandomSequence = define_c_func(ray,"+LoadRandomSequence",{C_UINT,C_INT,C_INT},C_POINTER),
				xUnloadRandomSequence = define_c_proc(ray,"+UnloadRandomSequence",{C_POINTER})
				
public procedure SetRandomSeed(atom seed)
	c_proc(xSetRandomSeed,{seed})
end procedure

public function GetRandomValue(atom min,atom max)
	return c_func(xGetRandomValue,{min,max})
end function

public function LoadRandomSequence(atom count,atom min,atom max)
	return c_func(xLoadRandomSequence,{count,min,max})
end function

public procedure UnloadRandomSequence(atom seq)
	c_proc(xUnloadRandomSequence,{seq})
end procedure

--Misc functions
public constant xTakeScreenshot = define_c_proc(ray,"+TakeScreenshot",{C_STRING}),
				xSetConfigFlags = define_c_proc(ray,"+SetConfigFlags",{C_UINT}),
				xOpenURL = define_c_proc(ray,"+OpenURL",{C_STRING})
				
public procedure TakeScreenshot(sequence fName)
	c_proc(xTakeScreenshot,{fName})
end procedure

public procedure SetConfigFlags(atom flags)
	c_proc(xSetConfigFlags,{flags})
end procedure

public procedure OpenURL(sequence url)
	c_proc(xOpenURL,{url})
end procedure

--
public constant xTraceLog = define_c_proc(ray,"+TraceLog",{C_INT,C_STRING,C_POINTER}),
				xSetTraceLogLevel = define_c_proc(ray,"+SetTraceLogLevel",{C_INT}),
				xMemAlloc = define_c_func(ray,"+MemAlloc",{C_UINT},C_POINTER),
				xMemRealloc = define_c_func(ray,"+MemRealloc",{C_POINTER,C_UINT},C_POINTER),
				xMemFree = define_c_proc(ray,"+MemFree",{C_POINTER})
				
public procedure TraceLog(atom logLevel,sequence text,object x)
	c_proc(xTraceLog,{logLevel,text,x})
end procedure

public procedure SetTraceLogLevel(atom logLevel)
	c_proc(xSetTraceLogLevel,{logLevel})
end procedure

public function MemAlloc(atom size)
	return c_func(xMemAlloc,{size})
end function

public function MemRealloc(atom ptr,atom size)
	return c_func(xMemRealloc,{ptr,size})
end function

public procedure MemFree(atom ptr)
	c_proc(xMemFree,{ptr})
end procedure

--Custom callback functions TODO

--File management functions
public constant xLoadFileData = define_c_func(ray,"+LoadFileData",{C_STRING,C_POINTER},C_POINTER),
				xUnloadFileData = define_c_proc(ray,"+UnloadFileData",{C_POINTER}),
				xSaveFileData = define_c_func(ray,"+SaveFileData",{C_STRING,C_POINTER,C_INT},C_BOOL),
				xExportDataAsCode = define_c_func(ray,"+ExportDataAsCode",{C_POINTER,C_INT,C_STRING},C_BOOL),
				xLoadFileText = define_c_func(ray,"+LoadFileText",{C_STRING},C_POINTER),
				xUnloadFileText = define_c_proc(ray,"+UnloadFileText",{C_STRING}),
				xSaveFileText = define_c_func(ray,"+SaveFileText",{C_STRING,C_STRING},C_BOOL)
				
public function LoadFileData(sequence fName,atom dataSize)
	return c_func(xLoadFileData,{fName,dataSize})
end function

public procedure UnloadFileData(atom data)
	c_proc(xUnloadFileData,{data})
end procedure

public function SaveFileData(sequence fname,object data,atom dataSize)
	return c_func(xSaveFileData,{fname,data,dataSize})
end function

public function ExportDataAsCode(atom data,atom dataSize,sequence fname)
	return c_func(xExportDataAsCode,{data,dataSize,fname})
end function

public function LoadFileText(sequence fname)
	return c_func(xLoadFileText,{fname})
end function

public procedure UnloadFileText(sequence text)
	c_proc(xUnloadFileText,{text})
end procedure

public function SaveFileText(sequence fname,sequence text)
	return c_func(xSaveFileText,{fname,text})
end function

--file system functions
public constant xFileExists = define_c_func(ray,"+FileExists",{C_STRING},C_BOOL),
				xDirectoryExists = define_c_func(ray,"+DirectoryExists",{C_STRING},C_BOOL),
				xIsFileExtension = define_c_func(ray,"+IsFileExtension",{C_STRING,C_STRING},C_BOOL),
				xGetFileLength = define_c_func(ray,"+GetFileLength",{C_STRING},C_INT),
				xGetFileExtension = define_c_func(ray,"+GetFileExtension",{C_STRING},C_STRING),
				xGetFileName = define_c_func(ray,"+GetFileName",{C_STRING},C_STRING),
				xGetFileNameWithoutExt = define_c_func(ray,"+GetFileNameWithoutExt",{C_STRING},C_STRING),
				xGetDirectoryPath = define_c_func(ray,"+GetDirectoryPath",{C_STRING},C_STRING),
				xGetPrevDirectoryPath = define_c_func(ray,"+GetPrevDirectoryPath",{C_STRING},C_STRING),
				xGetWorkingDirectory = define_c_func(ray,"+GetWorkingDirectory",{},C_STRING),
				xGetApplicationDirectory = define_c_func(ray,"+GetApplicationDirectory",{},C_STRING),
				xMakeDirectory = define_c_func(ray,"+MakeDirectory",{C_STRING},C_INT),
				xChangeDirectory = define_c_func(ray,"+ChangeDirectory",{C_STRING},C_BOOL),
				xIsPathFile = define_c_func(ray,"+IsPathFile",{C_STRING},C_BOOL),
				xIsFileNameValid = define_c_func(ray,"+IsFileNameValid",{C_STRING},C_BOOL),
				xLoadDirectoryFiles = define_c_func(ray,"+LoadDirectoryFiles",{C_STRING},FilePathList),
				xLoadDirectoryFilesEx = define_c_func(ray,"+LoadDirectoryFilesEx",{C_STRING,C_STRING,C_BOOL},FilePathList),
				xUnloadDirectoryFiles = define_c_proc(ray,"+UnloadDirectoryFiles",{FilePathList}),
				xIsFileDropped = define_c_func(ray,"+IsFileDropped",{},C_BOOL),
				xLoadDroppedFiles = define_c_func(ray,"+LoadDroppedFiles",{},FilePathList),
				xUnloadDroppedFiles = define_c_proc(ray,"+UnloadDroppedFiles",{FilePathList}),
				xGetFileModTime = define_c_func(ray,"+GetFileModTime",{C_STRING},C_LONG)
				
public function FileExists(sequence fName)
	return c_func(xFileExists,{fName})
end function

public function DirectoryExists(sequence dirPath)
	return c_func(xDirectoryExists,{dirPath})
end function

public function IsFileExtension(sequence fName,sequence ext)
	return c_func(xIsFileExtension,{fName,ext})
end function

public function GetFileLength(sequence fName)
	return c_func(xGetFileLength,{fName})
end function

public function GetFileExtension(sequence fName)
	return c_func(xGetFileExtension,{fName})
end function

public function GetFileName(sequence filePath)
	return c_func(xGetFileName,{filePath})
end function

public function GetFileNameWithoutExt(sequence filePath)
	return c_func(xGetFileNameWithoutExt,{filePath})
end function

public function GetDirectoryPath(sequence filePath)
	return c_func(xGetDirectoryPath,{filePath})
end function

public function GetPrevDirectoryPath(sequence dirPath)
	return c_func(xGetPrevDirectoryPath,{dirPath})
end function

public function GetWorkingDirectory()
	return c_func(xGetWorkingDirectory,{})
end function

public function GetApplicationDirectory()
	return c_func(xGetApplicationDirectory,{})
end function

public function MakeDirectory(sequence dirPath)
	return c_func(xMakeDirectory,{dirPath})
end function

public function ChangeDirectory(sequence _dir)
	return c_func(xChangeDirectory,{_dir})
end function

public function IsPathFile(sequence path)
	return c_func(xIsPathFile,{path})
end function

public function IsFileNameValid(sequence fName)
	return c_func(xIsFileNameValid,{fName})
end function

public function LoadDirectoryFiles(sequence dirPath)
	return c_func(xLoadDirectoryFiles,{dirPath})
end function

public function LoadDirectoryFilesEx(sequence basePath,sequence filter,atom scanSubdirs)
	return c_func(xLoadDirectoryFilesEx,{basePath,filter,scanSubdirs})
end function

public procedure UnloadDirectoryFiles(sequence files)
	c_proc(xUnloadDirectoryFiles,{files})
end procedure

public function IsFileDropped()
	return c_func(xIsFileDropped,{})
end function

public function LoadDroppedFiles()
	return c_func(xLoadDroppedFiles,{})
end function

public procedure UnloadDroppedFiles(sequence files)
	c_proc(xUnloadDroppedFiles,{files})
end procedure

public function GetFileModTime(sequence fName)
	return c_func(xGetFileModTime,{fName})
end function

--Compression functions
public constant xCompressData = define_c_func(ray,"+CompressData",{C_POINTER,C_INT,C_POINTER},C_POINTER),
				xDecompressData = define_c_func(ray,"+DecompressData",{C_POINTER,C_INT,C_POINTER},C_POINTER),
				xEncodeDataBase64 = define_c_func(ray,"+EncodeDataBase64",{C_POINTER,C_INT,C_POINTER},C_POINTER),
				xDecodeDataBase64 = define_c_func(ray,"+DecodeDataBase64",{C_POINTER,C_POINTER},C_POINTER),
				xComputeCRC32 = define_c_func(ray,"+ComputeCRC32",{C_POINTER,C_INT},C_UINT),
				xComputeMD5 = define_c_func(ray,"+ComputeMD5",{C_POINTER,C_INT},C_POINTER),
				xComputeSHA1 = define_c_func(ray,"+ComputeSHA1",{C_POINTER,C_INT},C_POINTER)
				
public function CompressData(atom data,atom dataSize,atom compDataSize)
	return c_func(xCompressData,{data,dataSize,compDataSize})
end function

public function DecompressData(atom compData,atom compDataSize,atom dataSize)
	return c_func(xDecompressData,{compData,compDataSize,dataSize})
end function

public function EncodeDataBase64(atom data,atom dataSize,atom outputSize)
	return c_func(xEncodeDataBase64,{data,dataSize,outputSize})
end function

public function DecodeDataBase64(atom data,atom outputSize)
	return c_func(xDecodeDataBase64,{data,outputSize})
end function

public function ComputeCRC32(atom data,atom dataSize)
	return c_func(xComputeCRC32,{data,dataSize})
end function

public function ComputeMD5(atom data,atom dataSize)
	return c_func(xComputeMD5,{data,dataSize})
end function

public function ComputeSHA1(atom data,atom dataSize)
	return c_func(xComputeSHA1,{data,dataSize})
end function

--Automation event functions
public constant xLoadAutomationEventList = define_c_func(ray,"+LoadAutomationEventList",{C_STRING},AutomationEventList),
				xUnloadAutomationEventList = define_c_proc(ray,"+UnloadAutomationEventList",{AutomationEventList}),
				xExportAutomationEventList = define_c_func(ray,"+ExportAutomationEventList",{AutomationEventList,C_STRING},C_BOOL),
				xSetAutomationEventList = define_c_proc(ray,"+SetAutomationEventList",{C_POINTER}),
				xSetAutomationEventBaseFrame = define_c_proc(ray,"+SetAutomationEventBaseFrame",{C_INT}),
				xStartAutomationEventRecording = define_c_proc(ray,"+StartAutomationEventRecording",{}),
				xStopAutomationEventRecording = define_c_proc(ray,"+StopAutomationEventRecording",{}),
				xPlayAutomationEvent = define_c_proc(ray,"+PlayAutomationEvent",{AutomationEvent})
				
public function LoadAutomationEventList(sequence fName)
	return c_func(xLoadAutomationEventList,{fName})
end function

public procedure UnloadAutomationEventList(sequence list)
	c_proc(xUnloadAutomationEventList,{list})
end procedure

public function ExportAutomationEventList(sequence list,sequence fName)
	return c_func(xExportAutomationEventList,{list,fName})
end function

public procedure SetAutomationEventList(atom list)
	c_proc(xSetAutomationEventList,{list})
end procedure

public procedure SetAutomationEventBaseFrame(atom frame)
	c_proc(xSetAutomationEventBaseFrame,{frame})
end procedure

public procedure StartAutomationEventRecording()
	c_proc(xStartAutomationEventRecording,{})
end procedure

public procedure StopAutomationEventRecording()
	c_proc(xStopAutomationEventRecording,{})
end procedure

public procedure PlayAutomationEvent(sequence event)
	c_proc(xPlayAutomationEvent,{event})
end procedure

--Input functions: Keyboard
public constant xIsKeyPressed = define_c_func(ray,"+IsKeyPressed",{C_INT},C_BOOL),
				xIsKeyPressedRepeat = define_c_func(ray,"+IsKeyPressedRepeat",{C_INT},C_BOOL),
				xIsKeyDown = define_c_func(ray,"+IsKeyDown",{C_INT},C_BOOL),
				xIsKeyReleased = define_c_func(ray,"+IsKeyReleased",{C_INT},C_BOOL),
				xIsKeyUp = define_c_func(ray,"+IsKeyUp",{C_INT},C_BOOL),
				xGetKeyPressed = define_c_func(ray,"+GetKeyPressed",{},C_INT),
				xGetCharPressed = define_c_func(ray,"+GetCharPressed",{},C_INT),
				xSetExitKey = define_c_proc(ray,"+SetExitKey",{C_INT})
				
public function IsKeyPressed(atom key)
	return c_func(xIsKeyPressed,{key})
end function

public function IsKeyPressedRepeat(atom key)
	return c_func(xIsKeyPressedRepeat,{key})
end function

public function IsKeyDown(atom key)
	return c_func(xIsKeyDown,{key})
end function

public function IsKeyReleased(atom key)
	return c_func(xIsKeyReleased,{key})
end function

public function IsKeyUp(atom key)
	return c_func(xIsKeyUp,{key})
end function

public function GetKeyPressed()
	return c_func(xGetKeyPressed,{})
end function

public function GetCharPressed()
	return c_func(xGetCharPressed,{})
end function

public procedure SetExitKey(atom key)
	c_proc(xSetExitKey,{key})
end procedure

--Input functions: Gamepad
public constant xIsGamepadAvailable = define_c_func(ray,"+IsGamepadAvailable",{C_INT},C_BOOL),
				xGetGamepadName = define_c_func(ray,"+GetGamepadName",{C_INT},C_STRING),
				xIsGamepadButtonPressed = define_c_func(ray,"+IsGamepadButtonPressed",{C_INT,C_INT},C_BOOL),
				xIsGamepadButtonDown = define_c_func(ray,"+IsGamepadButtonDown",{C_INT,C_INT},C_BOOL),
				xIsGamepadButtonReleased = define_c_func(ray,"+IsGamepadButtonReleased",{C_INT,C_INT},C_BOOL),
				xIsGamepadButtonUp = define_c_func(ray,"+IsGamepadButtonUp",{C_INT,C_INT},C_BOOL),
				xGetGamepadButtonPressed = define_c_func(ray,"+GetGamepadButtonPressed",{},C_INT),
				xGetGamepadAxisCount = define_c_func(ray,"+GetGamepadAxisCount",{C_INT},C_INT),
				xGetGamepadAxisMovement = define_c_func(ray,"+GetGamepadAxisMovement",{C_INT,C_INT},C_FLOAT),
				xSetGamepadMappings = define_c_func(ray,"+SetGamepadMappings",{C_STRING},C_INT),
				xSetGamepadVibration = define_c_proc(ray,"+SetGamepadVibration",{C_INT,C_FLOAT,C_FLOAT,C_FLOAT})
				
public function IsGamepadAvailable(atom gamepad)
	return c_func(xIsGamepadAvailable,{gamepad})
end function

public function GetGamepadName(atom gamepad)
	return c_func(xGetGamepadName,{gamepad})
end function

public function IsGamepadButtonPressed(atom gamepad,atom button)
	return c_func(xIsGamepadButtonPressed,{gamepad,button})
end function

public function IsGamepadButtonDown(atom gamepad,atom button)
	return c_func(xIsGamepadButtonDown,{gamepad,button})
end function

public function IsGamepadButtonReleased(atom gamepad,atom button)
	return c_func(xIsGamepadButtonReleased,{gamepad,button})
end function

public function IsGamepadButtonUp(atom gamepad,atom button)
	return c_func(xIsGamepadButtonUp,{gamepad,button})
end function

public function GetGamepadButtonPressed()
	return c_func(xGetGamepadButtonPressed,{})
end function

public function GetGamepadAxisCount(atom gamepad)
	return c_func(xGetGamepadAxisCount,{gamepad})
end function

public function GetGamepadAxisMovement(atom gamepad,atom axis)
	return c_func(xGetGamepadAxisMovement,{gamepad,axis})
end function

public function SetGamepadMappings(sequence mappings)
	return c_func(xSetGamepadMappings,{mappings})
end function

public procedure SetGamepadVibration(atom gamepad,atom leftMotor,atom rightMotor,atom duration)
	c_proc(xSetGamepadVibration,{gamepad,leftMotor,rightMotor,duration})
end procedure

--Input functions: Mouse
public constant xIsMouseButtonPressed = define_c_func(ray,"+IsMouseButtonPressed",{C_INT},C_BOOL),
				xIsMouseButtonDown = define_c_func(ray,"+IsMouseButtonDown",{C_INT},C_BOOL),
				xIsMouseButtonReleased = define_c_func(ray,"+IsMouseButtonReleased",{C_INT},C_BOOL),
				xIsMouseButtonUp = define_c_func(ray,"+IsMouseButtonUp",{C_INT},C_BOOL),
				xGetMouseX = define_c_func(ray,"+GetMouseX",{},C_INT),
				xGetMouseY = define_c_func(ray,"+GetMouseY",{},C_INT),
				xGetMousePosition = define_c_func(ray,"+GetMousePosition",{},Vector2),
				xGetMouseDelta = define_c_func(ray,"+GetMouseDelta",{},Vector2),
				xSetMousePosition = define_c_proc(ray,"+SetMousePosition",{C_INT,C_INT}),
				xSetMouseOffset = define_c_proc(ray,"+SetMouseOffset",{C_INT,C_INT}),
				xSetMouseScale = define_c_proc(ray,"+SetMouseScale",{C_FLOAT,C_FLOAT}),
				xGetMouseWheelMove = define_c_func(ray,"+GetMouseWheelMove",{},C_FLOAT),
				xGetMouseWheelMoveV = define_c_func(ray,"+GetMouseWheelMoveV",{},Vector2),
				xSetMouseCursor = define_c_proc(ray,"+SetMouseCursor",{C_INT})
				
public function IsMouseButtonPressed(atom button)
	return c_func(xIsMouseButtonPressed,{button})
end function

public function IsMouseButtonDown(atom button)
	return c_func(xIsMouseButtonDown,{button})
end function

public function IsMouseButtonReleased(atom button)
	return c_func(xIsMouseButtonReleased,{button})
end function

public function IsMouseButtonUp(atom button)
	return c_func(xIsMouseButtonUp,{button})
end function

public function GetMouseX()
	return c_func(xGetMouseX,{})
end function

public function GetMouseY()
	return c_func(xGetMouseY,{})
end function

public function GetMousePosition()
	return c_func(xGetMousePosition,{})
end function

public function GetMouseDelta()
	return c_func(xGetMouseDelta,{})
end function

public procedure SetMousePosition(atom x,atom y)
	c_proc(xSetMousePosition,{x,y})
end procedure

public procedure SetMouseOffset(atom x,atom y)
	c_proc(xSetMouseOffset,{x,y})
end procedure

public procedure SetMouseScale(atom x,atom y)
	c_proc(xSetMouseScale,{x,y})
end procedure

public function GetMouseWheelMove()
	return c_func(xGetMouseWheelMove,{})
end function

public function GetMouseWheelMoveV()
	return c_func(xGetMouseWheelMoveV,{})
end function

public procedure SetMouseCursor(atom cursor)
	c_proc(xSetMouseCursor,{cursor})
end procedure

--Input functions: Touch
public constant xGetTouchX = define_c_func(ray,"+GetTouchX",{},C_INT),
				xGetTouchY = define_c_func(ray,"+GetTouchY",{},C_INT),
				xGetTouchPosition = define_c_func(ray,"+GetTouchPosition",{C_INT},Vector2),
				xGetTouchPointId = define_c_func(ray,"+GetTouchPointId",{C_INT},C_INT),
				xGetTouchPointCount = define_c_func(ray,"+GetTouchPointCount",{},C_INT)
				
public function GetTouchX()
	return c_func(xGetTouchX,{})
end function

public function GetTouchY()
	return c_func(xGetTouchY,{})
end function

public function GetTouchPosition(atom index)
	return c_func(xGetTouchPosition,{index})
end function

public function GetTouchPointId(atom index)
	return c_func(xGetTouchPointId,{index})
end function

public function GetTouchPointCount()
	return c_func(xGetTouchPointCount,{})
end function

--Gesture functions
public constant xSetGesturesEnabled = define_c_proc(ray,"+SetGesturesEnabled",{C_UINT}),
				xIsGestureDetected = define_c_func(ray,"+IsGestureDetected",{C_UINT},C_BOOL),
				xGetGestureDetected = define_c_func(ray,"+GetGestureDetected",{},C_INT),
				xGetGestureHoldDuration = define_c_func(ray,"+GetGestureHoldDuration",{},C_FLOAT),
				xGetGestureDragVector = define_c_func(ray,"+GetGestureDragVector",{},Vector2),
				xGetGestureDragAngle = define_c_func(ray,"+GetGestureDragAngle",{},C_FLOAT),
				xGetGesturePinchVector = define_c_func(ray,"+GetGesturePinchVector",{},Vector2),
				xGetGesturePinchAngle = define_c_func(ray,"+GetGesturePinchAngle",{},C_FLOAT)
				
public procedure SetGesturesEnabled(atom flags)
	c_proc(xSetGesturesEnabled,{flags})
end procedure

public function IsGestureDetected(atom gesture)
	return c_func(xIsGestureDetected,{gesture})
end function

public function GetGestureDetected()
	return c_func(xGetGestureDetected,{})
end function

public function GetGestureHoldDuration()
	return c_func(xGetGestureHoldDuration,{})
end function

public function GetGestureDragVector()
	return c_func(xGetGestureDragVector,{})
end function

public function GetGestureDragAngle()
	return c_func(xGetGestureDragAngle,{})
end function

public function GetGesturePinchVector()
	return c_func(xGetGesturePinchVector,{})
end function

public function GetGesturePinchAngle()
	return c_func(xGetGesturePinchAngle,{})
end function

--Camera functions
public constant xUpdateCamera = define_c_proc(ray,"+UpdateCamera",{C_POINTER,C_INT}),
				xUpdateCameraPro = define_c_proc(ray,"+UpdateCameraPro",{C_POINTER,Vector3,Vector3,C_FLOAT})
				
public procedure UpdateCamera(atom cam,atom mode)
	c_proc(xUpdateCameraPro,{cam,mode})
end procedure

public procedure UpdateCameraPro(atom cam,sequence movement,sequence rotation,atom zoom)
	c_proc(xUpdateCameraPro,{cam,movement,rotation,zoom})
end procedure

--Shape functions
public constant xSetShapesTexture = define_c_proc(ray,"+SetShapesTexture",{Texture2D,Rectangle}),
				xGetShapesTexture = define_c_func(ray,"+GetShapesTexture",{},Texture2D),
				xGetShapesTextureRectangle = define_c_func(ray,"+GetShapesTextureRectangle",{},Rectangle)
				
public procedure SetShapesTexture(sequence tex2D,sequence source)
	c_proc(xSetShapesTexture,{tex2D,source})
end procedure

public function GetShapesTexture()
	return c_func(xGetShapesTexture,{})
end function

public function GetShapesTextureRectangle()
	return c_func(xGetShapesTextureRectangle,{})
end function

--Basic shape drawing functions
public constant xDrawPixel = define_c_proc(ray,"+DrawPixel",{C_INT,C_INT,Color}),
				xDrawPixelV = define_c_proc(ray,"+DrawPixelV",{Vector2,Color}),
				xDrawLine = define_c_proc(ray,"+DrawLine",{C_INT,C_INT,C_INT,C_INT,Color}),
				xDrawLineV = define_c_proc(ray,"+DrawLineV",{Vector2,Vector2,Color}),
				xDrawLineEx = define_c_proc(ray,"+DrawLineEx",{Vector2,Vector2,C_FLOAT,Color}),
				xDrawLineStrip = define_c_proc(ray,"+DrawLineStrip",{C_POINTER,C_INT,Color}),
				xDrawLineBezier = define_c_proc(ray,"+DrawLineBezier",{Vector2,Vector2,C_FLOAT,Color}),
				xDrawCircle = define_c_proc(ray,"+DrawCircle",{C_INT,C_INT,C_FLOAT,Color}),
				xDrawCircleSector = define_c_proc(ray,"+DrawCircleSector",{Vector2,C_FLOAT,C_FLOAT,C_FLOAT,C_INT,Color}),
				xDrawCircleSectorLines = define_c_proc(ray,"+DrawCircleSectorLines",{Vector2,C_FLOAT,C_FLOAT,C_FLOAT,C_INT,Color}),
				xDrawCircleGradient = define_c_proc(ray,"+DrawCircleGradient",{C_INT,C_INT,C_FLOAT,Color,Color}),
				xDrawCircleV = define_c_proc(ray,"+DrawCircleV",{Vector2,C_FLOAT,Color}),
				xDrawCircleLines = define_c_proc(ray,"+DrawCircleLines",{C_INT,C_INT,C_FLOAT,Color}),
				xDrawCircleLinesV = define_c_proc(ray,"+DrawCircleLinesV",{Vector2,C_FLOAT,Color}),
				xDrawEllipse = define_c_proc(ray,"+DrawEllipse",{C_INT,C_INT,C_FLOAT,C_FLOAT,Color}),
				xDrawEllipseLines = define_c_proc(ray,"+DrawEllipseLines",{C_INT,C_INT,C_FLOAT,C_FLOAT,Color}),
				xDrawRing = define_c_proc(ray,"+DrawRing",{Vector2,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_INT,Color}),
				xDrawRingLines = define_c_proc(ray,"+DrawRingLines",{Vector2,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_INT,Color}),
				xDrawRectangle = define_c_proc(ray,"+DrawRectangle",{C_INT,C_INT,C_INT,C_INT,Color}),
				xDrawRectangleV = define_c_proc(ray,"+DrawRectangleV",{Vector2,Vector2,Color}),
				xDrawRectangleRec = define_c_proc(ray,"+DrawRectangleRec",{Rectangle,Color}),
				xDrawRectanglePro = define_c_proc(ray,"+DrawRectanglePro",{Rectangle,Vector2,C_FLOAT,Color}),
				xDrawRectangleGradientV = define_c_proc(ray,"+DrawRectangleGradientV",{C_INT,C_INT,C_INT,C_INT,Color,Color}),
				xDrawRectangleGradientH = define_c_proc(ray,"+DrawRectangleGradientH",{C_INT,C_INT,C_INT,C_INT,Color,Color}),
				xDrawRectangleGradientEx = define_c_proc(ray,"+DrawRectangleGradientEx",{Rectangle,Color,Color,Color,Color}),
				xDrawRectangleLines = define_c_proc(ray,"+DrawRectangleLines",{C_INT,C_INT,C_INT,C_INT,Color}),
				xDrawRectangleLinesEx = define_c_proc(ray,"+DrawRectangleLinesEx",{Rectangle,C_FLOAT,Color}),
				xDrawRectangleRounded = define_c_proc(ray,"+DrawRectangleRounded",{Rectangle,C_FLOAT,C_INT,Color}),
				xDrawRectangleRoundedLines = define_c_proc(ray,"+DrawRectangleRoundedLines",{Rectangle,C_FLOAT,C_INT,Color}),
				xDrawRectangleRoundedLinesEx = define_c_proc(ray,"+DrawRectangleRoundedLinesEx",{Rectangle,C_FLOAT,C_INT,C_FLOAT,Color}),
				xDrawTriangle = define_c_proc(ray,"+DrawTriangle",{Vector2,Vector2,Vector2,Color}),
				xDrawTriangleLines = define_c_proc(ray,"+DrawTriangleLines",{Vector2,Vector2,Vector2,Color}),
				xDrawTriangleFan = define_c_proc(ray,"+DrawTriangleFan",{C_POINTER,C_INT,Color}),
				xDrawTriangleStrip = define_c_proc(ray,"+DrawTriangleStrip",{C_POINTER,C_INT,Color}),
				xDrawPoly = define_c_proc(ray,"+DrawPoly",{Vector2,C_INT,C_FLOAT,C_FLOAT,Color}),
				xDrawPolyLines = define_c_proc(ray,"+DrawPolyLines",{Vector2,C_INT,C_FLOAT,C_FLOAT,Color}),
				xDrawPolyLinesEx = define_c_proc(ray,"+DrawPolyLinesEx",{Vector2,C_INT,C_FLOAT,C_FLOAT,C_FLOAT,Color})
				
public procedure DrawPixel(atom x,atom y,sequence color)
	c_proc(xDrawPixel,{x,y,color})
end procedure

public procedure DrawPixelV(sequence pos,sequence color)
	c_proc(xDrawPixelV,{pos,color})
end procedure

public procedure DrawLine(atom startX,atom startY,atom endX,atom endY,sequence color)
	c_proc(xDrawLine,{startX,startY,endX,endY,color})
end procedure

public procedure DrawLineV(sequence start,sequence endPos,sequence color)
	c_proc(xDrawLineV,{start,endPos,color})
end procedure

public procedure DrawLineEx(sequence start,sequence endPos,atom thick,sequence color)
	c_proc(xDrawLineEx,{start,endPos,thick,color})
end procedure

public procedure DrawLineStrip(atom points,atom count,sequence color)
	c_proc(xDrawLineStrip,{points,count,color})
end procedure

public procedure DrawLineBezier(sequence start,sequence endPos,atom thick,sequence color)
	c_proc(xDrawLineBezier,{start,endPos,thick,color})
end procedure

public procedure DrawCircle(atom x,atom y,atom radius,sequence color)
	c_proc(xDrawCircle,{x,y,radius,color})
end procedure

public procedure DrawCircleSector(sequence center,atom radius,atom start,atom endAngle,atom segments,sequence color)
	c_proc(xDrawCircleSector,{center,radius,start,endAngle,segments,color})
end procedure

public procedure DrawCircleSectorLines(sequence center,atom radius,atom start,atom endAngle,atom segments,sequence color)
	c_proc(xDrawCircleSectorLines,{center,radius,start,endAngle,segments,color})
end procedure

public procedure DrawCircleGradient(atom x,atom y,atom radius,sequence inner,sequence outer)
	c_proc(xDrawCircleGradient,{x,y,radius,inner,outer})
end procedure

public procedure DrawCircleV(sequence center,atom radius,sequence color)
	c_proc(xDrawCircleV,{center,radius,color})
end procedure

public procedure DrawCircleLines(atom x,atom y,atom radius,sequence color)
	c_proc(xDrawCircleLines,{x,y,radius,color})
end procedure

public procedure DrawCircleLinesV(sequence center,atom radius,sequence color)
	c_proc(xDrawCircleLinesV,{center,radius,color})
end procedure

public procedure DrawEllipse(atom x,atom y,atom radH,atom radV,sequence color)
	c_proc(xDrawEllipse,{x,y,radH,radV,color})
end procedure

public procedure DrawEllipseLines(atom x,atom y,atom radH,atom radV,sequence color)
	c_proc(xDrawEllipseLines,{x,y,radH,radV,color})
end procedure

public procedure DrawRing(sequence center,atom innerRad,atom outerRad,atom start,atom endAngle,atom segments,sequence color)
	c_proc(xDrawRing,{center,innerRad,outerRad,start,endAngle,segments,color})
end procedure

public procedure DrawRingLines(sequence center,atom innerRad,atom outerRad,atom start,atom endAngle,atom segments,sequence color)
	c_proc(xDrawRingLines,{center,innerRad,outerRad,start,endAngle,segments,color})
end procedure

public procedure DrawRectangle(atom x,atom y,atom width,atom height,sequence color)
	c_proc(xDrawRectangle,{x,y,width,height,color})
end procedure

public procedure DrawRectangleV(sequence pos,sequence size,sequence color)
	c_proc(xDrawRectangleV,{pos,size,color})
end procedure

public procedure DrawRectangleRec(sequence rec,sequence color)
	c_proc(xDrawRectangleRec,{rec,color})
end procedure

public procedure DrawRectanglePro(sequence rec,sequence origin,atom rotation,sequence color)
	c_proc(xDrawRectanglePro,{rec,origin,rotation,color})
end procedure

public procedure DrawRectangleGradientV(atom x,atom y,atom width,atom height,sequence top,sequence bottom)
	c_proc(xDrawRectangleGradientV,{x,y,width,height,top,bottom})
end procedure

public procedure DrawRectangleGradientH(atom x,atom y,atom width,atom height,sequence left,sequence right)
	c_proc(xDrawRectangleGradientH,{x,y,width,height,left,right})
end procedure

public procedure DrawRectangleGradientEx(sequence rec,sequence topLeft,sequence bottomLeft,sequence topRight,sequence bottomRight)
	c_proc(xDrawRectangleGradientEx,{rec,topLeft,bottomLeft,topRight,bottomRight})
end procedure

public procedure DrawRectangleLines(atom x,atom y,atom width,atom height,sequence color)
	c_proc(xDrawRectangleLines,{x,y,width,height,color})
end procedure

public procedure DrawRectangleLinesEx(sequence rec,atom thick,sequence color)
	c_proc(xDrawRectangleLinesEx,{rec,thick,color})
end procedure

public procedure DrawRectangleRounded(sequence rec,atom round,atom segments,sequence color)
	c_proc(xDrawRectangleRounded,{rec,round,segments,color})
end procedure

public procedure DrawRectangleRoundedLines(sequence rec,atom round,atom segments,sequence color)
	c_proc(xDrawRectangleRoundedLines,{rec,round,segments,color})
end procedure

public procedure DrawRectangleRoundedLinesEx(sequence rec,atom round,atom segments,atom thick,sequence color)
	c_proc(xDrawRectangleRoundedLinesEx,{rec,round,segments,thick,color})
end procedure

public procedure DrawTriangle(sequence v,sequence v2,sequence v3,sequence color)
	c_proc(xDrawTriangle,{v,v2,v3,color})
end procedure

public procedure DrawTriangleLines(sequence v,sequence v2,sequence v3,sequence color)
	c_proc(xDrawTriangleLines,{v,v2,v3,color})
end procedure

public procedure DrawTriangleFan(atom pts,atom count,sequence color)
	c_proc(xDrawTriangleFan,{pts,count,color})
end procedure

public procedure DrawTriangleStrip(atom pts,atom count,sequence color)
	c_proc(xDrawTriangleStrip,{pts,count,color})
end procedure

public procedure DrawPoly(sequence center,atom sides,atom radius,atom rotation,sequence color)
	c_proc(xDrawPoly,{center,sides,radius,rotation,color})
end procedure

public procedure DrawPolyLines(sequence center,atom sides,atom radius,atom rotation,sequence color)
	c_proc(xDrawPolyLines,{center,sides,radius,rotation,color})
end procedure

public procedure DrawPolyLinesEx(sequence center,atom sides,atom radius,atom rotation,atom thick,sequence color)
	c_proc(xDrawPolyLinesEx,{center,sides,radius,rotation,thick,color})
end procedure

--Spline drawing functions
public constant xDrawSplineLinear = define_c_proc(ray,"+DrawSplineLinear",{C_POINTER,C_INT,C_FLOAT,Color}),
				xDrawSplineBasis = define_c_proc(ray,"+DrawSplineBasis",{C_POINTER,C_INT,C_FLOAT,Color}),
				xDrawSplineCatmullRom = define_c_proc(ray,"+DrawSplineCatmullRom",{C_POINTER,C_INT,C_FLOAT,Color}),
				xDrawSplineBezierQuadratic = define_c_proc(ray,"+DrawSplineBezierQuadratic",{C_POINTER,C_INT,C_FLOAT,Color}),
				xDrawSplineBezierCubic = define_c_proc(ray,"+DrawSplineBezierCubic",{C_POINTER,C_INT,C_FLOAT,Color}),
				xDrawSplineSegmentLinear = define_c_proc(ray,"+DrawSplineSegmentLinear",{Vector2,Vector2,C_FLOAT,Color}),
				xDrawSplineSegmentBasis = define_c_proc(ray,"+DrawSplineSegmentBasis",{Vector2,Vector2,Vector2,Vector2,C_FLOAT,Color}),
				xDrawSplineSegmentCatmullRom = define_c_proc(ray,"+DrawSplineSegmentCatmullRom",{Vector2,Vector2,Vector2,Vector2,C_FLOAT,Color}),
				xDrawSplineSegmentBezierQuadratic = define_c_proc(ray,"+DrawSplineSegmentBezierQuadratic",{Vector2,Vector2,Vector2,C_FLOAT,Color}),
				xDrawSplineSegmentBezierCubic = define_c_proc(ray,"+DrawSplineSegmentBezierCubic",{Vector2,Vector2,Vector2,Vector2,C_FLOAT,Color})
				
public procedure DrawSplineLinear(atom pts,atom count,atom thick,sequence color)
	c_proc(xDrawSplineLinear,{pts,count,thick,color})
end procedure

public procedure DrawSplineBasis(atom pts,atom count,atom thick,sequence color)
	c_proc(xDrawSplineBasis,{pts,count,thick,color})
end procedure

public procedure DrawSplineCatmullRom(atom pts,atom count,atom thick,sequence color)
	c_proc(xDrawSplineCatmullRom,{pts,count,thick,color})
end procedure

public procedure DrawSplineBezierQuadratic(atom pts,atom count,atom thick,sequence color)
	c_proc(xDrawSplineBezierQuadratic,{pts,count,thick,color})
end procedure

public procedure DrawSplineBezierCubic(atom pts,atom count,atom thick,sequence color)
	c_proc(xDrawSplineBezierCubic,{pts,count,thick,color})
end procedure

public procedure DrawSplineSegmentLinear(sequence p1,sequence p2,atom thick,sequence color)
	c_proc(xDrawSplineSegmentLinear,{p1,p2,thick,color})
end procedure

public procedure DrawSplineSegmentBasis(sequence p1,sequence p2,sequence p3,sequence p4,atom thick,sequence color)
	c_proc(xDrawSplineSegmentBasis,{p1,p2,p3,p4,thick,color})
end procedure

public procedure DrawSplineSegmentCatmullRom(sequence p1,sequence p2,sequence p3,sequence p4,atom thick,sequence color)
	c_proc(xDrawSplineSegmentCatmullRom,{p1,p2,p3,p4,thick,color})
end procedure

public procedure DrawSplineSegmentBezierQuadratic(sequence p1,sequence p2,sequence p3,atom thick,sequence color)
	c_proc(xDrawSplineSegmentBezierQuadratic,{p1,p2,p3,thick,color})
end procedure

public procedure DrawSplineSegmentBezierCubic(sequence p1,sequence c2, sequence c3,sequence p4,atom thick,sequence color)
	c_proc(xDrawSplineSegmentBezierCubic,{p1,c2,c3,p4,thick,color})
end procedure

--Spline segment point evaluation functions
public constant xGetSplinePointLinear = define_c_func(ray,"+GetSplinePointLinear",{Vector2,Vector2,C_FLOAT},Vector2),
				xGetSplinePointBasis = define_c_func(ray,"+GetSplinePointBasis",{Vector2,Vector2,Vector2,Vector2,C_FLOAT},Vector2),
				xGetSplinePointCatmullRom = define_c_func(ray,"+GetSplinePointCatmullRom",{Vector2,Vector2,Vector2,Vector2,C_FLOAT},Vector2),
				xGetSplinePointBezierQuad = define_c_func(ray,"+GetSplinePointBezierQuad",{Vector2,Vector2,Vector2,C_FLOAT},Vector2),
				xGetSplinePointBezierCubic = define_c_func(ray,"+GetSplinePointBezierCubic",{Vector2,Vector2,Vector2,Vector2,C_FLOAT},Vector2)
				
public function GetSplinePointLinear(sequence start,sequence endPos,atom t)
	return c_func(xGetSplinePointLinear,{start,endPos,t})
end function

public function GetSplinePointBasis(sequence p1,sequence p2,sequence p3,sequence p4,atom t)
	return c_func(xGetSplinePointBasis,{p1,p2,p3,p4,t})
end function

public function GetSplinePointCatmullRom(sequence p1,sequence p2,sequence p3,sequence p4,atom t)
	return c_func(xGetSplinePointCatmullRom,{p1,p2,p3,p4,t})
end function

public function GetSplinePointBezierQuad(sequence p1,sequence c2,sequence p3,atom t)
	return c_func(xGetSplinePointBezierQuad,{p1,c2,p3,t})
end function

public function GetSplinePointBezierCubic(sequence p1,sequence c2,sequence c3,sequence p4,atom t)
	return c_func(xGetSplinePointBezierCubic,{p1,c2,c3,p4,t})
end function

--Shape collision detection functions
public constant xCheckCollisionRecs = define_c_func(ray,"+CheckCollisionRecs",{Rectangle,Rectangle},C_BOOL),
				xCheckCollisionCircles = define_c_func(ray,"+CheckCollisionCircles",{Vector2,C_FLOAT,Vector2,C_FLOAT},C_BOOL),
				xCheckCollisionCircleRec = define_c_func(ray,"+CheckCollisionCircleRec",{Vector2,C_FLOAT,Rectangle},C_BOOL),
				xCheckCollisionCircleLine = define_c_func(ray,"+CheckCollisionCircleLine",{Vector2,C_FLOAT,Vector2,Vector2},C_BOOL),
				xCheckCollisionPointRec = define_c_func(ray,"+CheckCollisionPointRec",{Vector2,Rectangle},C_BOOL),
				xCheckCollisionPointCircle = define_c_func(ray,"+CheckCollisionPointCircle",{Vector2,Vector2,C_FLOAT},C_BOOL),
				xCheckCollisionPointTriangle = define_c_func(ray,"+CheckCollisionPointTriangle",{Vector2,Vector2,Vector2,Vector2},C_BOOL),
				xCheckCollisionPointLine = define_c_func(ray,"+CheckCollisionPointLine",{Vector2,Vector2,Vector2,C_INT},C_BOOL),
				xCheckCollisionPointPoly = define_c_func(ray,"+CheckCollisionPointPoly",{Vector2,C_POINTER,C_INT},C_BOOL),
				xCheckCollisionLines = define_c_func(ray,"+CheckCollisionLines",{Vector2,Vector2,Vector2,Vector2,C_POINTER},C_BOOL),
				xGetCollisionRec = define_c_func(ray,"+GetCollisionRec",{Rectangle,Rectangle},Rectangle)
				
public function CheckCollisionRecs(sequence rec,sequence rec2)
	return c_func(xCheckCollisionRecs,{rec,rec2})
end function

public function CheckCollisionCircles(sequence center,atom rad,sequence center2,atom rad2)
	return c_func(xCheckCollisionCircles,{center,rad,center2,rad2})
end function

public function CheckCollisionCircleRec(sequence center,atom rad,sequence rec)
	return c_func(xCheckCollisionCircleRec,{center,rad,rec})
end function

public function CheckCollisionCircleLine(sequence center,atom rad,sequence p1,sequence p2)
	return c_func(xCheckCollisionCircleLine,{center,rad,p1,p2})
end function

public function CheckCollisionPointRec(sequence point,sequence rec)
	return c_func(xCheckCollisionPointRec,{point,rec})
end function

public function CheckCollisionPointCircle(sequence point,sequence center,atom rad)
	return c_func(xCheckCollisionPointCircle,{point,center,rad})
end function

public function CheckCollisionPointTriangle(sequence point,sequence p1,sequence p2,sequence p3)
	return c_func(xCheckCollisionPointTriangle,{point,p1,p2,p3})
end function

public function CheckCollisionPointLine(sequence point,sequence p1,sequence p2,atom threshold)
	return c_func(xCheckCollisionPointLine,{point,p1,p2,threshold})
end function

public function CheckCollisionPointPoly(sequence point,atom points,atom count)
	return c_func(xCheckCollisionPointPoly,{point,points,count})
end function

public function CheckCollisionLines(sequence start,sequence endpos,sequence start2,sequence pos2,atom cpoint)
	return c_func(xCheckCollisionLines,{start,endpos,start2,pos2,cpoint})
end function

public function GetCollisionRec(sequence rec,sequence rec2)
	return c_func(xGetCollisionRec,{rec,rec2})
end function

--Image loading functions
public constant xLoadImage = define_c_func(ray,"+LoadImage",{C_STRING},Image),
				xLoadImageRaw = define_c_func(ray,"+LoadImageRaw",{C_STRING,C_INT,C_INT,C_INT,C_INT},Image),
				xLoadImageAnim = define_c_func(ray,"+LoadImageAnim",{C_STRING,C_POINTER},Image),
				xLoadImageAnimFromMemory = define_c_func(ray,"+LoadImageAnimFromMemory",{C_STRING,C_POINTER,C_INT,C_POINTER},Image),
				xLoadImageFromMemory = define_c_func(ray,"+LoadImageFromMemory",{C_STRING,C_POINTER,C_INT},Image),
				xLoadImageFromTexture = define_c_func(ray,"+LoadImageFromTexture",{Texture2D},Image),
				xLoadImageFromScreen = define_c_func(ray,"+LoadImageFromScreen",{},Image),
				xIsImageValid = define_c_func(ray,"+IsImageValid",{Image},C_BOOL),
				xUnloadImage = define_c_proc(ray,"+UnloadImage",{Image}),
				xExportImage = define_c_func(ray,"+ExportImage",{Image,C_STRING},C_BOOL),
				xExportImageToMemory = define_c_func(ray,"+ExportImageToMemory",{Image,C_STRING,C_POINTER},C_POINTER),
				xExportImageAsCode = define_c_func(ray,"+ExportImageAsCode",{Image,C_STRING},C_BOOL)
				
public function LoadImage(sequence fName)
	return c_func(xLoadImage,{fName})
end function

public function LoadImageRaw(sequence fName,atom width,atom height,atom format,atom headerSize)
	return c_func(xLoadImageRaw,{fName,width,height,format,headerSize})
end function

public function LoadImageAnim(sequence fName,atom frames)
	return c_func(xLoadImageAnim,{fName,frames})
end function

public function LoadImageAnimFromMemory(sequence fileType,atom fileData,atom dataSize,atom frames)
	return c_func(xLoadImageAnimFromMemory,{fileType,fileData,dataSize,frames})
end function

public function LoadImageFromMemory(sequence fileType,atom fileData,atom dataSize)
	return c_func(xLoadImageFromMemory,{fileType,fileData,dataSize})
end function

public function LoadImageFromTexture(sequence tex)
	return c_func(xLoadImageFromTexture,{tex})
end function

public function LoadImageFromScreen()
	return c_func(xLoadImageFromScreen,{})
end function

public function IsImageValid(sequence image)
	return c_func(xIsImageValid,{image})
end function

public procedure UnloadImage(sequence image)
	c_proc(xUnloadImage,{image})
end procedure

public function ExportImage(sequence image,sequence fName)
	return c_func(xExportImage,{image,fName})
end function

public function ExportImageToMemory(sequence image,sequence fileType,atom fileSize)
	return c_func(xExportImageToMemory,{image,fileType,fileSize})
end function

public function ExportImageAsCode(sequence image,sequence fName)
	return c_func(xExportImageAsCode,{image,fName})
end function

--Image generation functions
public constant xGenImageColor = define_c_func(ray,"+GenImageColor",{C_INT,C_INT,Color},Image),
				xGenImageGradientLinear = define_c_func(ray,"+GenImageGradientLinear",{C_INT,C_INT,C_INT,Color,Color},Image),
				xGenImageGradientRadial = define_c_func(ray,"+GenImageGradientRadial",{C_INT,C_INT,C_FLOAT,Color,Color},Image),
				xGenImageGradientSquare = define_c_func(ray,"+GenImageGradientSquare",{C_INT,C_INT,C_FLOAT,Color,Color},Image),
				xGenImageChecked = define_c_func(ray,"+GenImageChecked",{C_INT,C_INT,C_INT,C_INT,Color,Color},Image),
				xGenImageWhiteNoise = define_c_func(ray,"+GenImageWhiteNoise",{C_INT,C_INT,C_FLOAT},Image),
				xGenImagePerlinNoise = define_c_func(ray,"+GenImagePerlinNoise",{C_INT,C_INT,C_INT,C_INT,C_FLOAT},Image),
				xGenImageCellular = define_c_func(ray,"+GenImageCellular",{C_INT,C_INT,C_INT},Image),
				xGenImageText = define_c_func(ray,"+GenImageText",{C_INT,C_INT,C_STRING},Image)
				
public function GenImageColor(atom width,atom height,sequence color)
	return c_func(xGenImageColor,{width,height,color})
end function

public function GenImageGradientLinear(atom width,atom height,atom direction,sequence start,sequence cend)
	return c_func(xGenImageGradientLinear,{width,height,direction,start,cend})
end function

public function GenImageGradientRadial(atom width,atom height,atom density,sequence inner,sequence outer)
	return c_func(xGenImageGradientRadial,{width,height,density,inner,outer})
end function

public function GenImageGradientSquare(atom width,atom height,atom density,sequence inner,sequence outer)
	return c_func(xGenImageGradientSquare,{width,height,density,inner,outer})
end function

public function GenImageChecked(atom width,atom height,atom x,atom y,sequence col,sequence col2)
	return c_func(xGenImageChecked,{width,height,x,y,col,col2})
end function

public function GenImageWhiteNoise(atom width,atom height,atom factor)
	return c_func(xGenImageWhiteNoise,{width,height,factor})	
end function

public function GenImagePerlinNoise(atom width,atom height,atom x,atom y,atom scale)
	return c_func(xGenImagePerlinNoise,{width,height,x,y,scale})
end function

public function GenImageCellular(atom width,atom height,atom tileSize)
	return c_func(xGenImageCellular,{width,height,tileSize})
end function

public function GenImageText(atom width,atom height,sequence text)
	return c_func(xGenImageText,{width,height,text})
end function

--Image manipulation functions
public constant xImageCopy = define_c_func(ray,"+ImageCopy",{Image},Image),
				xImageFromImage = define_c_func(ray,"+ImageFromImage",{Image,Rectangle},Image),
				xImageFromChannel = define_c_func(ray,"+ImageFromChannel",{Image,C_INT},Image),
				xImageText = define_c_func(ray,"+ImageText",{C_STRING,C_INT,Color},Image),
				xImageTextEx = define_c_func(ray,"+ImageTextEx",{Font,C_STRING,C_FLOAT,C_FLOAT,Color},Image),
				xImageFormat = define_c_proc(ray,"+ImageFormat",{C_POINTER,C_INT}),
				xImageToPOT = define_c_proc(ray,"+ImageToPOT",{C_POINTER,Color}),
				xImageCrop = define_c_proc(ray,"+ImageCrop",{C_POINTER,Rectangle}),
				xImageAlphaCrop = define_c_proc(ray,"+ImageAlphaCrop",{C_POINTER,C_FLOAT}),
				xImageAlphaClear = define_c_proc(ray,"+ImageAlphaClear",{C_POINTER,Color,C_FLOAT}),
				xImageAlphaMask = define_c_proc(ray,"+ImageAlphaMask",{C_POINTER,Image}),
				xImageAlphaPremultiply = define_c_proc(ray,"+ImageAlphaPremultiply",{C_POINTER}),
				xImageBlurGaussian = define_c_proc(ray,"+ImageBlurGaussian",{C_POINTER,C_INT}),
				xImageKernelConvolution = define_c_proc(ray,"+ImageKernelConvolution",{C_POINTER,C_POINTER,C_INT}),
				xImageResize = define_c_proc(ray,"+ImageResize",{C_POINTER,C_INT,C_INT}),
				xImageResizeNN = define_c_proc(ray,"+ImageResizeNN",{C_POINTER,C_INT,C_INT}),
				xImageResizeCanvas = define_c_proc(ray,"+ImageResizeCanvas",{C_POINTER,C_INT,C_INT,C_INT,C_INT,Color}),
				xImageMipmaps = define_c_proc(ray,"+ImageMipmaps",{C_POINTER}),
				xImageDither = define_c_proc(ray,"+ImageDither",{C_POINTER,C_INT,C_INT,C_INT,C_INT}),
				xImageFlipVertical = define_c_proc(ray,"+ImageFlipVertical",{C_POINTER}),
				xImageFlipHorizontal = define_c_proc(ray,"+ImageFlipHorizontal",{C_POINTER}),
				xImageRotate = define_c_proc(ray,"+ImageRotate",{C_POINTER,C_INT}),
				xImageRotateCW = define_c_proc(ray,"+ImageRotateCW",{C_POINTER}),
				xImageRotateCCW = define_c_proc(ray,"+ImageRotateCCW",{C_POINTER}),
				xImageColorTint = define_c_proc(ray,"+ImageColorTint",{C_POINTER,Color}),
				xImageColorInvert = define_c_proc(ray,"+ImageColorInvert",{C_POINTER}),
				xImageColorGrayscale = define_c_proc(ray,"+ImageColorGrayscale",{C_POINTER}),
				xImageColorContrast = define_c_proc(ray,"+ImageColorContrast",{C_POINTER,C_FLOAT}),
				xImageColorBrightness = define_c_proc(ray,"+ImageColorBrightness",{C_POINTER,C_INT}),
				xImageColorReplace = define_c_proc(ray,"+ImageColorReplace",{C_POINTER,Color,Color}),
				xLoadImageColors = define_c_func(ray,"+LoadImageColors",{Image},C_POINTER),
				xLoadImagePalette = define_c_func(ray,"+LoadImagePalette",{Image,C_INT,C_POINTER},C_POINTER),
				xUnloadImageColors = define_c_proc(ray,"+UnloadImageColors",{C_POINTER}),
				xUnloadImagePalette = define_c_proc(ray,"+UnloadImagePalette",{C_POINTER}),
				xGetImageAlphaBorder = define_c_func(ray,"+GetImageAlphaBorder",{Image,C_FLOAT},Rectangle),
				xGetImageColor = define_c_func(ray,"+GetImageColor",{Image,C_INT,C_INT},Color)
				
public function ImageCopy(sequence image)
	return c_func(xImageCopy,{image})
end function

public function ImageFromImage(sequence image,sequence rec)
	return c_func(xImageFromImage,{image,rec})
end function

public function ImageFromChannel(sequence image,atom selectChannel)
	return c_func(xImageFromChannel,{image,selectChannel})
end function

public function ImageText(sequence text,atom fontSize,sequence color)
	return c_func(xImageText,{text,fontSize,color})
end function

public function ImageTextEx(sequence font,sequence text,atom fontSize,atom space,sequence tint)
	return c_func(xImageTextEx,{font,text,fontSize,space,tint})
end function

public procedure ImageFormat(atom image,atom newFormat)
	c_proc(xImageFormat,{image,newFormat})
end procedure

public procedure ImageToPOT(atom image,sequence fill)
	c_proc(xImageToPOT,{image,fill})
end procedure

public procedure ImageCrop(atom image,sequence crop)
	c_proc(xImageCrop,{image,crop})
end procedure

public procedure ImageAlphaCrop(atom image,atom threshold)
	c_proc(xImageAlphaCrop,{image,threshold})
end procedure

public procedure ImageAlphaClear(atom image,sequence color,atom threshold)
	c_proc(xImageAlphaClear,{image,color,threshold})
end procedure

public procedure ImageAlphaMask(atom image,sequence mask)
	c_proc(xImageAlphaMask,{image,mask})
end procedure

public procedure ImageAlphaPremultiply(atom image)
	c_proc(xImageAlphaPremultiply,{image})
end procedure

public procedure ImageBlurGaussian(atom image,atom blurSize)
	c_proc(xImageBlurGaussian,{image,blurSize})
end procedure

public procedure ImageKernelConvolution(atom image,atom kernel,atom size)
	c_proc(xImageKernelConvolution,{image,kernel,size})
end procedure

public procedure ImageResize(atom image,atom width,atom height)
	c_proc(xImageResize,{image,width,height})
end procedure

public procedure ImageResizeNN(atom image,atom width,atom height)
	c_proc(xImageResizeNN,{image,width,height})
end procedure

public procedure ImageResizeCanvas(atom image,atom width,atom height,atom x,atom y,sequence fill)
	c_proc(xImageResizeCanvas,{image,width,height,x,y,fill})
end procedure

public procedure ImageMipmaps(atom image)
	c_proc(xImageMipmaps,{image})
end procedure

public procedure ImageDither(atom image,atom r,atom g,atom b,atom a)
	c_proc(xImageDither,{image,r,g,b,a})
end procedure

public procedure ImageFlipVertical(atom image)
	c_proc(xImageFlipVertical,{image})
end procedure

public procedure ImageFlipHorizontal(atom image)
	c_proc(xImageFlipHorizontal,{image})
end procedure

public procedure ImageRotate(atom image,atom degrees)
	c_proc(xImageRotate,{image,degrees})
end procedure

public procedure ImageRotateCW(atom image)
	c_proc(xImageRotateCW,{image})
end procedure

public procedure ImageRotateCCW(atom image)
	c_proc(xImageRotateCCW,{image})
end procedure

public procedure ImageColorTint(atom image,sequence color)
	c_proc(xImageColorTint,{image,color})
end procedure

public procedure ImageColorInvert(atom image)
	c_proc(xImageColorInvert,{image})
end procedure

public procedure ImageColorGrayscale(atom image)
	c_proc(xImageColorGrayscale,{image})
end procedure

public procedure ImageColorContrast(atom image,atom contrast)
	c_proc(xImageColorContrast,{image,contrast})
end procedure

public procedure ImageColorBrightness(atom image,atom bright)
	c_proc(xImageColorBrightness,{image,bright})
end procedure

public procedure ImageColorReplace(atom image,sequence color,sequence replace)
	c_proc(xImageColorReplace,{image,color,replace})
end procedure

public function LoadImageColors(sequence image)
	return c_func(xLoadImageColors,{image})
end function

public function LoadImagePalette(sequence image,atom size,atom count)
	return c_func(xLoadImagePalette,{image,size,count})
end function

public procedure UnloadImageColors(atom colors)
	c_proc(xUnloadImageColors,{colors})
end procedure

public procedure UnloadImagePalette(atom colors)
	c_proc(xUnloadImagePalette,{colors})
end procedure

public function GetImageAlphaBorder(sequence image,atom threshold)
	return c_func(xGetImageAlphaBorder,{image,threshold})
end function

public function GetImageColor(sequence image,atom x,atom y)
	return c_func(xGetImageColor,{image,x,y})
end function

--Image drawing functions
public constant xImageClearBackground = define_c_proc(ray,"+ImageClearBackground",{C_POINTER,Color}),
				xImageDrawPixel = define_c_proc(ray,"+ImageDrawPixel",{C_POINTER,C_INT,C_INT,Color}),
				xImageDrawPixelV = define_c_proc(ray,"+ImageDrawPixelV",{C_POINTER,Vector2,Color}),
				xImageDrawLine = define_c_proc(ray,"+ImageDrawLine",{C_POINTER,C_INT,C_INT,C_INT,C_INT,Color}),
				xImageDrawLineV = define_c_proc(ray,"+ImageDrawLineV",{C_POINTER,Vector2,Vector2,Color}),
				xImageDrawLineEx = define_c_proc(ray,"+ImageDrawLineEx",{C_POINTER,Vector2,Vector2,C_INT,Color}),
				xImageDrawCircle = define_c_proc(ray,"+ImageDrawCircle",{C_POINTER,C_INT,C_INT,C_INT,Color}),
				xImageDrawCircleV = define_c_proc(ray,"+ImageDrawCircleV",{C_POINTER,Vector2,C_INT,Color}),
				xImageDrawCircleLines = define_c_proc(ray,"+ImageDrawCircleLines",{C_POINTER,C_INT,C_INT,C_INT,Color}),
				xImageDrawCircleLinesV = define_c_proc(ray,"+ImageDrawCircleLinesV",{C_POINTER,Vector2,C_INT,Color}),
				xImageDrawRectangle = define_c_proc(ray,"+ImageDrawRectangle",{C_POINTER,C_INT,C_INT,C_INT,C_INT,Color}),
				xImageDrawRectangleV = define_c_proc(ray,"+ImageDrawRectangleV",{C_POINTER,Vector2,Vector2,Color}),
				xImageDrawRectangleRec = define_c_proc(ray,"+ImageDrawRectangleRec",{C_POINTER,Rectangle,Color}),
				xImageDrawRectangleLines = define_c_proc(ray,"+ImageDrawRectangleLines",{C_POINTER,Rectangle,C_INT,Color}),
				xImageDrawTriangle = define_c_proc(ray,"+ImageDrawTriangle",{C_POINTER,Vector2,Vector2,Vector2,Color}),
				xImageDrawTriangleEx = define_c_proc(ray,"+ImageDrawTriangleEx",{C_POINTER,Vector2,Vector2,Vector2,Color,Color,Color}),
				xImageDrawTriangleLines = define_c_proc(ray,"+ImageDrawTriangleLines",{C_POINTER,Vector2,Vector2,Vector2,Color}),
				xImageDrawTriangleFan = define_c_proc(ray,"+ImageDrawTriangleFan",{C_POINTER,C_POINTER,C_INT,Color}),
				xImageDrawTriangleStrip = define_c_proc(ray,"+ImageDrawTriangleStrip",{C_POINTER,C_POINTER,C_INT,Color}),
				xImageDraw = define_c_proc(ray,"+ImageDraw",{C_POINTER,Image,Rectangle,Rectangle,Color}),
				xImageDrawText = define_c_proc(ray,"+ImageDrawText",{C_POINTER,C_STRING,C_INT,C_INT,C_INT,Color}),
				xImageDrawTextEx = define_c_proc(ray,"+ImageDrawTextEx",{C_POINTER,Font,C_STRING,Vector2,C_FLOAT,C_FLOAT,Color})
				
public procedure ImageClearBackground(atom dst,sequence color)
	c_proc(xImageClearBackground,{dst,color})
end procedure

public procedure ImageDrawPixel(atom dst,atom x,atom y,sequence color)
	c_proc(xImageDrawPixel,{dst,x,y,color})
end procedure

public procedure ImageDrawPixelV(atom dst,sequence pos,sequence color)
	c_proc(xImageDrawPixelV,{dst,pos,color})
end procedure

public procedure ImageDrawLine(atom dst,atom x,atom y,atom endx,atom endy,sequence color)
	c_proc(xImageDrawLine,{dst,x,y,endx,endy,color})
end procedure

public procedure ImageDrawLineV(atom dst,sequence start,sequence e,sequence color)
	c_proc(xImageDrawLine,{dst,start,e,color})
end procedure

public procedure ImageDrawLineEx(atom dst,sequence start,sequence e,atom thick,sequence color)
	c_proc(xImageDrawLineEx,{dst,start,e,thick,color})
end procedure

public procedure ImageDrawCircle(atom dst,atom x,atom y,atom rad,sequence color)
	c_proc(xImageDrawCircle,{dst,x,y,rad,color})
end procedure

public procedure ImageDrawCircleV(atom dst,sequence center,atom rad,sequence color)
	c_proc(xImageDrawCircleV,{dst,center,rad,color})
end procedure

public procedure ImageDrawCircleLines(atom dst,atom x,atom y,atom rad,sequence color)
	c_proc(xImageDrawCircleLines,{dst,x,y,rad,color})
end procedure

public procedure ImageDrawCircleLinesV(atom dst,sequence center,atom rad,sequence color)
	c_proc(xImageDrawCircleLinesV,{dst,center,rad,color})
end procedure

public procedure ImageDrawRectangle(atom dst,atom x,atom y,atom width,atom height,sequence color)
	c_proc(xImageDrawRectangle,{dst,x,y,width,height,color})
end procedure

public procedure ImageDrawRectangleV(atom dst,sequence pos,sequence size,sequence color)
	c_proc(xImageDrawRectangleV,{dst,pos,size,color})
end procedure

public procedure ImageDrawRectangleRec(atom dst,sequence rec,sequence color)
	c_proc(xImageDrawRectangleRec,{dst,rec,color})
end procedure

public procedure ImageDrawRectangleLines(atom dst,sequence rec,atom thick,sequence color)
	c_proc(xImageDrawRectangleLines,{dst,rec,thick,color})
end procedure

public procedure ImageDrawTriangle(atom dst,sequence v,sequence v2,sequence v3,sequence color)
	c_proc(xImageDrawTriangle,{dst,v,v2,v3,color})
end procedure

public procedure ImageDrawTriangleEx(atom dst,sequence v,sequence v2,sequence v3,sequence c,sequence c2,sequence c3)
	c_proc(xImageDrawTriangleEx,{dst,v,v2,v3,c,c2,c3})
end procedure

public procedure ImageDrawTriangleLines(atom dst,sequence v,sequence v2,sequence v3,sequence color)
	c_proc(xImageDrawTriangleLines,{dst,v,v2,v3,color})
end procedure

public procedure ImageDrawTriangleFan(atom dst,atom points,atom count,sequence color)
	c_proc(xImageDrawTriangleFan,{dst,points,count,color})
end procedure

public procedure ImageDrawTriangleStrip(atom dst,atom points,atom count,sequence color)
	c_proc(xImageDrawTriangleStrip,{dst,points,count,color})
end procedure

public procedure ImageDraw(atom dst,sequence src,sequence srcRec,sequence dstRec,sequence tint)
	c_proc(xImageDraw,{dst,src,srcRec,dstRec,tint})
end procedure

public procedure ImageDrawText(atom dst,sequence text,atom x,atom y,atom size,sequence color)
	c_proc(xImageDrawText,{dst,text,x,y,size,color})
end procedure

public procedure ImageDrawTextEx(atom dst,sequence font,sequence text,sequence pos,atom size,atom space,sequence tint)
	c_proc(xImageDrawTextEx,{dst,font,text,pos,size,space,tint})
end procedure

--Texture loading functions
public constant xLoadTexture = define_c_func(ray,"+LoadTexture",{C_STRING},Texture2D),
				xLoadTextureFromImage = define_c_func(ray,"+LoadTextureFromImage",{Image},Texture2D),
				xLoadTextureCubemap = define_c_func(ray,"+LoadTextureCubemap",{Image,C_INT},TextureCubemap),
				xLoadRenderTexture = define_c_func(ray,"+LoadRenderTexture",{C_INT,C_INT},RenderTexture2D),
				xIsTextureValid = define_c_func(ray,"+IsTextureValid",{Texture2D},C_BOOL),
				xUnloadTexture = define_c_proc(ray,"+UnloadTexture",{Texture2D}),
				xIsRenderTextureValid = define_c_func(ray,"+IsRenderTextureValid",{RenderTexture2D},C_BOOL),
				xUnloadRenderTexture = define_c_proc(ray,"+UnloadRenderTexture",{RenderTexture2D}),
				xUpdateTexture = define_c_proc(ray,"+UpdateTexture",{Texture2D,C_POINTER}),
				xUpdateTextureRec = define_c_proc(ray,"+UpdateTextureRec",{Texture2D,Rectangle,C_POINTER})
				
public function LoadTexture(sequence fName)
	return c_func(xLoadTexture,{fName})
end function

public function LoadTextureFromImage(sequence image)
	return c_func(xLoadTextureFromImage,{image})
end function

public function LoadTextureCubemap(sequence image,atom layout)
	return c_func(xLoadTextureCubemap,{image,layout})
end function

public function LoadRenderTexture(atom width,atom height)
	return c_func(xLoadRenderTexture,{width,height})
end function

public function IsTextureValid(sequence tex)
	return c_func(xIsTextureValid,{tex})
end function

public procedure UnloadTexture(sequence tex)
	c_proc(xUnloadTexture,{tex})
end procedure

public function IsRenderTextureValid(sequence target)
	return c_func(xIsRenderTextureValid,{target})
end function

public procedure UnloadRenderTexture(sequence target)
	c_proc(xUnloadRenderTexture,{target})
end procedure

public procedure UpdateTexture(sequence tex,atom pixels)
	c_proc(xUpdateTexture,{tex,pixels})
end procedure

public procedure UpdateTextureRec(sequence tex,sequence rec,atom pixels)
	c_proc(xUpdateTextureRec,{tex,rec,pixels})
end procedure

--Texture config functions
public constant xGenTextureMipmaps = define_c_proc(ray,"+GenTextureMipmaps",{C_POINTER}),
				xSetTextureFilter = define_c_proc(ray,"+SetTextureFilter",{Texture2D,C_INT}),
				xSetTextureWrap = define_c_proc(ray,"+SetTextureWrap",{Texture2D,C_INT})
				
public procedure GenTextureMipmaps(atom tex)
	c_proc(xGenTextureMipmaps,{tex})
end procedure

public procedure SetTextureFilter(sequence tex,atom filter)
	c_proc(xSetTextureFilter,{tex,filter})
end procedure

public procedure SetTextureWrap(sequence tex,atom wrap)
	c_proc(xSetTextureWrap,{tex,wrap})
end procedure

--Texture drawing functions
public constant xDrawTexture = define_c_proc(ray,"+DrawTexture",{Texture2D,C_INT,C_INT,Color}),
				xDrawTextureV = define_c_proc(ray,"+DrawTextureV",{Texture2D,Vector2,Color}),
				xDrawTextureEx = define_c_proc(ray,"+DrawTextureEx",{Texture2D,Vector2,C_FLOAT,C_FLOAT,Color}),
				xDrawTextureRec = define_c_proc(ray,"+DrawTextureRec",{Texture2D,Rectangle,Vector2,Color}),
				xDrawTexturePro = define_c_proc(ray,"+DrawTexturePro",{Texture2D,Rectangle,Rectangle,Vector2,C_FLOAT,Color}),
				xDrawTextureNPatch = define_c_proc(ray,"+DrawTextureNPatch",{Texture2D,NPatchInfo,Rectangle,Vector2,C_FLOAT,Color})
				
public procedure DrawTexture(sequence tex,atom x,atom y,sequence tint)
	c_proc(xDrawTexture,{tex,x,y,tint})
end procedure

public procedure DrawTextureV(sequence tex,sequence pos,sequence tint)
	c_proc(xDrawTextureV,{tex,pos,tint})
end procedure

public procedure DrawTextureEx(sequence tex,sequence pos,atom rotation,atom scale,sequence tint)
	c_proc(xDrawTextureEx,{tex,pos,rotation,scale,tint})
end procedure

public procedure DrawTextureRec(sequence tex,sequence source,sequence pos,sequence tint)
	c_proc(xDrawTextureRec,{tex,source,pos,tint})
end procedure

public procedure DrawTexturePro(sequence tex,sequence source,sequence dst,sequence origin,atom rotation,sequence tint)
	c_proc(xDrawTexturePro,{tex,source,dst,origin,rotation,tint})
end procedure

public procedure DrawTextureNPatch(sequence tex,sequence patch,sequence dst,sequence origin,atom rotation,sequence tint)
	c_proc(xDrawTextureNPatch,{tex,patch,dst,origin,rotation,tint})
end procedure

--Color/pixel functions
public constant xColorIsEqual = define_c_func(ray,"+ColorIsEqual",{Color,Color},C_BOOL),
				xFade = define_c_func(ray,"+Fade",{Color,C_FLOAT},Color),
				xColorToInt = define_c_func(ray,"+ColorToInt",{Color},C_INT),
				xColorNormalize = define_c_func(ray,"+ColorNormalize",{Color},Vector4),
				xColorFromNormalized = define_c_func(ray,"+ColorFromNormalized",{Vector4},Color),
				xColorToHSV = define_c_func(ray,"+ColorToHSV",{Color},Vector3),
				xColorFromHSV = define_c_func(ray,"+ColorFromHSV",{C_FLOAT,C_FLOAT,C_FLOAT},Color),
				xColorTint = define_c_func(ray,"+ColorTint",{Color,Color},Color),
				xColorBrightness = define_c_func(ray,"+ColorBrightness",{Color,C_FLOAT},Color),
				xColorContrast = define_c_func(ray,"+ColorContrast",{Color,C_FLOAT},Color),
				xColorAlpha = define_c_func(ray,"+ColorAlpha",{Color,C_FLOAT},Color),
				xColorAlphaBlend = define_c_func(ray,"+ColorAlphaBlend",{Color,Color,Color},Color),
				xColorLerp = define_c_func(ray,"+ColorLerp",{Color,Color,C_FLOAT},Color),
				xGetColor = define_c_func(ray,"+GetColor",{C_UINT},Color),
				xGetPixelColor = define_c_func(ray,"+GetPixelColor",{C_POINTER,C_INT},Color),
				xSetPixelColor = define_c_proc(ray,"+SetPixelColor",{C_POINTER,Color,C_INT}),
				xGetPixelDataSize = define_c_func(ray,"+GetPixelDataSize",{C_INT,C_INT,C_INT},C_INT)
				
public function ColorIsEqual(sequence col,sequence col2)
	return c_func(xColorIsEqual,{col,col2})
end function

public function Fade(sequence col,atom alpha)
	return c_func(xFade,{col,alpha})
end function

public function ColorToInt(sequence col)
	return c_func(xColorToInt,{col})
end function

public function ColorNormalize(sequence col)
	return c_func(xColorNormalize,{col})
end function

public function ColorFromNormalized(sequence norm)
	return c_func(xColorFromNormalized,{norm})
end function

public function ColorToHSV(sequence col)
	return c_func(xColorToHSV,{col})
end function

public function ColorFromHSV(atom hue,atom saturation,atom val)
	return c_func(xColorFromHSV,{hue,saturation,val})
end function

public function ColorTint(sequence col,sequence tint)
	return c_func(xColorTint,{col,tint})
end function

public function ColorBrightness(sequence col,atom factor)
	return c_func(xColorBrightness,{col,factor})
end function

public function ColorContrast(sequence col,atom contrast)
	return c_func(xColorContrast,{col,contrast})
end function

public function ColorAlpha(sequence col,atom alpha)
	return c_func(xColorAlpha,{col,alpha})
end function

public function ColorAlphaBlend(sequence dst,sequence src,sequence tint)
	return c_func(xColorAlphaBlend,{dst,src,tint})
end function

public function ColorLerp(sequence col,sequence col2,atom factor)
	return c_func(xColorLerp,{col,col2,factor})
end function

public function GetColor(atom hex)
	return c_func(xGetColor,{hex})
end function

public function GetPixelColor(atom ptr,atom format)
	return c_func(xGetPixelColor,{ptr,format})
end function

public procedure SetPixelColor(atom ptr,sequence col,atom format)
	c_proc(xSetPixelColor,{ptr,col,format})
end procedure

public function GetPixelDataSize(atom width,atom height,atom format)
	return c_func(xGetPixelDataSize,{width,height,format})
end function

--Font loading functions
public constant xGetFontDefault = define_c_func(ray,"+GetFontDefault",{},Font),
				xLoadFont = define_c_func(ray,"+LoadFont",{C_STRING},Font),
				xLoadFontEx = define_c_func(ray,"+LoadFontEx",{C_STRING,C_INT,C_POINTER,C_INT},Font),
				xLoadFontFromImage = define_c_func(ray,"+LoadFontFromImage",{Image,Color,C_INT},Font),
				xLoadFontFromMemory = define_c_func(ray,"+LoadFontFromMemory",{C_STRING,C_POINTER,C_INT,C_INT,C_POINTER,C_INT},Font),
				xIsFontValid = define_c_func(ray,"+IsFontValid",{Font},C_BOOL),
				xLoadFontData = define_c_func(ray,"+LoadFontData",{C_POINTER,C_INT,C_INT,C_POINTER,C_INT,C_INT},C_POINTER),
				xGenImageFontAtlas = define_c_func(ray,"+GenImageFontAtlas",{C_POINTER,C_POINTER,C_INT,C_INT,C_INT,C_INT},Image),
				xUnloadFontData = define_c_proc(ray,"+UnloadFontData",{C_POINTER,C_INT}),
				xUnloadFont = define_c_proc(ray,"+UnloadFont",{Font}),
				xExportFontAsCode = define_c_func(ray,"+ExportFontAsCode",{Font,C_STRING},C_BOOL)
				
public function GetFontDefault()
	return c_func(xGetFontDefault,{})
end function

public function LoadFont(sequence fName)
	return c_func(xLoadFont,{fName})
end function

public function LoadFontEx(sequence fName,atom size,atom points,atom count)
	return c_func(xLoadFontEx,{fName,size,points,count})
end function

public function LoadFontFromImage(sequence image,sequence key,atom firstchar)
	return c_func(xLoadFontFromImage,{image,key,firstchar})
end function

public function LoadFontFromMemory(sequence fileType,atom data,atom size,atom fontSize,atom points,atom count)
	return c_func(xLoadFontFromMemory,{fileType,data,size,fontSize,points,count})
end function

public function IsFontValid(sequence font)
	return c_func(xIsFontValid,{font})
end function

public function LoadFontData(atom fileData,atom size,atom fontSize,atom points,atom count,atom _type)
	return c_func(xLoadFontData,{fileData,size,fontSize,points,count,_type})
end function

public function GenImageFontAtlas(atom glyphs,atom recs,atom count,atom size,atom pad,atom pack)
	return c_func(xGenImageFontAtlas,{glyphs,recs,count,size,pad,pack})
end function

public procedure UnloadFontData(atom glyphs,atom count)
	c_proc(xUnloadFontData,{glyphs,count})
end procedure

public procedure UnloadFont(sequence font)
	c_proc(xUnloadFont,{font})
end procedure

public function ExportFontAsCode(sequence font,sequence fName)
	return c_func(xExportFontAsCode,{font,fName})
end function

--Text drawing functions
public constant xDrawFPS = define_c_proc(ray,"+DrawFPS",{C_INT,C_INT}),
				xDrawText = define_c_proc(ray,"+DrawText",{C_STRING,C_INT,C_INT,C_INT,Color}),
				xDrawTextEx = define_c_proc(ray,"+DrawTextEx",{Font,C_STRING,Vector2,C_FLOAT,C_FLOAT,Color}),
				xDrawTextPro = define_c_proc(ray,"+DrawTextPro",{Font,C_STRING,Vector2,Vector2,C_FLOAT,C_FLOAT,C_FLOAT,Color}),
				xDrawTextCodepoint = define_c_proc(ray,"+DrawTextCodepoint",{Font,C_INT,Vector2,C_FLOAT,Color}),
				xDrawTextCodepoints = define_c_proc(ray,"+DrawTextCodepoints",{Font,C_POINTER,C_INT,Vector2,C_FLOAT,C_FLOAT,Color})
				
public procedure DrawFPS(atom x,atom y)
	c_proc(xDrawFPS,{x,y})
end procedure

public procedure DrawText(sequence text,atom x,atom y,atom fontSize,sequence color)
	c_proc(xDrawText,{text,x,y,fontSize,color})
end procedure

public procedure DrawTextEx(atom font,sequence text,sequence pos,atom fontSize,atom space,sequence tint)
	c_proc(xDrawTextEx,{font,text,pos,fontSize,space,tint})
end procedure

public procedure DrawTextPro(atom font,sequence text,sequence pos,sequence origin,atom rotation,atom fontSize,atom space,sequence tint)
	c_proc(xDrawTextPro,{font,text,pos,origin,rotation,fontSize,space,tint})
end procedure

public procedure DrawTextCodepoint(atom font,atom codepoint,sequence pos,atom fontSize,sequence tint)
	c_proc(xDrawTextCodepoint,{font,codepoint,pos,fontSize,tint})
end procedure

public procedure DrawTextCodepoints(atom font,atom codepoints,atom count,sequence pos,atom fontSize,atom space,sequence tint)
	c_proc(xDrawTextCodepoints,{font,codepoints,count,pos,fontSize,space,tint})
end procedure

--Text font info functions
public constant xSetTextLineSpacing = define_c_proc(ray,"+SetTextLineSpacing",{C_INT}),
				xMeasureText = define_c_func(ray,"+MeasureText",{C_STRING,C_INT},C_INT),
				xMeasureTextEx = define_c_func(ray,"+MeasureTextEx",{Font,C_STRING,C_FLOAT,C_FLOAT},Vector2),
				xGetGlyphIndex = define_c_func(ray,"+GetGlyphIndex",{Font,C_INT},C_INT),
				xGetGlyphInfo = define_c_func(ray,"+GetGlyphInfo",{Font,C_INT},GlyphInfo),
				xGetGlyphAtlasRec = define_c_func(ray,"+GetGlyphAtlasRec",{Font,C_INT},Rectangle)
				
public procedure SetTextLineSpacing(atom space)
	c_proc(xSetTextLineSpacing,{space})
end procedure

public function MeasureText(sequence text,atom size)
	return c_func(xMeasureText,{text,size})
end function

public function MeasureTextEx(sequence font,sequence text,atom size,atom space)
	return c_func(xMeasureTextEx,{font,text,size,space})
end function

public function GetGlyphIndex(sequence font,atom cpoint)
	return c_func(xGetGlyphIndex,{font,cpoint})	
end function

public function GetGlyphInfo(sequence font,atom cpoint)
	return c_func(xGetGlyphInfo,{font,cpoint})
end function

public function GetGlyphAtlasRec(sequence font,atom cpoint)
	return c_func(xGetGlyphAtlasRec,{font,cpoint})
end function

--Text codepoint functions
public constant xLoadUTF8 = define_c_func(ray,"+LoadUTF8",{C_POINTER,C_INT},C_STRING),
				xUnloadUTF8 = define_c_proc(ray,"+UnloadUTF8",{C_STRING}),
				xLoadCodepoints = define_c_func(ray,"+LoadCodepoints",{C_STRING,C_POINTER},C_POINTER),
				xUnloadCodepoints = define_c_proc(ray,"+UnloadCodepoints",{C_POINTER}),
				xGetCodepointCount = define_c_func(ray,"+GetCodepointCount",{C_STRING},C_INT),
				xGetCodepoint = define_c_func(ray,"+GetCodepoint",{C_STRING,C_POINTER},C_INT),
				xGetCodepointNext = define_c_func(ray,"+GetCodepointNext",{C_STRING,C_POINTER},C_INT),
				xGetCodepointPrevious = define_c_func(ray,"+GetCodepointPrevious",{C_STRING,C_POINTER},C_INT),
				xCodepointToUTF8 = define_c_func(ray,"+CodepointToUTF8",{C_INT,C_POINTER},C_STRING)
				
public function LoadUTF8(atom points,atom len)
	return c_func(xLoadUTF8,{points,len})
end function

public procedure UnloadUTF8(sequence text)
	c_proc(xUnloadUTF8,{text})
end procedure

public function LoadCodepoints(sequence text,atom count)
	return c_func(xLoadCodepoints,{text,count})
end function

public procedure UnloadCodepoints(atom points)
	c_proc(xUnloadCodepoints,{points})
end procedure

public function GetCodepointCount(sequence text)
	return c_func(xGetCodepointCount,{text})
end function

public function GetCodepoint(sequence text,atom size)
	return c_func(xGetCodepoint,{text,size})
end function

public function GetCodepointNext(sequence text,atom size)
	return c_func(xGetCodepointNext,{text,size})
end function

public function GetCodepointPrevious(sequence text,atom size)
	return c_func(xGetCodepointPrevious,{text,size})
end function

public function CodepointToUTF8(atom point,atom size)
	return c_func(xCodepointToUTF8,{point,size})
end function

--Text string management functions
public constant xTextCopy = define_c_func(ray,"+TextCopy",{C_POINTER,C_STRING},C_INT),
				xTextIsEqual = define_c_func(ray,"+TextIsEqual",{C_STRING,C_STRING},C_BOOL),
				xTextLength = define_c_func(ray,"+TextLength",{C_STRING},C_UINT),
				xTextFormat = define_c_func(ray,"+TextFormat",{C_STRING,C_POINTER},C_STRING),
				xTextSubtext = define_c_func(ray,"+TextSubtext",{C_STRING,C_INT,C_INT},C_STRING),
				xTextReplace = define_c_func(ray,"+TextReplace",{C_STRING,C_STRING,C_STRING},C_STRING),
				xTextInsert = define_c_func(ray,"+TextInsert",{C_STRING,C_STRING,C_INT},C_STRING),
				xTextJoin = define_c_func(ray,"+TextJoin",{C_STRING,C_INT,C_STRING},C_STRING),
				xTextSplit = define_c_func(ray,"+TextSplit",{C_STRING,C_CHAR,C_POINTER},C_STRING),
				xTextAppend = define_c_proc(ray,"+TextAppend",{C_STRING,C_STRING,C_POINTER}),
				xTextFindIndex = define_c_func(ray,"+TextFindIndex",{C_STRING,C_STRING},C_INT),
				xTextToUpper = define_c_func(ray,"+TextToUpper",{C_STRING},C_STRING),
				xTextToLower = define_c_func(ray,"+TextToLower",{C_STRING},C_STRING),
				xTextToPascal = define_c_func(ray,"+TextToPascal",{C_STRING},C_STRING),
				xTextToSnake = define_c_func(ray,"+TextToSnake",{C_STRING},C_STRING),
				xTextToCamel = define_c_func(ray,"+TextToCamel",{C_STRING},C_STRING)
				
public function TextCopy(object dst,sequence src)
	return c_func(xTextCopy,{dst,src})
end function

public function TextIsEqual(sequence text,sequence text2)
	return c_func(xTextIsEqual,{text,text2})
end function

public function TextLength(sequence text)
	return c_func(xTextLength,{text})
end function

public function TextFormat(sequence text,object x)
	return c_func(xTextFormat,{text,x})
end function

public function TextSubtext(sequence text,atom pos,atom len)
	return c_func(xTextSubtext,{text,pos,len})
end function

public function TextReplace(sequence text,sequence replace,sequence _by)
	return c_func(xTextReplace,{text,replace,_by})
end function

public function TextInsert(sequence text,sequence insert,atom pos)
	return c_func(xTextInsert,{text,insert,pos})
end function

public function TextJoin(sequence text,atom count,sequence del)
	return c_func(xTextJoin,{text,count,del})
end function

public function TextSplit(sequence text,sequence del,atom count)
	return c_func(xTextSplit,{text,del,count})
end function

public procedure TextAppend(sequence text,sequence app,atom pos)
	c_proc(xTextAppend,{text,app,pos})
end procedure

public function TextFindIndex(sequence text,sequence _find)
	return c_func(xTextFindIndex,{text,_find})
end function

public function TextToUpper(sequence text)
	return c_func(xTextToUpper,{text})
end function

public function TextToLower(sequence text)
	return c_func(xTextToLower,{text})
end function

public function TextToPascal(sequence text)
	return c_func(xTextToPascal,{text})
end function

public function TextToSnake(sequence text)
	return c_func(xTextToSnake,{text})
end function

public function TextToCamel(sequence text)
	return c_func(xTextToCamel,{text})
end function

public constant xTextToInteger = define_c_func(ray,"+TextToInteger",{C_STRING},C_INT),
				xTextToFloat = define_c_func(ray,"+TextToFloat",{C_STRING},C_FLOAT)
				
public function TextToInteger(sequence text)
	return c_func(xTextToInteger,{text})
end function

public function TextToFloat(sequence text)
	return c_func(xTextToFloat,{text})
end function

--3D shape drawing functions
public constant xDrawLine3D = define_c_proc(ray,"+DrawLine3D",{Vector3,Vector3,Color}),
				xDrawPoint3D = define_c_proc(ray,"+DrawPoint3D",{Vector3,Color}),
				xDrawCircle3D = define_c_proc(ray,"+DrawCircle3D",{Vector3,C_FLOAT,Vector3,C_FLOAT,Color}),
				xDrawTriangle3D = define_c_proc(ray,"+DrawTriangle3D",{Vector3,Vector3,Vector3,Color}),
				xDrawTriangleStrip3D = define_c_proc(ray,"+DrawTriangleStrip3D",{C_POINTER,C_INT,Color}),
				xDrawCube = define_c_proc(ray,"+DrawCube",{Vector3,C_FLOAT,C_FLOAT,C_FLOAT,Color}),
				xDrawCubeV = define_c_proc(ray,"+DrawCubeV",{Vector3,Vector3,Color}),
				xDrawCubeWires = define_c_proc(ray,"+DrawCubeWires",{Vector3,C_FLOAT,C_FLOAT,C_FLOAT,Color}),
				xDrawCubeWiresV = define_c_proc(ray,"+DrawCubeWiresV",{Vector3,Vector3,Color}),
				xDrawSphere = define_c_proc(ray,"+DrawSphere",{Vector3,C_FLOAT,Color}),
				xDrawSphereEx = define_c_proc(ray,"+DrawSphereEx",{Vector3,C_FLOAT,C_INT,C_INT,Color}),
				xDrawSphereWires = define_c_proc(ray,"+DrawSphereWires",{Vector3,C_FLOAT,C_INT,C_INT,Color}),
				xDrawCylinder = define_c_proc(ray,"+DrawCylinder",{Vector3,C_FLOAT,C_FLOAT,C_FLOAT,C_INT,Color}),
				xDrawCylinderEx = define_c_proc(ray,"+DrawCylinderEx",{Vector3,Vector3,C_FLOAT,C_FLOAT,C_INT,Color}),
				xDrawCylinderWires = define_c_proc(ray,"+DrawCylinderWires",{Vector3,C_FLOAT,C_FLOAT,C_FLOAT,C_INT,Color}),
				xDrawCylinderWiresEx = define_c_proc(ray,"+DrawCylinderWiresEx",{Vector3,Vector3,C_FLOAT,C_FLOAT,C_INT,Color}),
				xDrawCapsule = define_c_proc(ray,"+DrawCapsule",{Vector3,Vector3,C_FLOAT,C_INT,C_INT,Color}),
				xDrawCapsuleWires = define_c_proc(ray,"+DrawCapsuleWires",{Vector3,Vector3,C_FLOAT,C_INT,C_INT,Color}),
				xDrawPlane = define_c_proc(ray,"+DrawPlane",{Vector3,Vector2,Color}),
				xDrawRay = define_c_proc(ray,"+DrawRay",{Ray,Color}),
				xDrawGrid = define_c_proc(ray,"+DrawGrid",{C_INT,C_FLOAT})
				
public procedure DrawLine3D(sequence start,sequence ep,sequence col)
	c_proc(xDrawLine3D,{start,ep,col})
end procedure

public procedure DrawPoint3D(sequence pos,sequence col)
	c_proc(xDrawPoint3D,{pos,col})
end procedure

public procedure DrawCircle3D(sequence center,atom rad,sequence rotaxis,atom rotang,sequence col)
	c_proc(xDrawCircle3D,{center,rad,rotaxis,rotang,col})
end procedure

public procedure DrawTriangle3D(sequence v,sequence v2,sequence v3,sequence col)
	c_proc(xDrawTriangle3D,{v,v2,v3,col})
end procedure

public procedure DrawTriangleStrip3D(atom pts,atom count,sequence col)
	c_proc(xDrawTriangleStrip3D,{pts,count,col})
end procedure

public procedure DrawCube(sequence pos,atom width,atom height,atom len,sequence col)
	c_proc(xDrawCube,{pos,width,height,len,col})
end procedure

public procedure DrawCubeV(sequence pos,sequence size,sequence col)
	c_proc(xDrawCubeV,{pos,size,col})
end procedure

public procedure DrawCubeWires(sequence pos,atom width,atom height,atom len,sequence col)
	c_proc(xDrawCubeWires,{pos,width,height,len,col})
end procedure

public procedure DrawCubeWiresV(sequence pos,sequence size,sequence col)
	c_proc(xDrawCubeWiresV,{pos,size,col})
end procedure

public procedure DrawSphere(sequence pos,atom rad,sequence col)
	c_proc(xDrawSphere,{pos,rad,col})
end procedure

public procedure DrawSphereEx(sequence pos,atom rad,atom rings,atom slices,sequence col)
	c_proc(xDrawSphereEx,{pos,rad,rings,slices,col})
end procedure

public procedure DrawSphereWires(sequence pos,atom rad,atom rings,atom slices,sequence col)
	c_proc(xDrawSphereWires,{pos,rad,rings,slices,col})
end procedure

public procedure DrawCylinder(sequence pos,atom radtop,atom radbot,atom height,atom slices,sequence col)
	c_proc(xDrawCylinder,{pos,radtop,radbot,height,slices,col})
end procedure

public procedure DrawCylinderEx(sequence start,sequence ep,atom startrad,atom endrad,atom sides,sequence col)
	c_proc(xDrawCylinderEx,{start,ep,startrad,endrad,sides,col})
end procedure

public procedure DrawCylinderWires(sequence pos,atom radtop,atom radbot,atom height,atom slices,sequence col)
	c_proc(xDrawCylinderWires,{pos,radtop,radbot,height,slices,col})
end procedure

public procedure DrawCylinderWiresEx(sequence start,sequence ep,atom startrad,atom endrad,atom sides,sequence col)
	c_proc(xDrawCylinderWiresEx,{start,ep,startrad,endrad,sides,col})
end procedure

public procedure DrawCapsule(sequence startpos,sequence ep,atom rad,atom slices,atom rings,sequence col)
	c_proc(xDrawCapsule,{startpos,ep,rad,slices,rings,col})
end procedure

public procedure DrawCapsuleWires(sequence start,sequence ep,atom rad,atom slices,atom rings,sequence col)
	c_proc(xDrawCapsuleWires,{start,ep,rad,slices,rings,col})
end procedure

public procedure DrawPlane(sequence pos,sequence size,sequence col)
	c_proc(xDrawPlane,{pos,size,col})
end procedure

public procedure DrawRay(sequence ray,sequence col)
	c_proc(xDrawPlane,{ray,col})
end procedure

public procedure DrawGrid(atom slices,atom space)
	c_proc(xDrawGrid,{slices,space})
end procedure

--Model 3D Loading functions
public constant xLoadModel = define_c_func(ray,"+LoadModel",{C_STRING},Model),
				xLoadModelFromMesh = define_c_func(ray,"+LoadModelFromMesh",{Mesh},Model),
				xIsModelValid = define_c_func(ray,"+IsModelValid",{Model},C_BOOL),
				xUnloadModel = define_c_proc(ray,"+UnloadModel",{Model}),
				xGetModelBoundingBox = define_c_func(ray,"+GetModelBoundingBox",{Model},BoundingBox)
				
public function LoadModel(sequence fName)
	return c_func(xLoadModel,{fName})
end function

public function LoadModelFromMesh(sequence mesh)
	return c_func(xLoadModelFromMesh,{mesh})
end function

public function IsModelValid(sequence model)
	return c_func(xIsModelValid,{model})
end function

public procedure UnloadModel(sequence model)
	c_proc(xUnloadModel,{model})
end procedure

public function GetModelBoundingBox(sequence model)
	return c_func(xGetModelBoundingBox,{model})
end function

--Model drawing functions
public constant xDrawModel = define_c_proc(ray,"+DrawModel",{Model,Vector3,C_FLOAT,Color}),
				xDrawModelEx = define_c_proc(ray,"+DrawModelEx",{Model,Vector3,Vector3,C_FLOAT,Vector3,Color}),
				xDrawModelWires = define_c_proc(ray,"+DrawModelWires",{Model,Vector3,C_FLOAT,Color}),
				xDrawModelWiresEx = define_c_proc(ray,"+DrawModelWiresEx",{Model,Vector3,Vector3,C_FLOAT,Vector3,Color}),
				xDrawModelPoints = define_c_proc(ray,"+DrawModelPoints",{Model,Vector3,C_FLOAT,Color}),
				xDrawModelPointsEx = define_c_proc(ray,"+DrawModelPointsEx",{Model,Vector3,Vector3,C_FLOAT,Vector3,Color}),
				xDrawBoundingBox = define_c_proc(ray,"+DrawBoundingBox",{BoundingBox,Color}),
				xDrawBillboard = define_c_proc(ray,"+DrawBillboard",{Camera,Texture2D,Vector3,C_FLOAT,Color}),
				xDrawBillboardRec = define_c_proc(ray,"+DrawBillboardRec",{Camera,Texture2D,Rectangle,Vector3,Vector2,Color}),
				xDrawBillboardPro = define_c_proc(ray,"+DrawBillboardPro",{Camera,Texture2D,Rectangle,Vector3,Vector3,Vector2,Vector2,C_FLOAT,Color})
				
public procedure DrawModel(sequence model,sequence pos,atom scale,sequence tint)
	c_proc(xDrawModel,{model,pos,scale,tint})
end procedure

public procedure DrawModelEx(sequence model,sequence pos,sequence rotAxis,atom rotAng,sequence scale,sequence tint)
	c_proc(xDrawModelEx,{model,pos,rotAxis,rotAng,scale,tint})
end procedure

public procedure DrawModelWires(sequence model,sequence pos,atom scale,sequence tint)
	c_proc(xDrawModelWires,{model,pos,scale,tint})
end procedure

public procedure DrawModelWiresEx(sequence model,sequence pos,sequence rotAxis,atom rotAng,sequence scale,sequence tint)
	c_proc(xDrawModelWiresEx,{model,pos,rotAxis,rotAng,scale,tint})
end procedure

public procedure DrawModelPoints(sequence model,sequence pos,atom scale,sequence tint)
	c_proc(xDrawModelPoints,{model,pos,scale,tint})
end procedure

public procedure DrawModelPointsEx(sequence model,sequence pos,sequence rotAxis,atom rotAng,sequence scale,sequence tint)
	c_proc(xDrawModelPointsEx,{model,pos,rotAxis,rotAng,scale,tint})
end procedure

public procedure DrawBoundingBox(sequence box,sequence col)
	c_proc(xDrawBoundingBox,{box,col})
end procedure

public procedure DrawBillboard(sequence cam,sequence tex,sequence pos,atom scale,sequence tint)
	c_proc(xDrawBillboard,{cam,tex,pos,scale,tint})
end procedure

public procedure DrawBillboardRec(sequence cam,sequence tex,sequence source,sequence pos,sequence size,sequence tint)
	c_proc(xDrawBillboardRec,{cam,tex,source,pos,size,tint})
end procedure

public procedure DrawBillboardPro(sequence cam,sequence tex,sequence source,sequence pos,sequence up,sequence size,sequence origin,atom rot,sequence tint)
	c_proc(xDrawBillboardPro,{cam,tex,source,pos,up,size,origin,rot,tint})
end procedure

--Mesh management functions
public constant xUploadMesh = define_c_proc(ray,"+UploadMesh",{C_POINTER,C_BOOL}),
				xUpdateMeshBuffer = define_c_proc(ray,"+UpdateMeshBuffer",{Mesh,C_INT,C_POINTER,C_INT,C_INT}),
				xUnloadMesh = define_c_proc(ray,"+UnloadMesh",{Mesh}),
				xDrawMesh = define_c_proc(ray,"+DrawMesh",{Mesh,Material,Matrix}),
				xDrawMeshInstanced = define_c_proc(ray,"+DrawMeshInstanced",{Mesh,Material,C_POINTER,C_INT}),
				xGetMeshBoundingBox = define_c_func(ray,"+GetMeshBoundingBox",{Mesh},BoundingBox),
				xGenMeshTangents = define_c_proc(ray,"+GenMeshTangents",{C_POINTER}),
				xExportMesh = define_c_func(ray,"+ExportMesh",{Mesh,C_STRING},C_BOOL),
				xExportMeshAsCode = define_c_func(ray,"+ExportMeshAsCode",{Mesh,C_STRING},C_BOOL)
				
public procedure UploadMesh(atom mesh,atom dynamic)
	c_proc(xUploadMesh,{mesh,dynamic})
end procedure

public procedure UpdateMeshBuffer(sequence mesh,atom index,atom data,atom size,atom offset)
	c_proc(xUpdateMeshBuffer,{mesh,index,data,size,offset})
end procedure

public procedure UnloadMesh(sequence mesh)
	c_proc(xUnloadMesh,{mesh})
end procedure

public procedure DrawMesh(sequence mesh,sequence material,sequence transform)
	c_proc(xDrawMesh,{mesh,material,transform})
end procedure

public procedure DrawMeshInstanced(sequence mesh,sequence material,atom transform,atom instanced)
	c_proc(xDrawMeshInstanced,{mesh,material,transform,instanced})	
end procedure

public function GetMeshBoundingBox(sequence mesh)
	return c_func(xGetMeshBoundingBox,{mesh})
end function

public procedure GenMeshTangents(atom mesh)
	c_proc(xGenMeshTangents,{mesh})
end procedure

public function ExportMesh(sequence mesh,sequence fName)
	return c_func(xExportMesh,{mesh,fName})
end function

public function ExportMeshAsCode(sequence mesh,sequence fName)
	return c_func(xExportMeshAsCode,{mesh,fName})
end function

--Mesh generation functions
public constant xGenMeshPoly = define_c_func(ray,"+GenMeshPoly",{C_INT,C_FLOAT},Mesh),
				xGenMeshPlane = define_c_func(ray,"+GenMeshPlane",{C_FLOAT,C_FLOAT,C_INT,C_INT},Mesh),
				xGenMeshCube = define_c_func(ray,"+GenMeshCube",{C_FLOAT,C_FLOAT,C_FLOAT},Mesh),
				xGenMeshSphere = define_c_func(ray,"+GenMeshSphere",{C_FLOAT,C_INT,C_INT},Mesh),
				xGenMeshHemiSphere = define_c_func(ray,"+GenMeshHemiSphere",{C_FLOAT,C_INT,C_INT},Mesh),
				xGenMeshCylinder = define_c_func(ray,"+GenMeshCylinder",{C_FLOAT,C_FLOAT,C_INT},Mesh),
				xGenMeshCone = define_c_func(ray,"+GenMeshCone",{C_FLOAT,C_FLOAT,C_INT},Mesh),
				xGenMeshTorus = define_c_func(ray,"+GenMeshTorus",{C_FLOAT,C_FLOAT,C_INT,C_INT},Mesh),
				xGenMeshKnot = define_c_func(ray,"+GenMeshKnot",{C_FLOAT,C_FLOAT,C_INT,C_INT},Mesh),
				xGenMeshHeightmap = define_c_func(ray,"+GenMeshHeightmap",{Image,Vector3},Mesh),
				xGenMeshCubicmap = define_c_func(ray,"+GenMeshCubicmap",{Image,Vector3},Mesh)
				
public function GenMeshPoly(atom sides,atom rad)
	return c_func(xGenMeshPoly,{sides,rad})
end function

public function GenMeshPlane(atom width,atom len,atom x,atom z)
	return c_func(xGenMeshPlane,{width,len,x,z})
end function

public function GenMeshCube(atom width,atom height,atom len)
	return c_func(xGenMeshCube,{width,height,len})
end function

public function GenMeshSphere(atom rad,atom rings,atom slices)
	return c_func(xGenMeshSphere,{rad,rings,slices})
end function

public function GenMeshHemiSphere(atom rad,atom rings,atom slices)
	return c_func(xGenMeshHemiSphere,{rad,rings,slices})
end function

public function GenMeshCylinder(atom rad,atom height,atom slices)
	return c_func(xGenMeshCylinder,{rad,height,slices})
end function

public function GenMeshCone(atom rad,atom height,atom slices)
	return c_func(xGenMeshCone,{rad,height,slices})
end function

public function GenMeshTorus(atom rad,atom size,atom seg,atom sides)
	return c_func(xGenMeshTorus,{rad,size,seg,sides})
end function

public function GenMeshKnot(atom rad,atom size,atom seg,atom sides)
	return c_func(xGenMeshKnot,{rad,size,seg,sides})
end function

public function GenMeshHeightmap(sequence heightmap,sequence size)
	return c_func(xGenMeshHeightmap,{heightmap,size})
end function

public function GenMeshCubicmap(sequence cubicmap,sequence size)
	return c_func(xGenMeshCubicmap,{cubicmap,size})
end function

--Material loading functions
public constant xLoadMaterials = define_c_func(ray,"+LoadMaterials",{C_STRING,C_POINTER},C_POINTER),
				xLoadMaterialDefault = define_c_func(ray,"+LoadMaterialDefault",{},Material),
				xIsMaterialValid = define_c_func(ray,"+IsMaterialValid",{Material},C_BOOL),
				xUnloadMaterial = define_c_proc(ray,"+UnloadMaterial",{Material}),
				xSetMaterialTexture = define_c_proc(ray,"+SetMaterialTexture",{C_POINTER,C_INT,Texture2D}),
				xSetModelMeshMaterial = define_c_proc(ray,"+SetModelMeshMaterial",{C_POINTER,C_INT,C_INT})
				
public function LoadMaterials(sequence fName,atom count)
	return c_func(xLoadMaterials,{fName,count})
end function

public function LoadMaterialDefault()
	return c_func(xLoadMaterialDefault,{})
end function

public function IsMaterialValid(sequence material)
	return c_func(xIsMaterialValid,{material})
end function

public procedure UnloadMaterial(sequence material)
	c_proc(xUnloadMaterial,{material})
end procedure

public procedure SetMaterialTexture(sequence mat,atom mapType,sequence tex)
	c_proc(xSetMaterialTexture,{mat,mapType,tex})
end procedure

public procedure SetModelMeshMaterial(atom model,atom meshID,atom matID)
	c_proc(xSetModelMeshMaterial,{model,meshID,matID})
end procedure

--Model animation loading functions
public constant xLoadModelAnimations = define_c_func(ray,"+LoadModelAnimations",{C_STRING,C_POINTER},C_POINTER),
				xUpdateModelAnimation = define_c_proc(ray,"+UpdateModelAnimation",{Model,ModelAnimation,C_INT}),
				xUpdateModelAnimationBones = define_c_proc(ray,"+UpdateModelAnimationBones",{Model,ModelAnimation,C_INT}),
				xUnloadModelAnimation = define_c_proc(ray,"+UnloadModelAnimation",{ModelAnimation}),
				xUnloadModelAnimations = define_c_proc(ray,"+UnloadModelAnimations",{C_POINTER,C_INT}),
				xIsModelAnimationValid = define_c_func(ray,"+IsModelAnimationValid",{Model,ModelAnimation},C_BOOL)
				
public function LoadModelAnimations(sequence fName,atom count)
	return c_func(xLoadModelAnimations,{fName,count})
end function

public procedure UpdateModelAnimation(sequence model,sequence anim,atom frame)
	c_proc(xUpdateModelAnimation,{model,anim,frame})
end procedure

public procedure UpdateModelAnimationBones(sequence model,sequence anim,atom frame)
	c_proc(xUpdateModelAnimationBones,{model,anim,frame})
end procedure

public procedure UnloadModelAnimation(sequence anim)
	c_proc(xUnloadModelAnimation,{anim})
end procedure

public procedure UnloadModelAnimations(atom anim,atom count)
	c_proc(xUnloadModelAnimations,{anim,count})
end procedure

public function IsModelAnimationValid(sequence model,sequence anim)
	return c_func(xIsModelAnimationValid,{model,anim})
end function

--Collision detection functions
public constant xCheckCollisionSpheres = define_c_func(ray,"+CheckCollisionSpheres",{Vector3,C_FLOAT,Vector3,C_FLOAT},C_BOOL),
				xCheckCollisionBoxes = define_c_func(ray,"+CheckCollisionBoxes",{BoundingBox,BoundingBox},C_BOOL),
				xCheckCollisionBoxSphere = define_c_func(ray,"+CheckCollisionBoxSphere",{BoundingBox,Vector3,C_FLOAT},C_BOOL),
				xGetRayCollisionSphere = define_c_func(ray,"+GetRayCollisionSphere",{Ray,Vector3,C_FLOAT},RayCollision),
				xGetRayCollisionBox = define_c_func(ray,"+GetRayCollisionBox",{Ray,BoundingBox},RayCollision),
				xGetRayCollisionMesh = define_c_func(ray,"+GetRayCollisionMesh",{Ray,Mesh,Matrix},RayCollision),
				xGetRayCollisionTriangle = define_c_func(ray,"+GetRayCollisionTriangle",{Ray,Vector3,Vector3,Vector3},RayCollision),
				xGetRayCollisionQuad = define_c_func(ray,"+GetRayCollisionQuad",{Ray,Vector3,Vector3,Vector3,Vector3},RayCollision)
				
public function CheckCollisionSpheres(sequence center,atom rad,sequence center2,atom rad2)
	return c_func(xCheckCollisionSpheres,{center,rad,center2,rad2})
end function

public function CheckCollisionBoxes(sequence box,sequence box2)
	return c_func(xCheckCollisionBoxes,{box,box2})
end function

public function CheckCollisionBoxSphere(sequence box,sequence center,atom rad)
	return c_func(xCheckCollisionBoxSphere,{box,center,rad})
end function

public function GetRayCollisionSphere(sequence ray,sequence center,atom rad)
	return c_func(xGetRayCollisionSphere,{ray,center,rad})
end function

public function GetRayCollisionBox(sequence ray,sequence box)
	return c_func(xGetRayCollisionBox,{ray,box})
end function

public function GetRayCollisionMesh(sequence ray,sequence mesh,sequence transform)
	return c_func(xGetRayCollisionMesh,{ray,mesh,transform})
end function

public function GetRayCollisionTriangle(sequence ray,sequence p1,sequence p2,sequence p3)
	return c_func(xGetRayCollisionTriangle,{ray,p1,p2,p3})
end function

public function GetRayCollisionQuad(sequence ray,sequence p1,sequence p2,sequence p3,sequence p4)
	return c_func(xGetRayCollisionQuad,{ray,p1,p2,p3,p4})
end function

--Audio functions
public constant xInitAudioDevice = define_c_proc(ray,"+InitAudioDevice",{}),
				xCloseAudioDevice = define_c_proc(ray,"+CloseAudioDevice",{}),
				xIsAudioDeviceReady = define_c_func(ray,"+IsAudioDeviceReady",{},C_BOOL),
				xSetMasterVolume = define_c_proc(ray,"+SetMasterVolume",{C_FLOAT}),
				xGetMasterVolume = define_c_func(ray,"+GetMasterVolume",{},C_FLOAT)
				
public procedure InitAudioDevice()
	c_proc(xInitAudioDevice,{})
end procedure

public procedure CloseAudioDevice()
	c_proc(xCloseAudioDevice,{})
end procedure

public function IsAudioDeviceReady()
	return c_func(xIsAudioDeviceReady,{})
end function

public procedure SetMasterVolume(atom vol)
	c_proc(xSetMasterVolume,{vol})
end procedure

public function GetMasterVolume()
	return c_func(xGetMasterVolume,{})
end function

--Wave loading functions
public constant xLoadWave = define_c_func(ray,"+LoadWave",{C_STRING},Wave),
				xLoadWaveFromMemory = define_c_func(ray,"+LoadWaveFromMemory",{C_STRING,C_POINTER,C_INT},Wave),
				xIsWaveValid = define_c_func(ray,"+IsWaveValid",{Wave},C_BOOL),
				xLoadSound = define_c_func(ray,"+LoadSound",{C_STRING},Sound),
				xLoadSoundFromWave = define_c_func(ray,"+LoadSoundFromWave",{Wave},Sound),
				xLoadSoundAlias = define_c_func(ray,"+LoadSoundAlias",{Sound},Sound),
				xIsSoundValid = define_c_func(ray,"+IsSoundValid",{Sound},C_BOOL),
				xUpdateSound = define_c_proc(ray,"+UpdateSound",{Sound,C_POINTER,C_INT}),
				xUnloadWave = define_c_proc(ray,"+UnloadWave",{Wave}),
				xUnloadSound = define_c_proc(ray,"+UnloadSound",{Sound}),
				xUnloadSoundAlias = define_c_proc(ray,"+UnloadSoundAlias",{Sound}),
				xExportWave = define_c_func(ray,"+ExportWave",{Wave,C_STRING},C_BOOL),
				xExportWaveAsCode = define_c_func(ray,"+ExportWaveAsCode",{Wave,C_STRING},C_BOOL)
				
public function LoadWave(sequence fName)
	return c_func(xLoadWave,{fName})
end function

public function LoadWaveFromMemory(sequence fileType,atom fileData,atom dataSize)
	return c_func(xLoadWaveFromMemory,{fileType,fileData,dataSize})
end function

public function IsWaveValid(sequence wave)
	return c_func(xIsWaveValid,{wave})
end function

public function LoadSound(sequence fName)
	return c_func(xLoadSound,{fName})
end function

public function LoadSoundFromWave(sequence wave)
	return c_func(xLoadSoundFromWave,{wave})
end function

public function LoadSoundAlias(sequence source)
	return c_func(xLoadSoundAlias,{source})
end function

public function IsSoundValid(sequence sound)
	return c_func(xIsSoundValid,{sound})
end function

public procedure UpdateSound(sequence sound,atom data,atom count)
	c_proc(xUpdateSound,{sound,data,count})
end procedure

public procedure UnloadWave(sequence wave)
	c_proc(xUnloadWave,{wave})
end procedure

public procedure UnloadSound(sequence sound)
	c_proc(xUnloadSound,{sound})
end procedure

public procedure UnloadSoundAlias(sequence alias)
	c_proc(xUnloadSoundAlias,{alias})
end procedure

public function ExportWave(sequence wave,sequence fName)
	return c_func(xExportWave,{wave,fName})
end function

public function ExportWaveAsCode(sequence wave,sequence fName)
	return c_func(xExportWaveAsCode,{wave,fName})
end function

--Wave/sound management functions
public constant xPlaySound = define_c_proc(ray,"+PlaySound",{Sound}),
				xStopSound = define_c_proc(ray,"+StopSound",{Sound}),
				xPauseSound = define_c_proc(ray,"+PauseSound",{Sound}),
				xResumeSound = define_c_proc(ray,"+ResumeSound",{Sound}),
				xIsSoundPlaying = define_c_func(ray,"+IsSoundPlaying",{Sound},C_BOOL),
				xSetSoundVolume = define_c_proc(ray,"+SetSoundVolume",{Sound,C_FLOAT}),
				xSetSoundPitch = define_c_proc(ray,"+SetSoundPitch",{Sound,C_FLOAT}),
				xSetSoundPan = define_c_proc(ray,"+SetSoundPan",{Sound,C_FLOAT}),
				xWaveCopy = define_c_func(ray,"+WaveCopy",{Wave},Wave),
				xWaveCrop = define_c_proc(ray,"+WaveCrop",{C_POINTER,C_INT,C_INT}),
				xWaveFormat = define_c_proc(ray,"+WaveFormat",{C_POINTER,C_INT,C_INT,C_INT}),
				xLoadWaveSamples = define_c_func(ray,"+LoadWaveSamples",{Wave},C_POINTER),
				xUnloadWaveSamples = define_c_proc(ray,"+UnloadWaveSamples",{C_POINTER})
				
public procedure PlaySound(sequence snd)
	c_proc(xPlaySound,{snd})
end procedure

public procedure StopSound(sequence snd)
	c_proc(xStopSound,{snd})
end procedure

public procedure PauseSound(sequence snd)
	c_proc(xPauseSound,{snd})
end procedure

public procedure ResumeSound(sequence snd)
	c_proc(xResumeSound,{snd})
end procedure

public function IsSoundPlaying(sequence snd)
	return c_func(xIsSoundPlaying,{snd})
end function

public procedure SetSoundVolume(sequence snd,atom vol)
	c_proc(xSetSoundVolume,{snd,vol})
end procedure

public procedure SetSoundPitch(sequence snd,atom pit)
	c_proc(xSetSoundPitch,{snd,pit})
end procedure

public procedure SetSoundPan(sequence snd,atom pan)
	c_proc(xSetSoundPan,{snd,pan})
end procedure

public function WaveCopy(sequence wav)
	return c_func(xWaveCopy,{wav})
end function

public procedure WaveCrop(atom wav,atom initFrame,atom finalFrame)
	c_proc(xWaveCrop,{wav,initFrame,finalFrame})
end procedure

public procedure WaveFormat(atom wav,atom sampleRate,atom sampleSize,atom channels)
	c_proc(xWaveFormat,{wav,sampleRate,sampleSize,channels})
end procedure

public function LoadWaveSamples(sequence wav)
	return c_func(xLoadWaveSamples,{wav})
end function

public procedure UnloadWaveSamples(atom samp)
	c_proc(xUnloadWaveSamples,{samp})
end procedure

--Music management functions
public constant xLoadMusicStream = define_c_func(ray,"+LoadMusicStream",{C_STRING},Music),
				xLoadMusicStreamFromMemory = define_c_func(ray,"+LoadMusicStreamFromMemory",{C_STRING,C_POINTER,C_INT},Music),
				xIsMusicValid = define_c_func(ray,"+IsMusicValid",{Music},C_BOOL),
				xUnloadMusicStream = define_c_proc(ray,"+UnloadMusicStream",{Music}),
				xPlayMusicStream = define_c_proc(ray,"+PlayMusicStream",{Music}),
				xIsMusicStreamPlaying = define_c_func(ray,"+IsMusicStreamPlaying",{Music},C_BOOL),
				xUpdateMusicStream = define_c_proc(ray,"+UpdateMusicStream",{Music}),
				xStopMusicStream = define_c_proc(ray,"+StopMusicStream",{Music}),
				xPauseMusicStream = define_c_proc(ray,"+PauseMusicStream",{Music}),
				xResumeMusicStream = define_c_proc(ray,"+ResumeMusicStream",{Music}),
				xSeekMusicStream = define_c_proc(ray,"+SeekMusicStream",{Music,C_FLOAT}),
				xSetMusicVolume = define_c_proc(ray,"+SetMusicVolume",{Music,C_FLOAT}),
				xSetMusicPitch = define_c_proc(ray,"+SetMusicPitch",{Music,C_FLOAT}),
				xSetMusicPan = define_c_proc(ray,"+SetMusicPan",{Music,C_FLOAT}),
				xGetMusicTimeLength = define_c_func(ray,"+GetMusicTimeLength",{Music},C_FLOAT),
				xGetMusicTimePlayed = define_c_func(ray,"+GetMusicTimePlayed",{Music},C_FLOAT)
				
public function LoadMusicStream(sequence fName)
	return c_func(xLoadMusicStream,{fName})
end function

public function LoadMusicStreamFromMemory(sequence fileType,atom data,atom size)
	return c_func(xLoadMusicStreamFromMemory,{fileType,data,size})
end function

public function IsMusicValid(sequence music)
	return c_func(xIsMusicValid,{music})
end function

public procedure UnloadMusicStream(sequence music)
	c_proc(xUnloadMusicStream,{music})
end procedure

public procedure PlayMusicStream(sequence music)
	c_proc(xPlayMusicStream,{music})
end procedure

public function IsMusicStreamPlaying(sequence music)
	return c_func(xIsMusicStreamPlaying,{music})
end function

public procedure UpdateMusicStream(sequence music)
	c_proc(xUpdateMusicStream,{music})
end procedure

public procedure StopMusicStream(sequence music)
	c_proc(xStopMusicStream,{music})
end procedure

public procedure PauseMusicStream(sequence music)
	c_proc(xPauseMusicStream,{music})
end procedure

public procedure ResumeMusicStream(sequence music)
	c_proc(xResumeMusicStream,{music})
end procedure

public procedure SeekMusicStream(sequence music,atom pos)
	c_proc(xSeekMusicStream,{music,pos})
end procedure

public procedure SetMusicVolume(sequence music,atom vol)
	c_proc(xSetMusicVolume,{music,vol})
end procedure

public procedure SetMusicPitch(sequence music,atom pit)
	c_proc(xSetMusicPitch,{music,pit})
end procedure

public procedure SetMusicPan(sequence music,atom pan)
	c_proc(xSetMusicPan,{music,pan})
end procedure

public function GetMusicTimeLength(sequence music)
	return c_func(xGetMusicTimeLength,{music})
end function

public function GetMusicTimePlayed(sequence music)
	return c_func(xGetMusicTimePlayed,{music})
end function

--Audiostream functions
public constant xLoadAudioStream = define_c_func(ray,"+LoadAudioStream",{C_UINT,C_UINT,C_UINT},AudioStream),
				xIsAudioStreamValid = define_c_func(ray,"+IsAudioStreamValid",{AudioStream},C_BOOL),
				xUnloadAudioStream = define_c_proc(ray,"+UnloadAudioStream",{AudioStream}),
				xUpdateAudioStream = define_c_proc(ray,"+UpdateAudioStream",{AudioStream,C_POINTER,C_INT}),
				xIsAudioStreamProcessed = define_c_func(ray,"+IsAudioStreamProcessed",{AudioStream},C_BOOL),
				xPlayAudioStream = define_c_proc(ray,"+PlayAudioStream",{AudioStream}),
				xPauseAudioStream = define_c_proc(ray,"+PauseAudioStream",{AudioStream}),
				xResumeAudioStream = define_c_proc(ray,"+ResumeAudioStream",{AudioStream}),
				xIsAudioStreamPlaying = define_c_proc(ray,"+IsAudioStreamPlaying",{AudioStream}),
				xStopAudioStream = define_c_proc(ray,"+StopAudioStream",{AudioStream}),
				xSetAudioStreamVolume = define_c_proc(ray,"+SetAudioStreamVolume",{AudioStream,C_FLOAT}),
				xSetAudioStreamPitch = define_c_proc(ray,"+SetAudioStreamPitch",{AudioStream,C_FLOAT}),
				xSetAudioStreamPan = define_c_proc(ray,"+SetAudioStreamPan",{AudioStream,C_FLOAT}),
				xSetAudioStreamBufferSizeDefault = define_c_proc(ray,"+SetAudioStreamBufferSizeDefault",{C_INT}),
				xSetAudioStreamCallback = define_c_proc(ray,"+SetAudioStreamCallback",{AudioStream,C_POINTER})
				
public function LoadAudioStream(atom sampleRate,atom sampleSize,atom channels)
	return c_func(xLoadAudioStream,{sampleRate,sampleSize,channels})
end function

public function IsAudioStreamValid(sequence stream)
	return c_func(xIsAudioStreamValid,{stream})
end function

public procedure UnloadAudioStream(sequence stream)
	c_proc(xUnloadAudioStream,{stream})
end procedure

public procedure UpdateAudioStream(sequence stream,atom data,atom count)
	c_proc(xUpdateAudioStream,{stream,data,count})
end procedure

public function IsAudioStreamProcessed(sequence stream)
	return c_func(xIsAudioStreamProcessed,{stream})
end function

public procedure PlayAudioStream(sequence stream)
	c_proc(xPlayAudioStream,{stream})
end procedure

public procedure PauseAudioStream(sequence stream)
	c_proc(xPauseAudioStream,{stream})
end procedure

public procedure ResumeAudioStream(sequence stream)
	c_proc(xResumeAudioStream,{stream})
end procedure

public function IsAudioStreamPlaying(sequence stream)
	return c_func(xIsAudioStreamPlaying,{stream})
end function

public procedure StopAudioStream(sequence stream)
	c_proc(xStopAudioStream,{stream})
end procedure

public procedure SetAudioStreamVolume(sequence stream,atom vol)
	c_proc(xSetAudioStreamVolume,{stream,vol})
end procedure

public procedure SetAudioStreamPitch(sequence stream,atom pit)
	c_proc(xSetAudioStreamPitch,{stream,pit})
end procedure

public procedure SetAudioStreamPan(sequence stream,atom pan)
	c_proc(xSetAudioStreamPan,{stream,pan})
end procedure

public procedure SetAudioStreamBufferSizeDefault(atom size)
	c_proc(xSetAudioStreamBufferSizeDefault,{size})
end procedure

public procedure SetAudioStreamCallback(sequence stream,object cb)
	c_proc(xSetAudioStreamCallback,{stream,cb})
end procedure

public constant xAttachAudioStreamProcessor = define_c_proc(ray,"+AttachAudioStreamProcessor",{AudioStream,C_POINTER}),
				xDetachAudioStreamProcessor = define_c_proc(ray,"+DetachAudioStreamProcessor",{AudioStream,C_POINTER})
				
public procedure AttachAudioStreamProcessor(sequence stream,object processor)
	c_proc(xAttachAudioStreamProcessor,{stream,processor})
end procedure

public procedure DetachAudioStreamProcessor(sequence stream,object processor)
	c_proc(xDetachAudioStreamProcessor,{stream,processor})
end procedure

public constant xAttachAudioMixedProcessor = define_c_proc(ray,"+AttachAudioMixedProcessor",{C_POINTER}),
				xDetachAudioMixedProcessor = define_c_proc(ray,"+DetachAudioMixedProcessor",{C_POINTER})
				
public procedure AttachAudioMixedProcessor(object processor)
	c_proc(xAttachAudioMixedProcessor,{processor})
end procedure

public procedure DetachAudioMixedProcessor(object processor)
	c_proc(xDetachAudioMixedProcessor,{processor})
end procedure
­3032.18