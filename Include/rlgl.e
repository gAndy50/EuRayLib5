include std/ffi.e

include raylib.e

public constant RLGL_VERSION = "5.0"

public constant RL_DEFAULT_BATCH_BUFFERS = 1,
				RL_DEFAULT_BATCH_DRAWCALLS = 256,
				RL_DEFAULT_BATCH_MAX_TEXTURE_UNINTS = 4
				
public constant RL_MAX_MATRIX_STACK_SIZE = 32

public constant RL_MAX_SHADER_LOCATIONS = 32

public constant RL_CULL_DISTANCE_NEAR = 0.01

public constant RL_CULL_DISTANCE_FAR = 1000.0

public constant RL_TEXTURE_WRAP_S = 0x2802,
				RL_TEXTURE_WRAP_T = 0x2803,
				RL_TEXTURE_MAG_FILTER = 0x2800,
				RL_TEXTURE_MIN_FILTER = 0x2801
				
public constant RL_TEXTURE_FILTER_NEAREST = 0x2600,
				RL_TEXTURE_FILTER_LINEAR = 0x2601,
				RL_TEXTURE_FILTER_MIP_NEAREST = 0x2700,
				RL_TEXTURE_FILTER_NEAREST_MIP_LINEAR = 0x2702,
				RL_TEXTURE_FILTER_LINEAR_MIP_NEAREST = 0x2701,
				RL_TEXTURE_FILTER_MIP_LINEAR = 0x2703,
				RL_TEXTURE_FILTER_ANIOSTROPIC = 0x3000,
				RL_TEXTURE_MIPMAP_BIAS_RATIO = 0x4000
				
public constant RL_TEXTURE_WRAP_REPEAT = 0x2901,
				RL_TEXTURE_WRAP_CLAMP = 0x812F,
				RL_TEXTURE_WRAP_MIRROR_REPEAT = 0x8370,
				RL_TEXTURE_WRAP_MIRROR_CLAMP = 0x8742
				
public constant RL_MODELVIEW = 0x1700,
				RL_PROJECTION = 0x1701,
				RL_TEXTURE = 0x1702
				
public constant RL_LINES = 0x0001,
				RL_TRIANGLES = 0x0004,
				RL_QUADS = 0x0007
				
public constant RL_UNSIGNED_BYTE = 0x1401,
				RL_FLOAT = 0x1406
				
public constant RL_STREAM_DRAW = 0x88E0,
				RL_STREAM_READ = 0x88E1,
				RL_STREAM_COPY = 0x88E2,
				RL_STATIC_DRAW = 0x88E4,
				RL_STATIC_READ = 0x88E5,
				RL_STATIC_COPY = 0x88E6,
				RL_DYNAMIC_DRAW = 0x88E8,
				RL_DYNAMIC_READ = 0x88E9,
				RL_DYNAMIC_COPY = 0x88EA
				
public constant RL_FRAGMENT_SHADER = 0xB30,
				RL_VERTEX_SHADER = 0x8B31,
				RL_COMPUTE_SHADER = 0x91B9
				
public constant RL_ZERO = 0,
				RL_ONE = 1,
				RL_SRC_COLOR = 0x0300,
				RL_ONE_MINUS_SCRC_COLOR = 0x031,
				RL_SRC_ALPHA = 0x0302,
				RL_ONE_MINUS_SRC_ALPHA =         0x0303,     
RL_DST_ALPHA    =                        0x0304,      
 RL_ONE_MINUS_DST_ALPHA =                 0x0305,      
 RL_DST_COLOR            =                0x0306,      
 RL_ONE_MINUS_DST_COLOR   =               0x0307,      
 RL_SRC_ALPHA_SATURATE     =              0x0308,      
 RL_CONSTANT_COLOR          =             0x8001,      
 RL_ONE_MINUS_CONSTANT_COLOR =            0x8002,      
 RL_CONSTANT_ALPHA            =           0x8003,      
 RL_ONE_MINUS_CONSTANT_ALPHA   =          0x8004 

public constant  ONE_MINUS_SRC_ALPHA  = 0x0303     
 --RL_DST_ALPHA       =                     0x0304,      
-- RL_ONE_MINUS_DST_ALPHA =                 0x0305,     
-- RL_DST_COLOR            =                0x0306,      
-- RL_ONE_MINUS_DST_COLOR   =               0x0307,      
-- RL_SRC_ALPHA_SATURATE     =              0x0308,      
 --RL_CONSTANT_COLOR          =             0x8001,      
 --RL_ONE_MINUS_CONSTANT_COLOR =            0x8002,      
 --RL_CONSTANT_ALPHA            =           0x8003,      
 --RL_ONE_MINUS_CONSTANT_ALPHA   =          0x8004  
				
public constant rlVertexBuffer = define_c_struct({
	C_INT, --elementCount
	C_POINTER, --vertices
	C_POINTER, --texcoords
	C_POINTER, --colors
	C_POINTER, --indices
	C_UINT, --vaoId
	{C_UINT,4} --vbodId[4]
})

public constant rlDrawCall = define_c_struct({
	C_INT, --mode
	C_INT, --vertexCount
	C_INT, --vertexAlignment
	C_UINT --textureId
})

public constant rlRenderBatch = define_c_struct({
	C_INT, --bufferCount
	C_INT, --currentBuffer
	C_POINTER, --vertexBuffer (rlVertexBuffer)
	C_POINTER, --draws rlDrawCall
	C_INT, --drawCounter
	C_FLOAT --currentDepth
})

public enum type rlGlVersion
	RL_OPENGL_11 = 1,
	RL_OPENGL_21,
	RL_OPENGL_33,
	RL_OPENGL_43,
	RL_OPENGL_ES_20
end type

public enum type rlTraceLogLevel
	RL_LOG_ALL = 0,
	RL_LOG_TRACE,
	RL_LOG_DEBUG,
	RL_LOG_INFO,
	RL_LOG_WARNING,
	RL_LOG_ERROR,
	RL_LOG_FATAL,
	RL_LOG_NONE
end type

