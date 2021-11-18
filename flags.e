--Vector2 Struct Converted Eu Friendly (float)
public constant VECTOR2_X = 0,
				VECTOR2_Y = 4,
				SIZEOF_VECTOR2 = 8
				
--Vector3 Struct Converted Eu Friendly (float)
public constant VECTOR3_X = 0,
				VECTOR3_Y = 4,
				VECTOR_3_Z = 8,
				SIZEOF_VECTOR3 = 12
				
--Vector4 Struct (float)
public constant VECTOR4_X = 0,
				VECTOR4_Y = 4,
				VECTOR4_Z = 8,
				VECTOR4_W = 12,
				SIZEOF_VECTOR4 = 16
				
--Matrix Struct (float)
public constant MATRIX_M0 = 0,
				MATRIX_M4 = 4,
				MATRIX_M8 = 8,
				MATRIX_M12 = 12,
				MATRIX_M1 = 16,
				MATRIX_M5 = 20,
				MATRIX_M8_ = 24,
				MATRIX_M13 = 28,
				MATRIX_M2 = 32,
				MATRIX_M6 = 36,
				MATRIX_M10 = 40,
				MATRIX_M14 = 44,
				MATRIX_M3 = 48,
				MATRIX_M7 = 52,
				MATRIX_M11 = 56,
				MATRIX_M15 = 60,
				SIZEOF_MATRIX = 64
				
--Color Struct	(Unsigned Char)		
public constant COLOR_R = 0,
				COLOR_G = 1,
				COLOR_B = 2,
				COLOR_A = 3
				
--Rectangle Struct (float)
public constant RECTANGLE_X = 0,
				RECTANGLE_Y = 4,
				RECTANGLE_WIDTH = 8,
				RECTANGLE_HEIGHT = 12,
				SIZEOF_RECTANGLE = 16
				
--Image Struct (Void Pointer,Ints)
public constant IMAGE_DATA = 8, --PTRVOID
				IMAGE_WIDTH = 9, --INT
				IMAGE_HEIGHT = 10, --INT
				IMAGE_MIPMAPS = 11, --INT
				IMAGE_FORMAT = 12, --INT
				SIZEOF_IMAGE = 13
				
--Texture Struct (Unsigned int,int)
public constant TEXTURE_ID = 0,
				TEXTURE_WIDTH = 1,
				TEXTURE_HEIGHT = 2,
				TEXTURE_MIPMAPS = 3,
				TEXTURE_FORMAT = 4,
				SIZEOF_TEXTURE = 5
				
--RenderTexture Struct (unsigned int,Texture)
public constant RENDERTEXTURE_ID = 0,
				RENDERTEXTURE_TEXTURE = 8,
				RENDERTEXTURE_DEPTH = 16,
				SIZEOF_RENDERTEXTURE = 20
				
--NPatchInfo Struct(Rectangle,Int)
public constant NPATCHINFO_SOURCE = 4, --RECTANGLE
				NPATCHINFO_LEFT = 5,
				NPATCHINFO_TOP = 6,
				NPATCHINFO_RIGHT = 7,
				NPATCHINFO_BOTTOM = 8,
				NPATCHINFO_LAYOUT = 9,
				SIZEOF_NPATCHINFO = 10
				
--GlyphInfo Struct(int,image)
public constant GLYPHINFO_VALUE = 0,
				GLYPHINFO_OFFSETX = 1,
				GLYPHINFO_OFFSETY = 2,
				GLYPHINFO_ADVANCEX = 3,
				GLYPHINFO_IMAGE = 7,
				SIZEOF_GLYPHINFO = 11
				
--Font Struct (int,texture2d,rectangle,glyphinfo)
public constant FONT_BASESIZE = 0,
				FONT_GLYPHCOUNT = 1,
				FONT_GLYPHPADDING = 2,
				FONT_TEXTURE = 6,
				FONT_RECS = 14, --RECTS IS POINTER
				FONT_GLYPHS = 22, --pointer
				SIZEOF_FONT = 26