public enum type rlPixelFormat
	RL_PIXELFORMAT_UNCOMPRESSED_GRAYSCALE = 1,    -- // 8 bit per pixel (no alpha)
    RL_PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA,       -- // 8*2 bpp (2 channels)
    RL_PIXELFORMAT_UNCOMPRESSED_R5G6B5,           -- // 16 bpp
    RL_PIXELFORMAT_UNCOMPRESSED_R8G8B8,           -- // 24 bpp
    RL_PIXELFORMAT_UNCOMPRESSED_R5G5B5A1,         -- // 16 bpp (1 bit alpha)
    RL_PIXELFORMAT_UNCOMPRESSED_R4G4B4A4,         -- // 16 bpp (4 bit alpha)
    RL_PIXELFORMAT_UNCOMPRESSED_R8G8B8A8,         -- // 32 bpp
    RL_PIXELFORMAT_UNCOMPRESSED_R32,              -- // 32 bpp (1 channel - float)
    RL_PIXELFORMAT_UNCOMPRESSED_R32G32B32,         --// 32*3 bpp (3 channels - float)
    RL_PIXELFORMAT_UNCOMPRESSED_R32G32B32A32,      --// 32*4 bpp (4 channels - float)
    RL_PIXELFORMAT_COMPRESSED_DXT1_RGB,            --// 4 bpp (no alpha)
    RL_PIXELFORMAT_COMPRESSED_DXT1_RGBA,           --// 4 bpp (1 bit alpha)
    RL_PIXELFORMAT_COMPRESSED_DXT3_RGBA,           --// 8 bpp
    RL_PIXELFORMAT_COMPRESSED_DXT5_RGBA,           --// 8 bpp
    RL_PIXELFORMAT_COMPRESSED_ETC1_RGB,            --// 4 bpp
    RL_PIXELFORMAT_COMPRESSED_ETC2_RGB,            --// 4 bpp
    RL_PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA,       --// 8 bpp
    RL_PIXELFORMAT_COMPRESSED_PVRT_RGB,            --// 4 bpp
    RL_PIXELFORMAT_COMPRESSED_PVRT_RGBA,           --// 4 bpp
    RL_PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA,       --// 8 bpp
    RL_PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA    
end type

public enum type rlTextureFilter
	RL_TEXTURE_FILTER_POINT = 0,
	RL_TEXTURE_FILTER_BILINEAR,
	RL_TEXTURE_FILTER_TRILINEAR,
	RL_TEXTURE_FILTER_ANISOTROPIC_4X,
	RL_TEXTURE_FILTER_ANISOTROPIC_8X,
	RL_TEXTURE_FILTER_ANISOTROPIC_16X
end type

public enum type rlBlendmode
	RL_BLEND_ALPHA = 0,
	RL_BLEND_ADDITIVE,
	RL_BLEND_MULTIPLIED,
	BL_BLEND_ADD_COLORS,
	BL_BLEND_SUBTRACT_COLORS,
	RL_BLEND_ALPHA_PREMULTIPLY,
	RL_BLEND_CUSTOM,
	RL_BLEND_CUSTOM_SEPARATE
end type

public enum type rlShaderLocationIndex
	RL_SHADER_LOC_VERTEX_POSITION = 0, -- // Shader location: vertex attribute: position
    RL_SHADER_LOC_VERTEX_TEXCOORD01,    --// Shader location: vertex attribute: texcoord01
    RL_SHADER_LOC_VERTEX_TEXCOORD02,   -- // Shader location: vertex attribute: texcoord02
    RL_SHADER_LOC_VERTEX_NORMAL,       -- // Shader location: vertex attribute: normal
    RL_SHADER_LOC_VERTEX_TANGENT,      -- // Shader location: vertex attribute: tangent
    RL_SHADER_LOC_VERTEX_COLOR,        -- // Shader location: vertex attribute: color
    RL_SHADER_LOC_MATRIX_MVP,          -- // Shader location: matrix uniform: model-view-projection
    RL_SHADER_LOC_MATRIX_VIEW,          --// Shader location: matrix uniform: view (camera transform)
    RL_SHADER_LOC_MATRIX_PROJECTION,    --// Shader location: matrix uniform: projection
    RL_SHADER_LOC_MATRIX_MODEL,         --// Shader location: matrix uniform: model (transform)
    RL_SHADER_LOC_MATRIX_NORMAL,        --// Shader location: matrix uniform: normal
    RL_SHADER_LOC_VECTOR_VIEW,          --// Shader location: vector uniform: view
    RL_SHADER_LOC_COLOR_DIFFUSE,       -- // Shader location: vector uniform: diffuse color
    RL_SHADER_LOC_COLOR_SPECULAR,      -- // Shader location: vector uniform: specular color
    RL_SHADER_LOC_COLOR_AMBIENT,       -- // Shader location: vector uniform: ambient color
    RL_SHADER_LOC_MAP_ALBEDO,           --// Shader location: sampler2d texture: albedo (same as: RL_SHADER_LOC_MAP_DIFFUSE)
    RL_SHADER_LOC_MAP_METALNESS,        --// Shader location: sampler2d texture: metalness (same as: RL_SHADER_LOC_MAP_SPECULAR)
    RL_SHADER_LOC_MAP_NORMAL,           --// Shader location: sampler2d texture: normal
    RL_SHADER_LOC_MAP_ROUGHNESS,        --// Shader location: sampler2d texture: roughness
    RL_SHADER_LOC_MAP_OCCLUSION,        --// Shader location: sampler2d texture: occlusion
    RL_SHADER_LOC_MAP_EMISSION,         --// Shader location: sampler2d texture: emission
    RL_SHADER_LOC_MAP_HEIGHT,           --// Shader location: sampler2d texture: height
    RL_SHADER_LOC_MAP_CUBEMAP,          --// Shader location: samplerCube texture: cubemap
    RL_SHADER_LOC_MAP_IRRADIANCE,       --// Shader location: samplerCube texture: irradiance
    RL_SHADER_LOC_MAP_PREFILTER,        --// Shader location: samplerCube texture: prefilter
    RL_SHADER_LOC_MAP_BRDF      
end type

public constant RL_SHADER_LOC_MAP_DIFFUSE = RL_SHADER_LOC_MAP_ALBEDO,
				RL_SHADER_LOC_MAP_SPECULAR = RL_SHADER_LOC_MAP_METALNESS
				
public enum type rlShaderUniformDataType
	RL_SHADER_UNIFORM_FLOAT = 0,    --    // Shader uniform type: float
    RL_SHADER_UNIFORM_VEC2,          --   // Shader uniform type: vec2 (2 float)
    RL_SHADER_UNIFORM_VEC3,           --  // Shader uniform type: vec3 (3 float)
    RL_SHADER_UNIFORM_VEC4,            -- // Shader uniform type: vec4 (4 float)
    RL_SHADER_UNIFORM_INT,             -- // Shader uniform type: int
    RL_SHADER_UNIFORM_IVEC2,            --// Shader uniform type: ivec2 (2 int)
    RL_SHADER_UNIFORM_IVEC3,            --// Shader uniform type: ivec3 (3 int)
    RL_SHADER_UNIFORM_IVEC4,            --// Shader uniform type: ivec4 (4 int)
    RL_SHADER_UNIFORM_SAMPLER2D   
end type

public enum type rlShaderAttributeDataType
	RL_SHADER_ATTRIB_FLOAT = 0,
	RL_SHADER_ATTRIB_VEC2,
	RL_SHADER_ATTRIB_VEC3,
	RL_SHADER_ATTRIB_VEC4