--Camera3D (Vector3,float,int)				
public constant CAMERA3D_POSITION = 0,
				CAMERA3D_TARGET = 4,
				CAMERA3D_UP = 8,
				CAMERA3D_FOVY = 12,
				CAMERA3D_PROJECTION = 13,
				SIZEOF_CAMERA3D = 17
				
--Camera2D Struct (Vector2,float)
public constant CAMERA2D_OFFSET = 0,
				CAMERA2D_TARGET = 4,
				CAMERA2D_ROTATION = 8,
				CAMERA2D_ZOOM = 12,
				SIZEOF_CAMERA2D = 16
				
--Mesh Struct (int,float,uchar,ushort,uint)
public constant MESH_VERTEXCOUNT = 0,
				MESH_TRIANGLECOUNT = 1,
				MESH_VERTICES = 9,
				MESH_TEXCOORDS = 17,
				MESH_TEXCOORDS2 = 25,
				MESH_NORMALS = 33,
				MESH_TANGETS = 41,
				MESH_COLORS = 44,
				MESH_INDICES = 48,
				MESH_ANIMVERTICES = 52,
				MESH_ANIMNORMALS = 56,
				MESH_BONEIDS = 58,
				MESH_INDICES_ = 60,
				VAOID = 61,
				VBOID = 65,
				SIZEOF_MESH = 69
				
public constant SHADER_ID = 0,
				SHADER_LOCS = 2,
				SIZEOF_SHADER = 3
				
public constant MATERIALMAP_TEXTURE = 0,
				MATERIALMAP_COLOR = 1,
				MATERIALMAP_VALUE = 5,
				SIZEOF_MATERIALMAP = 6
				
public constant MATERIAL_SHADER = 0,
				MATERIAL_MAPS = 4,
				MATERIAL_PARAMS0 = 8,
				MATERIAL_PARAMS1 = 12,
				MATERIAL_PARAMS2 = 16,
				MATERIAL_PARAMS3 = 20,
				SIZEOF_MATERIAL = 24
				
public constant TRANSFORM_TRANSLATION = 0,
				TRANSFORM_ROTATION = 4,
				TRANSFORM_SCALE = 8,
				SIZEOF_TRANSFORM = 12
				
public constant BONEINFO_NAME = 8,
				BONEINFO_PARENT = 9,
				SIZEOF_BONEINFO = 10
				
public constant MODEL_TRANSFORM = 0,
				MODEL_MESHCOUNT = 1,
				MODEL_MATERIALCOUNT = 2,
				MODEL_MESHES = 6,
				MODEL_MATERIALS = 12,
				MODEL_MESHMATERIALS = 16,
				MODEL_BONECOUNT = 17,
				MODEL_BONES = 22,
				MODEL_BONES_ = 28,
				MODEL_BINDPOSE = 32,
				SIZEOF_MODEL = 36
				
public constant MODELANIMATION_BONECOUNT = 0,
				MODELANIMATION_FRAMECOUNT = 1,
				MODELANIMATION_BONES = 6,
				MODELANIMATION_FRAMEPOSES = 12,
				SIZEOF_MODELANIMATION = 16
				
public constant RAY_POSITION = 0,
				RAY_DIRECTION = 4,
				SIZEOF_RAY = 8
				
public constant RAYCOLLISION_HIT = 0,
				RAYCOLLISION_DISTANCE = 4,
				RAYCOLLISION_POINT = 8,
				RAYCOLLISION_NORMAL = 12,
				SIZEOF_RAYCOLLISION = 16
				
public constant BOUNDINGBOX_MIN = 0,
				BOUNDINGBOX_MAX = 4,
				SIZEOF_BOUNDINGBOX = 8
				
public constant WAVE_FRAMECOUNT = 0,
				WAVE_SAMPLERATE = 1,
				WAVE_SAMPLESIZE = 2,
				WAVE_CHANNELS = 3,
				WAVE_DATA = 11,
				SIZEOF_WAVE = 12
				