end type

public enum type rlFramebufferAttachType
	RL_ATTACHMENT_COLOR_CHANNEL0 = 0,  -- // Framebuffer attachment type: color 0
    RL_ATTACHMENT_COLOR_CHANNEL1,       --// Framebuffer attachment type: color 1
    RL_ATTACHMENT_COLOR_CHANNEL2,       --// Framebuffer attachment type: color 2
    RL_ATTACHMENT_COLOR_CHANNEL3,       --// Framebuffer attachment type: color 3
    RL_ATTACHMENT_COLOR_CHANNEL4,       --// Framebuffer attachment type: color 4
    RL_ATTACHMENT_COLOR_CHANNEL5,       --// Framebuffer attachment type: color 5
    RL_ATTACHMENT_COLOR_CHANNEL6,       --// Framebuffer attachment type: color 6
    RL_ATTACHMENT_COLOR_CHANNEL7,       --// Framebuffer attachment type: color 7
    RL_ATTACHMENT_DEPTH = 100,          --// Framebuffer attachment type: depth
    RL_ATTACHMENT_STENCIL = 200
end type

public enum type rlFramebufferAttachTextureType
    RL_ATTACHMENT_CUBEMAP_POSITIVE_X = 0, --// Framebuffer texture attachment type: cubemap, +X side
    RL_ATTACHMENT_CUBEMAP_NEGATIVE_X,   --// Framebuffer texture attachment type: cubemap, -X side
    RL_ATTACHMENT_CUBEMAP_POSITIVE_Y,   --// Framebuffer texture attachment type: cubemap, +Y side
    RL_ATTACHMENT_CUBEMAP_NEGATIVE_Y,   --// Framebuffer texture attachment type: cubemap, -Y side
    RL_ATTACHMENT_CUBEMAP_POSITIVE_Z,   --// Framebuffer texture attachment type: cubemap, +Z side
    RL_ATTACHMENT_CUBEMAP_NEGATIVE_Z,   --// Framebuffer texture attachment type: cubemap, -Z side
    RL_ATTACHMENT_TEXTURE2D = 100,      --// Framebuffer texture attachment type: texture2d
    RL_ATTACHMENT_RENDERBUFFER = 200
end type

public enum type rlCullMode
	RL_CULL_FACE_FRONT = 0,
	RL_CULL_FACE_BACK
end type

export constant xrlMatrixMode = define_c_proc(ray,"+rlMatrixMode",{C_INT}),
				xrlPushMatrix = define_c_proc(ray,"+rlPushMatrix",{}),
				xrlPopMatrix = define_c_proc(ray,"+rlPopMatrix",{}),
				xrlLoadIdentity = define_c_proc(ray,"+rlLoadIdentity",{}),
				xrlTranslatef = define_c_proc(ray,"+rlTranslatef",{C_FLOAT,C_FLOAT,C_FLOAT}),
				xrlRotatef = define_c_proc(ray,"+rlRotatef",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT}),
				xrlScalef = define_c_proc(ray,"+rlScalef",{C_FLOAT,C_FLOAT,C_FLOAT}),
				xrlMultMatrixf = define_c_proc(ray,"+rlMultiMatrixf",{C_POINTER}),
				xrlFrustum = define_c_proc(ray,"+rlFrustum",{C_DOUBLE,C_DOUBLE,C_DOUBLE,C_DOUBLE,C_DOUBLE,C_DOUBLE}),
				xrlOrtho = define_c_proc(ray,"+rlOrtho",{C_DOUBLE,C_DOUBLE,C_DOUBLE,C_DOUBLE,C_DOUBLE,C_DOUBLE}),
				xrlViewport = define_c_proc(ray,"+rlViewport",{C_INT,C_INT,C_INT,C_INT})
				
public procedure rlMatrixMode(atom mode)
	c_proc(xrlMatrixMode,{mode})
end procedure

public procedure rlPushMatrix()
	c_proc(xrlPushMatrix,{})
end procedure

public procedure rlPopMatrix()
	c_proc(xrlPopMatrix,{})
end procedure

public procedure rlLoadIdentity()
	c_proc(xrlLoadIdentity,{})
end procedure

public procedure rlTranslatef(atom x,atom y,atom z)
	c_proc(xrlTranslatef,{x,y,z})
end procedure

public procedure rlRotatef(atom angle,atom x,atom y,atom z)
	c_proc(xrlRotatef,{angle,x,y,z})
end procedure

public procedure rlScalef(atom x,atom y,atom z)
	c_proc(xrlScalef,{x,y,z})
end procedure

public procedure rlMultMatrixf(atom mat)
	c_proc(xrlMultMatrixf,{mat})
end procedure

public procedure rlFrustum(atom left,atom right,atom bottom,atom top,atom znear,atom zfar)
	c_proc(xrlFrustum,{left,right,bottom,top,znear,zfar})
end procedure

public procedure rlOrtho(atom left,atom right,atom bottom,atom top,atom znear,atom zfar)
	c_proc(xrlOrtho,{left,right,bottom,top,znear,zfar})
end procedure

public procedure rlViewport(atom x,atom y,atom w,atom h)
	c_proc(xrlViewport,{x,y,w,h})
end procedure

export constant xrlBegin = define_c_proc(ray,"+rlBegin",{C_INT}),
				xrlEnd = define_c_proc(ray,"+rlEnd",{}),
				xrlVertex2i = define_c_proc(ray,"+rlVertex2i",{C_INT,C_INT}),
				xrlVertex2f = define_c_proc(ray,"+rlVertex2f",{C_FLOAT,C_FLOAT}),
				xrlVertex3f = define_c_proc(ray,"+rlVertex3f",{C_FLOAT,C_FLOAT,C_FLOAT}),
				xrlTexCoord2f = define_c_proc(ray,"+rlTexCoord2f",{C_FLOAT,C_FLOAT}),
				xrlNormal3f = define_c_proc(ray,"+rlNormal3f",{C_FLOAT,C_FLOAT,C_FLOAT}),
				xrlColor4ub = define_c_proc(ray,"+rlColor4ub",{C_UCHAR,C_UCHAR,C_UCHAR,C_UCHAR}),
				xrlColor3f = define_c_proc(ray,"+rlColor3f",{C_FLOAT,C_FLOAT,C_FLOAT}),
				xrlColor4f = define_c_proc(ray,"+rlColor4f",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT})
				
public procedure rlBegin(atom mode)
	c_proc(xrlBegin,{mode})
end procedure

public procedure rlEnd()
	c_proc(xrlEnd,{})
end procedure

public procedure rlVertex2i(atom x,atom y)
	c_proc(xrlVertex2i,{x,y})
end procedure