public constant AUDIOSTREAM_BUFFER = 8,
				AUDIOSTREAM_SAMPLERATE = 9,
				AUDIOSTREAM_SAMPLESIZE = 10,
				AUDIOSTREAM_CHANNELS = 11,
				SIZEOF_AUDIOSTREAM = 12
				
public constant SOUND_STREAM = 4,
				SOUND_FRAMECOUNT = 5,
				SIZEOF_SOUND = 6
				
public constant MUSIC_STREAM = 4,
				MUSIC_FRAMECOUNT = 5,
				MUSIC_LOOPING = 5,
				MUSIC_CTXTYPE = 6,
				MUSIC_CTXDATA = 14,
				SIZEOF_MUSIC = 15
				
public constant VRDEVICEINFO_HRESOLUTION = 0,
				VRDEVICEINFO_VRRESOLUTION = 1,
				VRDEVICEINFO_HSCREENSIZE = 4,
				VRDEVICEINFO_VSCREENSIZE = 8,
				VRDEVICEINFO_VSCREENCENTER = 12,
				VRDEVICEINFO_EYETOSCREENDISTANCE = 16,
				VRDEVICEINFO_LENSSEPARATIONDISTANCE = 20,
				VRDEVICEINFO_INTERPUPILLARYDISTANCE = 24,
				VRDEVICEINFO_LENSDISTORTATIONVALUES = 28,
				VRDEVICEINFO_CHROMAABCORRECTION = 32,
				SIZEOF_VRDEVICEINFO = 36
				
public constant VRSTEREOCONFIG_PROJECTION = 0,
				VRSTEREOCONFIG_VIEWOFFSET = 4,
				VRSTEREOCONFIG_LEFTLENSCENTER = 8,
				VRSTEREOCONFIG_RIGHTLENSCENTER = 12,
				VRSTEREOCONFIG_LEFTSCREENCENTER = 16,
				VRSTEREOCONFIG_RIGHTSCREENCENTER = 20,
				VRSTEREOCONFIG_SCALE = 24,
				VRSTEREOCONFIG_SCALEIN = 28,
				SIZEOF_VRSTEREOCONFIG = 32
				
public enum FLAG_VSYNC_HINT         = 0x00000040,  
    FLAG_FULLSCREEN_MODE    = 0x00000002,   
    FLAG_WINDOW_RESIZABLE   = 0x00000004,   
    FLAG_WINDOW_UNDECORATED = 0x00000008,   
    FLAG_WINDOW_HIDDEN      = 0x00000080,   
    FLAG_WINDOW_MINIMIZED   = 0x00000200,   
    FLAG_WINDOW_MAXIMIZED   = 0x00000400,   
    FLAG_WINDOW_UNFOCUSED   = 0x00000800,   
    FLAG_WINDOW_TOPMOST     = 0x00001000,   
    FLAG_WINDOW_ALWAYS_RUN  = 0x00000100,   
    FLAG_WINDOW_TRANSPARENT = 0x00000010,   
    FLAG_WINDOW_HIGHDPI     = 0x00002000,   
    FLAG_MSAA_4X_HINT       = 0x00000020,   
    FLAG_INTERLACED_HINT    = 0x00010000  

public enum 
 	LOG_ALL = 0,
 	LOG_TRACE,
 	LOG_DEBUG,
 	LOG_INFO,
 	LOG_WARNING,
 	LOG_ERROR,
 	LOG_FATAL,
 	LOG_NONE
	