public procedure rlVertex2f(atom x,atom y)
	c_proc(xrlVertex2f,{x,y})
end procedure

public procedure rlVertex3f(atom x,atom y,atom z)
	c_proc(xrlVertex3f,{x,y,z})
end procedure

public procedure rlTexCoord2f(atom x,atom y)
	c_proc(xrlTexCoord2f,{x,y})
end procedure

public procedure rlNormal3f(atom x,atom y,atom z)
	c_proc(xrlNormal3f,{x,y,z})
end procedure

public procedure rlColor4ub(atom r,atom g,atom b,atom a)
	c_proc(xrlColor4ub,{r,g,b,a})
end procedure

public procedure rlColor3f(atom x,atom y,atom z)
	c_proc(xrlColor3f,{x,y,z})
end procedure

public procedure rlColor4f(atom x,atom y,atom z,atom w)
	c_proc(xrlColor4f,{x,y,z,w})
end procedure

export constant xrlEnableVertexArray = define_c_func(ray,"+rlEnableVertexArray",{C_UINT},C_BOOL),
				xrlDisableVertexArray = define_c_proc(ray,"+rlDisableVertexArray",{}),
				xrlEnableVertexBuffer = define_c_proc(ray,"rlEnableVertexBuffer",{C_UINT}),
				xrlDisableVertexBuffer = define_c_proc(ray,"+rlDisableVertexBuffer",{}),
				xrlEnableVertexBufferElement = define_c_proc(ray,"+rlEnableVertexBufferElement",{C_UINT}),
				xrlDisableVertexBufferElement = define_c_proc(ray,"+rlDisableVertexBufferElement",{}),
				xrlEnableVertexAttribute = define_c_proc(ray,"+rlEnableVertexAttribute",{C_UINT}),
				xrlDisableVertexAttribute = define_c_proc(ray,"+rlDisableVertexAttribute",{C_UINT}),
				xrlEnableStatePointer = define_c_proc(ray,"+rlEnableStatePointer",{C_INT,C_POINTER}),
				xrlDisableStatePointer = define_c_proc(ray,"+rlDisableStatePointer",{C_INT})
				
public function rlEnableVertexArray(atom id)
	return c_func(xrlEnableVertexArray,{id})
end function

public procedure rlDisableVertexArray()
	c_proc(xrlDisableVertexArray,{})
end procedure

public procedure rlEnableVertexBuffer(atom id)
	c_proc(xrlEnableVertexBuffer,{id})
end procedure

public procedure rlDisableVertexBuffer()
	c_proc(xrlDisableVertexBuffer,{})
end procedure

public procedure rlEnableVertexBufferElement(atom id)
	c_proc(xrlEnableVertexBufferElement,{id})
end procedure

public procedure rlDisableVertexBufferElement()
	c_proc(xrlDisableVertexBufferElement,{})
end procedure

public procedure rlEnableVertexAttribute(atom index)
	c_proc(xrlEnableVertexAttribute,{index})
end procedure

public procedure rlDisableVertexAttribute(atom index)
	c_proc(xrlDisableVertexAttribute,{index})
end procedure

public procedure rlEnableStatePointer(atom vertexAT,atom buffer)
	c_proc(xrlEnableStatePointer,{vertexAT,buffer})
end procedure

public procedure rlDisableStatePointer(atom vertexAT)
	c_proc(xrlDisableStatePointer,{vertexAT})
end procedure

export constant xrlActiveTextureSlot = define_c_proc(ray,"+rlActiveTextureSlot",{C_INT}),
				xrlEnableTexture = define_c_proc(ray,"+rlEnableTexture",{C_UINT}),
				xrlDisableTexture = define_c_proc(ray,"+rlDisableTexture",{}),
				xrlEnableTextureCubemap = define_c_proc(ray,"+rlEnableTextureCubemap",{C_UINT}),
				xrlDisableTextureCubemap = define_c_proc(ray,"+rlDisableTextureCubemap",{}),
				xrlTextureParameters = define_c_proc(ray,"+rlTextureParameters",{C_UINT,C_INT,C_INT}),
				xrlCubemapParameters = define_c_proc(ray,"+rlCubemapParameters",{C_UINT,C_INT,C_INT})
				
public procedure rlActiveTextureSlot(atom slot)
	c_proc(xrlActiveTextureSlot,{slot})
end procedure

public procedure rlEnableTexture(atom id)
	c_proc(xrlEnableTexture,{id})
end procedure

public procedure rlDisableTexture()
	c_proc(xrlDisableTexture,{})
end procedure

public procedure rlEnableTextureCubemap(atom id)
	c_proc(xrlEnableTextureCubemap,{id})
end procedure

public procedure rlDisableTextureCubemap()
	c_proc(xrlDisableTextureCubemap,{})
end procedure

public procedure rlTextureParameters(atom id,atom parm,atom val)
	c_proc(xrlTextureParameters,{id,parm,val})
end procedure

public procedure rlCubemapParameters(atom id,atom parm,atom val)
	c_proc(xrlCubemapParameters,{id,parm,val})
end procedure

export constant xrlEnableShader = define_c_proc(ray,"+rlEnableShader",{C_UINT}),
				xrlDisableShader = define_c_proc(ray,"+rlDisableShader",{})
				
public procedure rlEnableShader(atom id)
	c_proc(xrlEnableShader,{id})
end procedure

public procedure rlDisableShader()
	c_proc(xrlDisableShader,{})
end procedure

export constant xrlEnableFramebuffer = define_c_proc(ray,"+rlEnableFramebuffer",{C_UINT}),
				xrlDisableFramebuffer = define_c_proc(ray,"+rlDisableFramebuffer",{}),
				xrlActiveDrawBuffers = define_c_proc(ray,"+rlActiveDrawBuffers",{C_INT})
				
public procedure rlEnableFramebuffer(atom id)
	c_proc(xrlEnableFramebuffer,{id})
end procedure

public procedure rlDisableFramebuffer()
	c_proc(xrlDisableFramebuffer,{})
end procedure

public procedure rlActiveDrawBuffers(atom cnt)
	c_proc(xrlActiveDrawBuffers,{cnt})
end procedure

export constant xrlEnableColorBlend = define_c_proc(ray,"+rlEnableColorBlend",{}),
				xrlDisableColorBlend = define_c_proc(ray,"+rlDisableColorBlend",{}),
				xrlEnableDepthTest = define_c_proc(ray,"+rlEnableDepthTest",{}),
				xrlDisableDepthTest = define_c_proc(ray,"+rlDisableDepthTest",{}),
				xrlEnableDepthMask = define_c_proc(ray,"+rlEnableDepthMask",{}),
				xrlDisableDepthMask = define_c_proc(ray,"+rlDisableDepthMask",{}),
				xrlEnableBackfaceCulling = define_c_proc(ray,"+rlEnableBackfaceCulling",{}),
				xrlDisableBackfaceCulling = define_c_proc(ray,"+rlDisableBackfaceCulling",{}),
				xrlSetCullFace = define_c_proc(ray,"+rlSetCullFace",{C_INT}),
				xrlEnableScissorTest = define_c_proc(ray,"+rlEnableScissorTest",{}),
				xrlDisableScissorTest = define_c_proc(ray,"+rlDisableScissorTest",{}),
				xrlScissor = define_c_proc(ray,"+rlScissor",{C_INT,C_INT,C_INT,C_INT}),
				xrlEnableWireMode = define_c_proc(ray,"+rlEnableWireMode",{}),
				xrlDisableWireMode = define_c_proc(ray,"+rlDisableWireMode",{}),
				xrlSetLineWidth = define_c_proc(ray,"+rlSetLineWidth",{C_FLOAT}),
				xrlGetLineWidth = define_c_func(ray,"+rlGetLineWidth",{},C_FLOAT),
				xrlEnableSmoothLines = define_c_proc(ray,"+rlEnableSmoothLines",{}),
				xrlDisableSmoothLines = define_c_proc(ray,"+rlDisableSmoothLines",{}),
				xrlEnableStereoRender = define_c_proc(ray,"+rlEnableStereoRender",{}),
				xrlDisableStereoRender = define_c_proc(ray,"+rlDisableStereoRender",{}),
				xrlIsStereoRenderEnabled = define_c_func(ray,"+rlIsStereoRenderEnabled",{},C_BOOL)
				
public procedure rlEnableColorBlend()
	c_proc(xrlEnableColorBlend,{})
end procedure

public procedure rlDisableColorBlend()
	c_proc(xrlDisableColorBlend,{})
end procedure

public procedure rlEnableDepthTest()
	c_proc(xrlEnableDepthTest,{})
end procedure

public procedure rlDisableDepthTest()
	c_proc(xrlDisableDepthTest,{})
end procedure

public procedure rlEnableDepthMask()
	c_proc(xrlEnableDepthMask,{})
end procedure

public procedure rlDisableDepthMask()
	c_proc(xrlDisableDepthMask,{})
end procedure

public procedure rlEnableBackfaceCulling()
	c_proc(xrlEnableBackfaceCulling,{})
end procedure

public procedure rlDisableBackfaceCulling()
	c_proc(xrlDisableBackfaceCulling,{})
end procedure

public procedure rlSetCullFace(atom mode)
	c_proc(xrlSetCullFace,{mode})
end procedure

public procedure rlEnableScissorTest()
	c_proc(xrlEnableScissorTest,{})
end procedure

public procedure rlDisableScissorTest()
	c_proc(xrlDisableScissorTest,{})
end procedure

public procedure rlScissor(atom x,atom y,atom w,atom h)
	c_proc(xrlScissor,{x,y,w,h})
end procedure

public procedure rlEnableWireMode()
	c_proc(xrlEnableWireMode,{})
end procedure

public procedure rlDisableWireMode()
	c_proc(xrlDisableWireMode,{})
end procedure

public procedure rlSetLineWidth(atom w)
	c_proc(xrlSetLineWidth,{w})
end procedure

public function rlGetLineWidth()
	return c_func(xrlGetLineWidth,{})
end function

public procedure rlEnableSmoothLines()
	c_proc(xrlEnableSmoothLines,{})
end procedure

public procedure rlDisableSmoothLines()
	c_proc(xrlDisableSmoothLines,{})
end procedure

public procedure rlEnableStereoRender()
	c_proc(xrlEnableStereoRender,{})
end procedure

public procedure rlDisableStereoRender()
	c_proc(xrlDisableStereoRender,{})
end procedure

public function rlIsStereoRenderEnabled()
	return c_func(xrlIsStereoRenderEnabled,{})
end function

export constant xrlClearColor = define_c_proc(ray,"+rlClearColor",{C_UCHAR,C_UCHAR,C_UCHAR,C_UCHAR}),
				xrlClearScreenBuffers = define_c_proc(ray,"+rlClearScreenBuffers",{}),
				xrlCheckErrors = define_c_proc(ray,"+rlCheckErrors",{}),
				xrlSetBlendMode = define_c_proc(ray,"+rlSetBlendMode",{C_INT}),
				xrlSetBlendFactors = define_c_proc(ray,"+rlSetBlendFactors",{C_INT,C_INT,C_INT}),
				xrlSetBlendFactorsSeparate = define_c_proc(ray,"+rlSetBlendFactorsSeparate",{C_INT,C_INT,C_INT,C_INT,C_INT,C_INT})
				
public procedure rlClearColor(atom r,atom g,atom b,atom a)
	c_proc(xrlClearColor,{r,g,b,a})
end procedure

public procedure rlClearScreenBuffers()
	c_proc(xrlClearScreenBuffers,{})
end procedure

public procedure rlCheckErrors()
	c_proc(xrlCheckErrors,{})
end procedure

public procedure rlSetBlendMode(atom mode)
	c_proc(xrlSetBlendMode,{mode})
end procedure

public procedure rlSetBlendFactors(atom src,atom dst,atom equ)
	c_proc(xrlSetBlendFactors,{src,dst,equ})
end procedure

public procedure rlSetBlendFactorsSeparate(atom src,atom dst,atom srcA,atom dstA,atom eq,atom eqA)
	c_proc(xrlSetBlendFactorsSeparate,{src,dst,srcA,dstA,eq,eqA})
end procedure


export constant xrlglInit = define_c_proc(ray,"+rlglInit",{C_INT,C_INT}),
				xrlglClose = define_c_proc(ray,"+rlglClose",{}),
				xrlLoadExtensions = define_c_proc(ray,"+rlLoadExtensions",{C_POINTER}),
				xrlGetVersion = define_c_func(ray,"+rlGetVersion",{},C_INT),
				xrlSetFramebufferWidth = define_c_proc(ray,"+rlSetFramebufferWidth",{C_INT}),
				xrlGetFramebufferWidth = define_c_func(ray,"+rlGetFramebufferWidth",{},C_INT),
				xrlSetFramebufferHeight = define_c_proc(ray,"+rlSetFramebufferHeight",{C_INT}),
				xrlGetFramebufferHeight = define_c_func(ray,"+rlGetFramebufferHeight",{},C_INT)
				
public procedure rlglInit(atom w,atom h)
	c_proc(xrlglInit,{w,h})
end procedure

public procedure rlglClose()
	c_proc(xrlglClose,{})
end procedure

public procedure rlLoadExtensions(atom load)
	c_proc(xrlLoadExtensions,{load})
end procedure

public function rlGetVersion()
	return c_func(xrlGetVersion,{})
end function