public enum 
KEY_NULL            = 0,       
   
    KEY_APOSTROPHE      = 39,       
    KEY_COMMA           = 44,       
    KEY_MINUS           = 45,       
    KEY_PERIOD          = 46,       
    KEY_SLASH           = 47,       
    KEY_ZERO            = 48,       
    KEY_ONE             = 49,      
    KEY_TWO             = 50,       
    KEY_THREE           = 51,      
    KEY_FOUR            = 52,      
    KEY_FIVE            = 53,       
    KEY_SIX             = 54,       
    KEY_SEVEN           = 55,       
    KEY_EIGHT           = 56,      
    KEY_NINE            = 57,       
    KEY_SEMICOLON       = 59,       
    KEY_EQUAL           = 61,       
    KEY_A               = 65,       
    KEY_B               = 66,       
    KEY_C               = 67,       
    KEY_D               = 68,       
    KEY_E               = 69,       
    KEY_F               = 70,       
    KEY_G               = 71,      
    KEY_H               = 72,     
    KEY_I               = 73,       
    KEY_J               = 74,       
    KEY_K               = 75,       
    KEY_L               = 76,       
    KEY_M               = 77,       
    KEY_N               = 78,       
    KEY_O               = 79,     
    KEY_P               = 80,       
    KEY_Q               = 81,      
    KEY_R               = 82,      
    KEY_S               = 83,      
    KEY_T               = 84,      
    KEY_U               = 85,      
    KEY_V               = 86,     
    KEY_W               = 87,       
    KEY_X               = 88,       
    KEY_Y               = 89,       
    KEY_Z               = 90,       
    KEY_LEFT_BRACKET    = 91,       
    KEY_BACKSLASH       = 92,      
    KEY_RIGHT_BRACKET   = 93,      
    KEY_GRAVE           = 96,      
  
    KEY_SPACE           = 32,       
    KEY_ESCAPE          = 256,     
    KEY_ENTER           = 257,     
    KEY_TAB             = 258,     
    KEY_BACKSPACE       = 259,     
    KEY_INSERT          = 260,      
    KEY_DELETE          = 261,      
    KEY_RIGHT           = 262,      
    KEY_LEFT            = 263,      
    KEY_DOWN            = 264,     
    KEY_UP              = 265,     
    KEY_PAGE_UP         = 266,     
    KEY_PAGE_DOWN       = 267,      
    KEY_HOME            = 268,      
    KEY_END             = 269,     
    KEY_CAPS_LOCK       = 280,     
    KEY_SCROLL_LOCK     = 281,      
    KEY_NUM_LOCK        = 282,      
    KEY_PRINT_SCREEN    = 283,      
    KEY_PAUSE           = 284,      
    KEY_F1              = 290,      
    KEY_F2              = 291,      
    KEY_F3              = 292,      
    KEY_F4              = 293,      
    KEY_F5              = 294,      
    KEY_F6              = 295,      
    KEY_F7              = 296,      
    KEY_F8              = 297,      
    KEY_F9              = 298,      
    KEY_F10             = 299,      
    KEY_F11             = 300,      
    KEY_F12             = 301,      
    KEY_LEFT_SHIFT      = 340,      
    KEY_LEFT_CONTROL    = 341,      
    KEY_LEFT_ALT        = 342,      
    KEY_LEFT_SUPER      = 343,      
    KEY_RIGHT_SHIFT     = 344,      
    KEY_RIGHT_CONTROL   = 345,      
    KEY_RIGHT_ALT       = 346,      
    KEY_RIGHT_SUPER     = 347,     
    KEY_KB_MENU         = 348,      
    
    KEY_KP_0            = 320,     
    KEY_KP_1            = 321,     
    KEY_KP_2            = 322,     
    KEY_KP_3            = 323,      
    KEY_KP_4            = 324,      
    KEY_KP_5            = 325,      
    KEY_KP_6            = 326,      
    KEY_KP_7            = 327,      
    KEY_KP_8            = 328,      
    KEY_KP_9            = 329,      
    KEY_KP_DECIMAL      = 330,      
    KEY_KP_DIVIDE       = 331,      
    KEY_KP_MULTIPLY     = 332,     
    KEY_KP_SUBTRACT     = 333,     
    KEY_KP_ADD          = 334,      
    KEY_KP_ENTER        = 335,      
    KEY_KP_EQUAL        = 336,      
    
    KEY_BACK            = 4,       
    KEY_MENU            = 82,      
    KEY_VOLUME_UP       = 24,      
    KEY_VOLUME_DOWN     = 25
	