public procedure rlSetFramebufferWidth(atom w)
	c_proc(xrlSetFramebufferWidth,{w})
end procedure

public function rlGetFramebufferWidth()
	return c_func(xrlGetFramebufferWidth,{})
end function

public procedure rlSetFramebufferHeight(atom h)
	c_proc(xrlSetFramebufferHeight,{h})
end procedure

public function rlGetFramebufferHeight()
	return c_func(xrlGetFramebufferHeight,{})
end function

export constant xrlGetTextureIdDefault = define_c_func(ray,"+rlGetTextureIdDefault",{},C_UINT),
				xrlGetShaderIdDefault = define_c_func(ray,"+rlGetShaderIdDefault",{},C_UINT),
				xrlGetShaderLocsDefault = define_c_func(ray,"+rlGetShaderLocsDefault",{},C_POINTER)
				
public function rlGetTextureIdDefault()
	return c_func(xrlGetTextureIdDefault,{})
end function

public function rlGetShaderIdDefault()
	return c_func(xrlGetShaderIdDefault,{})
end function

public function rlGetShaderLocsDefault()
	return c_func(xrlGetShaderLocsDefault,{})
end function

export constant xrlLoadRenderBatch = define_c_func(ray,"+rlLoadRenderBatch",{C_INT,C_INT},rlRenderBatch),
				xrlUnloadRenderBatch = define_c_proc(ray,"+rlUnloadRenderBatch",{rlRenderBatch}),
				xrlDrawRenderBatch = define_c_proc(ray,"+rlDrawRenderBatch",{C_POINTER}),
				xrlSetRenderBatchActive = define_c_proc(ray,"+rlSetRenderBatchActive",{C_POINTER}),
				xrlDrawRenderBatchActive = define_c_proc(ray,"+rlDrawRenderBatchActive",{}),
				xrlCheckRenderBatchLimit = define_c_func(ray,"+rlCheckRenderBatchLimit",{C_INT},C_BOOL)
				
public function rlLoadRenderBatch(atom num,atom ele)
	return c_func(xrlLoadRenderBatch,{num,ele})
end function

public procedure rlUnloadRenderBatch(sequence batch)
	c_proc(xrlUnloadRenderBatch,{batch})
end procedure

public procedure rlDrawRenderBatch(atom bat)
	c_proc(xrlDrawRenderBatch,{bat})
end procedure

public procedure rlSetRenderBatchActive(atom bat)
	c_proc(xrlSetRenderBatchActive,{bat})
end procedure

public procedure rlDrawRenderBatchActive()
	c_proc(xrlDrawRenderBatchActive,{})
end procedure

public function rlCheckRenderBatchLimit(atom cnt)
	return c_func(xrlCheckRenderBatchLimit,{cnt})
end function

export constant xrlSetTexture = define_c_proc(ray,"+rlSetTexture",{C_UINT})

public procedure rlSetTexture(atom id)
	c_proc(xrlSetTexture,{id})
end procedure

export constant xrlLoadVertexArray = define_c_func(ray,"+rlLoadVertexArray",{},C_UINT),
				xrlLoadVertexBuffer = define_c_func(ray,"+rlLoadVertexBuffer",{C_POINTER,C_INT,C_BOOL},C_UINT),
				xrlLoadVertexBufferElement = define_c_func(ray,"+rlLoadVertexBufferElement",{C_POINTER,C_INT,C_BOOL},C_UINT),
				xrlUpdateVertexBuffer = define_c_proc(ray,"+rlUpdateVertexBuffer",{C_UINT,C_POINTER,C_INT,C_INT}),
				xrlUpdateVertexBufferElements = define_c_proc(ray,"+rlUpdateVertexBufferElements",{C_UINT,C_POINTER,C_INT,C_INT}),
				xrlUnloadVertexArray = define_c_proc(ray,"+rlUnloadVertexArray",{C_UINT}),
				xrlUnloadVertexBuffer = define_c_proc(ray,"+rlUnloadVertexBuffer",{C_UINT}),
				xrlSetVertexAttribute = define_c_proc(ray,"+rlSetVertexAttribute",{C_UINT,C_INT,C_INT,C_BOOL,C_INT,C_POINTER}),
				xrlSetVertexAttributeDivisor = define_c_proc(ray,"+rlSetVertexAttributeDivisor",{C_UINT,C_INT}),
				xrlSetVertexAttributeDefault = define_c_proc(ray,"+rlSetVertexAttributeDefault",{C_INT,C_POINTER,C_INT,C_INT}),
				xrlDrawVertexArray = define_c_proc(ray,"+rlDrawVertexArray",{C_INT,C_INT}),
				xrlDrawVertexArrayElements = define_c_proc(ray,"+rlDrawVertexArrayElements",{C_INT,C_INT,C_POINTER}),
				xrlDrawVertexArrayInstanced = define_c_proc(ray,"+rlDrawVertexArrayInstanced",{C_INT,C_INT,C_INT}),
				xrlDrawVertexArrayElementsInstanced = define_c_proc(ray,"+rlDrawVertexArrayElementsInstanced",{C_INT,C_INT,C_POINTER,C_INT})
				
public function rlLoadVertexArray()
	return c_func(xrlLoadVertexArray,{})
end function

public function rlLoadVertexBuffer(atom buff,atom size,atom dynamic)
	return c_func(xrlLoadVertexBuffer,{buff,size,dynamic})
end function

public function rlLoadVertexBufferElement(atom buff,atom size,atom dynamic)
	return c_func(xrlLoadVertexBufferElement,{buff,size,dynamic})
end function

public procedure rlUpdateVertexBuffer(atom id,atom dat,atom size,atom off)
	c_proc(xrlUpdateVertexBuffer,{id,dat,size,off})
end procedure

public procedure rlUpdateVertexBufferElements(atom id,atom dat,atom size,atom off)
	c_proc(xrlUpdateVertexBufferElements,{id,dat,size,off})
end procedure

public procedure rlUnloadVertexArray(atom id)
	c_proc(xrlUnloadVertexArray,{id})
end procedure

public procedure rlUnloadVertexBuffer(atom id)
	c_proc(xrlUnloadVertexBuffer,{id})
end procedure

public procedure rlSetVertexAttribute(atom index,atom size,atom t,atom normal,atom stride,atom ptr)
	c_proc(xrlSetVertexAttribute,{index,size,t,normal,stride,ptr})
end procedure

public procedure rlSetVertexAttributeDivisor(atom index,atom div)
	c_proc(xrlSetVertexAttributeDivisor,{index,div})
end procedure

public procedure rlSetVertexAttributeDefault(atom index,atom val,atom at,atom cnt)
	c_proc(xrlSetVertexAttributeDefault,{index,val,at,cnt})
end procedure

public procedure rlDrawVertexArray(atom off,atom cnt)
	c_proc(xrlDrawVertexArray,{off,cnt})
end procedure

public procedure rlDrawVertexArrayElements(atom off,atom cnt,atom buf)
	c_proc(xrlDrawVertexArrayElements,{off,cnt,buf})
end procedure

public procedure rlDrawVertexArrayInstanced(atom off,atom cnt,atom inst)
	c_proc(xrlDrawVertexArrayInstanced,{off,cnt,inst})
end procedure

public procedure rlDrawVertexArrayElementsInstanced(atom off,atom cnt,atom buf,atom inst)
	c_proc(xrlDrawVertexArrayElementsInstanced,{off,cnt,buf,inst})
end procedure

export constant xrlLoadTexture = define_c_func(ray,"+rlLoadTexture",{C_POINTER,C_INT,C_INT,C_INT,C_INT},C_UINT),
				xrlLoadTextureDepth = define_c_func(ray,"+rlLoadTextureDepth",{C_INT,C_INT,C_BOOL},C_UINT),
				xrlLoadTextureCubemap = define_c_func(ray,"+rlLoadTextureCubemap",{C_POINTER,C_INT,C_INT},C_UINT),
				xrlUpdateTexture = define_c_proc(ray,"+rlUpdateTexture",{C_UINT,C_INT,C_INT,C_INT,C_INT,C_INT,C_POINTER}),
				xrlGetGlTextureFormats = define_c_proc(ray,"+rlGetGlTextureFormats",{C_INT,C_POINTER,C_POINTER,C_POINTER}),
				xrlGetPixelFormatName = define_c_func(ray,"+rlGetPixelFormatName",{C_UINT},C_STRING),
				xrlUnloadTexture = define_c_proc(ray,"+rlUnloadTexture",{C_UINT}),
				xrlGenTextureMipmaps = define_c_proc(ray,"+rlGenTextureMipmaps",{C_UINT,C_INT,C_INT,C_INT,C_POINTER}),
				xrlReadTexturePixels = define_c_func(ray,"+rlReadTexturePixels",{C_UINT,C_INT,C_INT,C_INT},C_POINTER),
				xrlReadScreenPixels = define_c_func(ray,"+rlReadScreenPixels",{C_INT,C_INT},C_POINTER)
				
public function rlLoadTexture(atom dat,atom w,atom h,atom mat,atom mip)
	return c_func(xrlLoadTexture,{dat,w,h,mat,mip})
end function

public function rlLoadTextureDepth(atom w,atom h,atom use)
	return c_func(xrlLoadTextureDepth,{w,h,use})
end function

public function rlLoadTextureCubemap(atom dat,atom size,atom mat)
	return c_func(xrlLoadTextureCubemap,{dat,size,mat})
end function

public procedure rlUpdateTexture(atom id,atom x,atom y,atom w,atom h,atom mat,atom dat)
	c_proc(xrlUpdateTexture,{id,x,y,w,h,mat,dat})
end procedure

public procedure rlGetGlTextureFormats(atom mat,atom ift,atom lf,atom gt)
	c_proc(xrlGetGlTextureFormats,{mat,ift,lf,gt})
end procedure

public function rlGetPixelFormatName(atom mat)
	return c_func(xrlGetPixelFormatName,{mat})
end function

public procedure rlUnloadTexture(atom id)
	c_proc(xrlUnloadTexture,{id})
end procedure

public procedure rlGenTextureMipmaps(atom id,atom w,atom h,atom mat,atom mip)
	c_proc(xrlGenTextureMipmaps,{id,w,h,mat,mip})
end procedure

public function rlReadTexturePixels(atom id,atom w,atom h,atom mat)
	return c_func(xrlReadTexturePixels,{id,w,h,mat})
end function

public function rlReadScreenPixels(atom w,atom h)
	return c_func(xrlReadScreenPixels,{w,h})
end function

export constant xrlLoadFramebuffer = define_c_func(ray,"+rlLoadFramebuffer",{C_INT,C_INT},C_UINT),
				xrlFramebufferAttach = define_c_proc(ray,"+rlFramebufferAttach",{C_UINT,C_UINT,C_INT,C_INT,C_INT}),
				xrlFramebufferComplete = define_c_proc(ray,"+rlFramebufferComplete",{C_UINT}),
				xrlUnloadFramebuffer = define_c_proc(ray,"+rlUnloadFramebuffer",{C_UINT})
				
public function rlLoadFramebuffer(atom w,atom h)
	return c_func(xrlLoadFramebuffer,{w,h})
end function

public procedure rlFramebufferAttach(atom fbid,atom texid,atom at,atom tt,atom ml)
	c_proc(xrlFramebufferAttach,{fbid,texid,at,tt,ml})
end procedure

public procedure rlFramebufferComplete(atom id)
	c_proc(xrlFramebufferComplete,{id})
end procedure

public procedure rlUnloadFramebuffer(atom id)
	c_proc(xrlUnloadFramebuffer,{id})
end procedure

export constant xrlLoadShaderCode = define_c_func(ray,"+rlLoadShaderCode",{C_STRING,C_STRING},C_UINT),
				xrlCompileShader = define_c_func(ray,"+rlCompileShader",{C_STRING,C_INT},C_UINT),
				xrlLoadShaderProgram = define_c_func(ray,"+rlLoadShaderProgram",{C_UINT,C_UINT},C_UINT),
				xrlUnloadShaderProgram = define_c_proc(ray,"+rlUnloadShaderProgram",{C_UINT}),
				xrlGetLocationUniform = define_c_func(ray,"+rlGetLocationUniform",{C_UINT,C_STRING},C_INT),
				xrlGetLocationAttrib = define_c_func(ray,"+rlGetLocationAttrib",{C_UINT,C_STRING},C_INT),
				xrlSetUniform = define_c_proc(ray,"+rlSetUniform",{C_INT,C_POINTER,C_INT,C_INT}),
				xrlSetUniformMatrix = define_c_proc(ray,"+rlSetUniformMatrix",{C_INT,Matrix}),
				xrlSetUniformSampler = define_c_proc(ray,"+rlSetUniformSampler",{C_INT,C_UINT}),
				xrlSetShader = define_c_proc(ray,"+rlSetShader",{C_UINT,C_POINTER})
				
public function rlLoadShaderCode(sequence vs,sequence fs)
	return c_func(xrlLoadShaderCode,{vs,fs})
end function

public function rlCompileShader(sequence sc,atom t)
	return c_func(xrlCompileShader,{sc,t})
end function

public function rlLoadShaderProgram(atom id,atom id2)
	return c_func(xrlLoadShaderProgram,{id,id2})
end function

public procedure rlUnloadShaderProgram(atom id)
	c_proc(xrlUnloadShaderProgram,{id})