public enum 
MOUSE_BUTTON_LEFT = 0,
 MOUSE_BUTTON_RIGHT = 1,
 MOUSE_BUTTON_MIDDLE = 2,
 MOUSE_BUTTON_SIDE = 3,
 MOUSE_BUTTON_EXTRA = 4,
 MOUSE_BUTTON_FORWARD = 5,
 MOUSE_BUTTON_BACK = 6
	

public enum  
MOUSE_CURSOR_DEFAULT = 0,
 MOUSE_CURSOR_ARROW = 1,
 MOUSE_CURSOR_IBEAM = 2,
 MOUSE_CURSOR_CROSSHAIR = 3,
 MOUSE_CURSOR_POINTINH_HAND = 4,
 MOUSE_CURSOR_RESIZE_EW = 5,
 MOUSE_CURSOR_RESIZE_NS = 6,
 MOUSE_CURSOR_RESIZE_NWSE = 7,
 MOUSE_CURSOR_RESIZE_NESW = 8,
 MOUSE_CURSOR_RESIZE_ALL = 9,
 MOUSE_CURSOR_NOT_ALLOWED = 10
	

public enum 
GAMEPAD_BUTTON_UNKNOWN = 0,
 GAMEPAD_BUTTON_LEFT_FACE_UP,
 GAMEPAD_BUTTON_LEFT_FACE_RIGHT,
 GAMEPAD_BUTTON_LEFT_FACE_DOWN,
 GAMEPAD_BUTTON_LEFT_FACE_LEFT,
 GAMEPAD_BUTTON_RIGHT_FACE_UP,
 GAMEPAD_BUTTON_RIGHT_FACE_RIGHT,
 GAMEPAD_BUTTON_RIGHT_FACE_DOWN,
 GAMEPAD_BUTTON_RIGHT_FACE_LEFT,
 GAMEPAD_BUTTON_LEFT_TRIGGER_1,
 GAMEPAD_BUTTON_LEFT_TRIGGER_2,
 GAMEPAD_BUTTON_RIGHT_TRIGGER_1,
 GAMEPAD_BUTTON_RIGHT_TRIGGER_2,
 GAMEPAD_BUTTON_MIDDLE_LEFT,
 GAMEPAD_BUTTON_MIDDLE,
 GAMEPAD_BUTTON_MIDDLE_RIGHT,
 GAMEPAD_BUTTON_LEFT_THUMB,
 GAMEPAD_BUTTON_RIGHT_THUMB


public enum 
GAMEPAD_AXIS_LEFT_X = 0,
 GAMEPAD_AXIS_LEFT_Y = 1,
 GAMEPAD_AXIS_RIGHT_X = 2,
 GAMEPAD_AXIS_RIGHT_Y = 3,
 GAMEPAD_AXIS_LEFT_TRIGGER = 4,
 GAMEPAD_AXIS_RIGHT_TRIGGER = 5
	

public enum 
MATERIAL_MAP_ALBEDO    = 0,     
    MATERIAL_MAP_METALNESS,         
    MATERIAL_MAP_NORMAL,           
    MATERIAL_MAP_ROUGHNESS,         
    MATERIAL_MAP_OCCLUSION,         
    MATERIAL_MAP_EMISSION,          
    MATERIAL_MAP_HEIGHT,            
    MATERIAL_MAP_CUBEMAP,           
    MATERIAL_MAP_IRRADIANCE,        
    MATERIAL_MAP_PREFILTER,         
    MATERIAL_MAP_BRDF           
	


public enum 
SHADER_LOC_VERTEX_POSITION = 0, 
    SHADER_LOC_VERTEX_TEXCOORD01,   
    SHADER_LOC_VERTEX_TEXCOORD02,  
    SHADER_LOC_VERTEX_NORMAL,       
    SHADER_LOC_VERTEX_TANGENT,      
    SHADER_LOC_VERTEX_COLOR,        
    SHADER_LOC_MATRIX_MVP,          
    SHADER_LOC_MATRIX_VIEW,         
    SHADER_LOC_MATRIX_PROJECTION,   
    SHADER_LOC_MATRIX_MODEL,        
    SHADER_LOC_MATRIX_NORMAL,       
    SHADER_LOC_VECTOR_VIEW,         
    SHADER_LOC_COLOR_DIFFUSE,       
    SHADER_LOC_COLOR_SPECULAR,      
    SHADER_LOC_COLOR_AMBIENT,       
    SHADER_LOC_MAP_ALBEDO,          
    SHADER_LOC_MAP_METALNESS,       
    SHADER_LOC_MAP_NORMAL,          
    SHADER_LOC_MAP_ROUGHNESS,       
    SHADER_LOC_MAP_OCCLUSION,       
    SHADER_LOC_MAP_EMISSION,        
    SHADER_LOC_MAP_HEIGHT,          
    SHADER_LOC_MAP_CUBEMAP,         
    SHADER_LOC_MAP_IRRADIANCE,      
    SHADER_LOC_MAP_PREFILTER,       
    SHADER_LOC_MAP_BRDF         
	

public enum 
SHADER_UNIFORM_FLOAT = 0,
 SHADER_UNIFORM_VEC2,
 SHADER_UNIFORM_VEC3,
 SHADER_UNIFORM_VEC4,
 SHADER_UNIFORM_INT,
 SHADER_UNIFORM_IVEC2,
 SHADER_UNIFORM_IVEC3,
 SHADER_UNIFORM_IVEC4,
 SHADER_UNIFORM_SAMPLER2D
	


public enum 
SHADER_ATTRIB_FLOAT = 0,
 SHADER_ATTRIB_VEC2,
 SHADER_ATTRIB_VEC3,
 SHADER_ATTRIB_VEC4
	

public enum 
PIXELFORMAT_UNCOMPRESSED_GRAYSCALE = 1, 
    PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA,    
    PIXELFORMAT_UNCOMPRESSED_R5G6B5,        
    PIXELFORMAT_UNCOMPRESSED_R8G8B8,       
    PIXELFORMAT_UNCOMPRESSED_R5G5B5A1,      
    PIXELFORMAT_UNCOMPRESSED_R4G4B4A4,      
    PIXELFORMAT_UNCOMPRESSED_R8G8B8A8,      
    PIXELFORMAT_UNCOMPRESSED_R32,           
    PIXELFORMAT_UNCOMPRESSED_R32G32B32,     
    PIXELFORMAT_UNCOMPRESSED_R32G32B32A32,  
    PIXELFORMAT_COMPRESSED_DXT1_RGB,        
    PIXELFORMAT_COMPRESSED_DXT1_RGBA,      
    PIXELFORMAT_COMPRESSED_DXT3_RGBA,      
    PIXELFORMAT_COMPRESSED_DXT5_RGBA,       
    PIXELFORMAT_COMPRESSED_ETC1_RGB,        
    PIXELFORMAT_COMPRESSED_ETC2_RGB,        
    PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA,   
    PIXELFORMAT_COMPRESSED_PVRT_RGB,       
    PIXELFORMAT_COMPRESSED_PVRT_RGBA,      
    PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA,  
    PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA 
	

public enum 
TEXTURE_FILTER_POINT = 0,
 TEXTURE_FILTER_BILINEAR,
 TEXTURE_FILTER_TRILINEAR,
 TEXTURE_FILTER_ANISOTROPIC_4X,
 TEXTURE_FILTER_ANISOTROPIC_8X,
 TEXTURE_FILTER_ANISOTROPIC_16X
	