end procedure

public function rlGetLocationUniform(atom id,sequence name)
	return c_func(xrlGetLocationUniform,{id,name})
end function

public function rlGetLocationAttrib(atom id,sequence name)
	return c_func(xrlGetLocationAttrib,{id,name})
end function

public procedure rlSetUniform(atom index,atom val,atom ut,atom cnt)
	c_proc(xrlSetUniform,{index,val,ut,cnt})
end procedure

public procedure rlSetUniformMatrix(atom idx,sequence mat)
	c_proc(xrlSetUniformMatrix,{idx,mat})
end procedure

public procedure rlSetUniformSampler(atom idx,atom id)
	c_proc(xrlSetUniformSampler,{idx,id})
end procedure

public procedure rlSetShader(atom id,atom locs)
	c_proc(xrlSetShader,{id,locs})
end procedure

export constant xrlLoadComputeShaderProgram = define_c_func(ray,"+rlLoadComputeShaderProgram",{C_UINT},C_UINT),
				xrlComputeShaderDispatch = define_c_proc(ray,"+rlComputeShaderDispatch",{C_UINT,C_UINT,C_UINT})
				
public function rlLoadComputeShaderProgram(atom id)
	return c_func(xrlLoadComputeShaderProgram,{id})
end function

public procedure rlComputeShaderDispatch(atom x,atom y,atom z)
	c_proc(xrlComputeShaderDispatch,{x,y,z})
end procedure

export constant xrlLoadShaderBuffer = define_c_func(ray,"+rlLoadShaderBuffer",{C_UINT,C_POINTER,C_INT},C_UINT),
				xrlUnloadShaderBuffer = define_c_proc(ray,"+rlUnloadShaderBuffer",{C_UINT}),
				xrlUpdateShaderBuffer = define_c_proc(ray,"+rlUpdateShaderBuffer",{C_UINT,C_POINTER,C_UINT,C_UINT}),
				xrlBindShaderBuffer = define_c_proc(ray,"+rlBindShaderBuffer",{C_UINT,C_UINT}),
				xrlReadShaderBuffer = define_c_proc(ray,"+rlReadShaderBuffer",{C_INT,C_POINTER,C_UINT,C_UINT}),
				xrlCopyShaderBuffer = define_c_proc(ray,"+rlCopyShaderBuffer",{C_UINT,C_UINT,C_UINT,C_UINT,C_UINT}),
				xrlGetShaderBufferSize = define_c_func(ray,"+rlGetShaderBufferSize",{C_UINT},C_UINT)
				
public function rlLoadShaderBuffer(atom size,atom dat,atom uh)
	return c_func(xrlLoadShaderBuffer,{size,dat,uh})
end function

public procedure rlUnloadShaderBuffer(atom id)
	c_proc(xrlUnloadShaderBuffer,{id})
end procedure

public procedure rlUpdateShaderBuffer(atom id,atom dat,atom size,atom of)
	c_proc(xrlUpdateShaderBuffer,{id,dat,size,of})
end procedure

public procedure rlBindShaderBuffer(atom id,atom idx)
	c_proc(xrlBindShaderBuffer,{id,idx})
end procedure

public procedure rlReadShaderBuffer(atom id,atom dst,atom cnt,atom of)
	c_proc(xrlReadShaderBuffer,{id,dst,cnt,of})
end procedure

public procedure rlCopyShaderBuffer(atom id,atom srcid,atom dstoff,atom srcoff,atom cnt)
	c_proc(xrlCopyShaderBuffer,{id,srcid,dstoff,srcoff,cnt})
end procedure

public function rlGetShaderBufferSize(atom id)
	return c_func(xrlGetShaderBufferSize,{id})
end function

export constant xrlBindImageTexture = define_c_proc(ray,"+rlBindImageTexture",{C_UINT,C_UINT,C_INT,C_BOOL})

public procedure rlBindImageTexture(atom id,atom index,atom mat,atom ro)
	c_proc(xrlBindImageTexture,{id,index,mat,ro})
end procedure

export constant xrlGetMatrixModelview = define_c_func(ray,"+rlGetMatrixModelview",{},Matrix),
				xrlGetMatrixProjection = define_c_func(ray,"+rlGetMatrixProjection",{},Matrix),
				xrlGetMatrixTransform = define_c_func(ray,"+rlGetMatrixTransform",{},Matrix),
				xrlGetMatrixProjectionStereo = define_c_func(ray,"+rlGetMatrixProjectionStereo",{C_INT},Matrix),
				xrlGetMatrixViewOffsetStereo = define_c_func(ray,"+rlGetMatrixViewOffsetStereo",{C_INT},Matrix),
				xrlSetMatrixProjection = define_c_proc(ray,"+rlSetMatrixProjection",{Matrix}),
				xrlSetMatrixModelview = define_c_proc(ray,"+rlSetMatrixModelview",{Matrix}),
				xrlSetMatrixProjectionStereo = define_c_proc(ray,"+rlSetMatrixProjectionStereo",{Matrix,Matrix}),
				xrlSetMatrixViewOffsetStereo = define_c_proc(ray,"+rlSetMatrixViewOffsetStereo",{Matrix,Matrix})
				
public function rlGetMatrixModelview()
	return c_func(xrlGetMatrixModelview,{})
end function

public function rlGetMatrixProjection()
	return c_func(xrlGetMatrixProjection,{})
end function

public function rlGetMatrixTransform()
	return c_func(xrlGetMatrixTransform,{})
end function

public function rlGetMatrixProjectionStereo(atom eye)
	return c_func(xrlGetMatrixProjectionStereo,{eye})
end function

public function rlGetMatrixViewOffsetStereo(atom eye)
	return c_func(xrlGetMatrixViewOffsetStereo,{eye})
end function

public procedure rlSetMatrixProjection(sequence prj)
	c_proc(xrlSetMatrixProjection,{prj})
end procedure

public procedure rlSetMatrixModelview(sequence view)
	c_proc(xrlSetMatrixModelview,{view})
end procedure

public procedure rlSetMatrixProjectionStereo(sequence r,sequence l)
	c_proc(xrlSetMatrixProjectionStereo,{r,l})
end procedure

public procedure rlSetMatrixViewOffsetStereo(sequence r,sequence l)
	c_proc(xrlSetMatrixViewOffsetStereo,{r,l})
end procedure

export constant xrlLoadDrawCube = define_c_proc(ray,"+rlLoadDrawCube",{}),
				xrlLoadDrawQuad = define_c_proc(ray,"+rlLoadDrawQuad",{})
				
public procedure rlLoadDrawCube()
	c_proc(xrlLoadDrawCube,{})
end procedure

public procedure rlLoadDrawQuad()
	c_proc(xrlLoadDrawQuad,{})
end procedure
­288.19