public enum 
TEXTURE_WRAP_REPEAT = 0,
 TEXTURE_WRAP_CLAMP,
 TEXTURE_WRAP_MIRROR_REPEAT,
 TEXTURE_WRAP_MIRROR_CLAMP
	

public enum 
CUBEMAP_LAYOUT_AUTO_DETECT = 0,
 CUBEMAP_LAYOUT_LINE_VERTICAL,
 CUBEMAP_LAYOUT_LINE_HORIZONTAL,
 CUBEMAP_LAYOUT_CROSS_THREE_BY_FOUR,
 CUBEMAP_LAYOUT_CROSS_FOUR_BY_THREE,
 CUBEMAP_LAYOUT_PANORAMA
	

public enum 
FONT_DEFAULT = 0,
 FONT_BITMAP,
 FONT_SDF
	


public enum 
BLEND_ALPHA = 0,
 BLEND_ADDITIVE,
 BLEND_MULTIPLIED,
 BLEND_ADD_COLORS,
 BLEND_SUBTRACT_COLORS,
 BLEND_CUSTOM
	


public enum 
GESTURE_NONE = 0,
 GESTURE_TAP = 1,
 GESTURE_DOUBLETAP = 2,
 GESTURE_HOLD = 4,
 GESTURE_DRAG = 8,
 GESTURE_SWIPE_RIGHT = 16,
 GESTURE_SWIPE_LEFT = 32,
 GESTURE_SWIPE_UP = 64,
 GESTURE_SWIPE_DOWN = 128,
 GESTURE_PINCH_IN = 256,
 GESTURE_PINCH_OUT = 512
	


public enum 
CAMERA_CUSTOM = 0,
 CAMERA_FREE,
 CAMERA_ORBITAL,
 CAMERA_FIRST_PERSON,
 CAMERA_THIRD_PERSON
	


public enum 
CAMERA_PERSPECTIVE = 0,
 CAMERA_ORTHOGRAPHIC
	


public enum 
NPATCH_NINE_PATCH = 0,
 NPATCH_THREE_PATCH_VERTICAL,
 NPATCH_THREE_PATCH_HORIZONTAL
 
include std/convert.e
 
--Default Raylib Colors

public atom LIGHTGRAY = bytes_to_int({200,200,200,255})
public atom GRAY = bytes_to_int({130,130,130,255})
public atom DARKGRAY = bytes_to_int({80,80,80,255})
public atom YELLOW = bytes_to_int({253,249,0,255})
public atom GOLD = bytes_to_int({255,203,0,255})
public atom ORANGE = bytes_to_int({255,161,0,255})
public atom PINK = bytes_to_int({255,109,194,255})
public atom RED = bytes_to_int({230,41,55,255})
public atom MAROON = bytes_to_int({190,33,55,255})
public atom GREEN = bytes_to_int({0,228,48,255})
public atom LIME = bytes_to_int({0,158,47,255})
public atom DARKGREEN = bytes_to_int({0,117,44,255})
public atom SKYBLUE = bytes_to_int({102,191,255,255})
public atom BLUE = bytes_to_int({0,121,242,255})
public atom DARKBLUE = bytes_to_int({0,82,172,255})
public atom PURPLE = bytes_to_int({200,122,255,255})
public atom VIOLET = bytes_to_int({200,122,255,255})
public atom DARKPURPLE = bytes_to_int({112,31,126,255})
public atom BEIGE = bytes_to_int({211,176,131,255})
public atom BROWN = bytes_to_int({127,106,79,255})
public atom DARKBROWN = bytes_to_int({76,63,47,255})

public atom WHITE = bytes_to_int({255,255,255,255})
public atom BLACK = bytes_to_int({0,0,0,255})
public atom BLANK = bytes_to_int({0,0,0,0})
public atom MAGENTA = bytes_to_int({255,0,255,255})
public atom RAYWHITE = bytes_to_int({245,245,245,255})
­629.54