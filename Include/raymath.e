include std/ffi.e

include raylib.e

public constant PI = 3.14159265358979323846
public constant EPSILON = 0.000001
public constant DEG2RAD = PI / 180.0
public constant RAD2DEG = 180.0 / PI

export constant xClamp = define_c_func(ray,"+Clamp",{C_FLOAT,C_FLOAT,C_FLOAT},C_FLOAT)

public function Clamp(atom val,atom min,atom max)
	return c_func(xClamp,{val,min,max})
end function

export constant xLerp = define_c_func(ray,"+Lerp",{C_FLOAT,C_FLOAT,C_FLOAT},C_FLOAT)

public function Lerp(atom start,atom xend,atom amount)
	return c_func(xLerp,{start,xend,amount})
end function

export constant xNormalize = define_c_func(ray,"+Normalize",{C_FLOAT,C_FLOAT,C_FLOAT},C_FLOAT)

public function Normalize(atom val,atom start,atom xend)
	return c_func(xNormalize,{val,start,xend})
end function

export constant xRemap = define_c_func(ray,"+Remap",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT},C_FLOAT)

public function Remap(atom val,atom iS,atom iE,atom oS,atom oE)
	return c_func(xRemap,{val,iS,iE,oS,oE})
end function

export constant xWrap = define_c_func(ray,"+Wrap",{C_FLOAT,C_FLOAT,C_FLOAT},C_FLOAT)

public function Wrap(atom val,atom min,atom max)
	return c_func(xWrap,{val,min,max})
end function

export constant xFloatEquals = define_c_func(ray,"+FloatEquals",{C_FLOAT,C_FLOAT},C_INT)

public function FloatEquals(atom x,atom y)
	return c_func(xFloatEquals,{x,y})
end function

export constant xVector2Zero = define_c_func(ray,"+Vector2Zero",{},Vector2)

public function Vector2Zero()
	return c_func(xVector2Zero,{})
end function

export constant xVector2One = define_c_func(ray,"+Vector2One",{},Vector2)

public function Vector2One()
	return c_func(xVector2One,{})
end function

export constant xVector2Add = define_c_func(ray,"+Vector2Add",{Vector2,Vector2},Vector2)

public function Vector2Add(sequence v1,sequence v2)
	return c_func(xVector2Add,{v1,v2})
end function

export constant xVector2AddValue = define_c_func(ray,"+Vector2AddValue",{Vector2,C_FLOAT},Vector2)

public function Vector2AddValue(sequence v,atom add)
	return c_func(xVector2AddValue,{v,add})
end function

export constant xVector2Subtract = define_c_func(ray,"+Vector2Subtract",{Vector2,Vector2},Vector2)

public function Vector2Subtract(sequence v,sequence v2)
	return c_func(xVector2Subtract,{v,v2})
end function

export constant xVector2SubtractValue = define_c_func(ray,"+Vector2SubtractValue",{Vector2,C_FLOAT},Vector2)

public function Vector2SubtractValue(sequence v,atom sub)
	return c_func(xVector2SubtractValue,{v,sub})
end function

export constant xVector2Length = define_c_func(ray,"+Vector2Length",{Vector2},C_FLOAT)

public function Vector2Length(sequence v)
	return c_func(xVector2Length,{v})
end function

export constant xVector2LengthSqr = define_c_func(ray,"+Vector2LengthSqr",{Vector2},C_FLOAT)

public function Vector2LengthSqr(sequence v)
	return c_func(xVector2LengthSqr,{v})
end function

export constant xVector2DotProduct = define_c_func(ray,"+Vector2DotProduct",{Vector2,Vector2},C_FLOAT)

public function Vector2DotProduct(sequence v,sequence v2)
	return c_func(xVector2DotProduct,{v,v2})
end function

export constant xVector2Distance = define_c_func(ray,"+Vector2Distance",{Vector2,Vector2},C_FLOAT)

public function Vector2Distance(sequence v,sequence v2)
	return c_func(xVector2Distance,{v,v2})
end function

export constant xVector2DistanceSqr = define_c_func(ray,"+Vector2DistanceSqr",{Vector2,Vector2},C_FLOAT)

public function Vector2DistanceSqr(sequence v,sequence v2)
	return c_func(xVector2DistanceSqr,{v,v2})
end function

export constant xVector2Angle = define_c_func(ray,"+Vector2Angle",{Vector2,Vector2},C_FLOAT)

public function Vector2Angle(sequence v,sequence v2)
	return c_func(xVector2Angle,{v,v2})
end function

export constant xVector2LineAngle = define_c_func(ray,"+Vector2LineAngle",{Vector2,Vector2},C_FLOAT)

public function Vector2LineAngle(sequence v,sequence v2)
	return c_func(xVector2LineAngle,{v,v2})
end function

export constant xVector2Scale = define_c_func(ray,"+Vector2Scale",{Vector2,C_FLOAT},Vector2)

public function Vector2Scale(sequence v,atom scale)
	return c_func(xVector2Scale,{v,scale})
end function

export constant xVector2Multiply = define_c_func(ray,"+Vector2Multiply",{Vector2,Vector2},Vector2)

public function Vector2Multiply(sequence v,sequence v2)
	return c_func(xVector2Multiply,{v,v2})
end function

export constant xVector2Negate = define_c_func(ray,"+Vector2Negate",{Vector2},Vector2)

public function Vector2Negate(sequence v)
	return c_func(xVector2Negate,{v})
end function

export constant xVector2Divide = define_c_func(ray,"+Vector2Divide",{Vector2,Vector2},Vector2)

public function Vector2Divide(sequence v,sequence v2)
	return c_func(xVector2Divide,{v,v2})
end function

export constant xVector2Normalize = define_c_func(ray,"+Vector2Normalize",{Vector2},Vector2)

public function Vector2Normalize(sequence v)
	return c_func(xVector2Normalize,{v})
end function

export constant xVector2Transform = define_c_func(ray,"+Vector2Transform",{Vector2,Matrix},Vector2)

public function Vector2Transform(sequence v,sequence mat)
	return c_func(xVector2Transform,{v,mat})
end function

export constant xVector2Lerp = define_c_func(ray,"+Vector2Lerp",{Vector2,Vector2,C_FLOAT},Vector2)

public function Vector2Lerp(sequence v,sequence v2,atom amt)
	return c_func(xVector2Lerp,{v,v2,amt})
end function

export constant xVector2Reflect = define_c_func(ray,"+Vector2Reflect",{Vector2,Vector2},Vector2)

public function Vector2Reflect(sequence v,sequence norm)
	return c_func(xVector2Reflect,{v,norm})
end function

export constant xVector2Rotate = define_c_func(ray,"+Vector2Rotate",{Vector2,C_FLOAT},Vector2)

public function Vector2Rotate(sequence v,atom ang)
	return c_func(xVector2Rotate,{v,ang})
end function

export constant xVector2MoveTowards = define_c_func(ray,"+Vector2MoveTowards",{Vector2,Vector2,C_FLOAT},Vector2)

public function Vector2MoveTowards(sequence v,sequence tar,atom max)
	return c_func(xVector2MoveTowards,{v,tar,max})
end function

export constant xVector2Invert = define_c_func(ray,"+Vector2Invert",{Vector2},Vector2)

public function Vector2Invert(sequence v)
	return c_func(xVector2Invert,{v})
end function

export constant xVector2Clamp = define_c_func(ray,"+Vector2Clamp",{Vector2,Vector2,Vector2},Vector2)

public function Vector2Clamp(sequence v,sequence min,sequence max)
	return c_func(xVector2Clamp,{v,min,max})
end function

export constant xVector2ClampValue = define_c_func(ray,"+Vector2ClampValue",{Vector2,C_FLOAT,C_FLOAT},Vector2)

public function Vector2ClampValue(sequence v,atom min,atom max)
	return c_func(xVector2ClampValue,{v,min,max})
end function

export constant xVector2Equals = define_c_func(ray,"+Vector2Equals",{Vector2,Vector2},C_INT)

public function Vector2Equals(sequence p,sequence q)
	return c_func(xVector2Equals,{p,q})
end function

export constant xVector3Zero = define_c_func(ray,"+Vector3Zero",{},Vector3)

public function Vector3Zero()
	return c_func(xVector3Zero,{})
end function

export constant xVector3One = define_c_func(ray,"+Vector3One",{},Vector3)

public function Vector3One()
	return c_func(xVector3One,{})
end function

export constant xVector3Add = define_c_func(ray,"+Vector3Add",{Vector3,Vector3},Vector3)

public function Vector3Add(sequence v,sequence v2)
	return c_func(xVector3Add,{v,v2})
end function

export constant xVector3AddValue = define_c_func(ray,"+Vector3AddValue",{Vector3,C_FLOAT},Vector3)

public function Vector3AddValue(sequence v,atom add)
	return c_func(xVector3AddValue,{v,add})
end function

export constant xVector3Subtract = define_c_func(ray,"+Vector3Subtract",{Vector3,Vector3},Vector3)

public function Vector3Subtract(sequence v,sequence v2)
	return c_func(xVector3Subtract,{v,v2})
end function

export constant xVector3SubtractValue = define_c_func(ray,"+Vector3SubtractValue",{Vector3,C_FLOAT},Vector3)

public function Vector3SubtractValue(sequence v,atom sub)
	return c_func(xVector3SubtractValue,{v,sub})
end function

export constant xVector3Scale = define_c_func(ray,"+Vector3Scale",{Vector3,C_FLOAT},Vector3)

public function Vector3Scale(sequence v,atom scalar)
	return c_func(xVector3Scale,{v,scalar})
end function

export constant xVector3Multiply = define_c_func(ray,"+Vector3Multiply",{Vector3,Vector3},Vector3)

public function Vector3Multiply(sequence v,sequence v2)
	return c_func(xVector3Multiply,{v,v2})
end function

export constant xVector3CrossProduct = define_c_func(ray,"+Vector3CrossProduct",{Vector3,Vector3},Vector3)

public function Vector3CrossProduct(sequence v,sequence v2)
	return c_func(xVector3CrossProduct,{v,v2})
end function

export constant xVector3Perpendicular = define_c_func(ray,"+Vector3Perpendicular",{Vector3},Vector3)

public function Vector3Perpendicular(sequence v)
	return c_func(xVector3Perpendicular,{v})
end function

export constant xVector3Length = define_c_func(ray,"+Vector3Length",{Vector3},C_FLOAT)

public function Vector3Length(sequence v)
	return c_func(xVector3Length,{v})
end function

export constant xVector3LengthSqr = define_c_func(ray,"+Vector3LengthSqr",{Vector3},C_FLOAT)

public function Vector3LengthSqr(sequence v)
	return c_func(xVector3LengthSqr,{v})
end function

export constant xVector3DotProduct = define_c_func(ray,"+Vector3DotProduct",{Vector3,Vector3},C_FLOAT)

public function Vector3DotProduct(sequence v,sequence v2)
	return c_func(xVector3DotProduct,{v,v2})
end function

export constant xVector3Distance = define_c_func(ray,"+Vector3Distance",{Vector3,Vector3},C_FLOAT)

public function Vector3Distance(sequence v,sequence v2)
	return c_func(xVector3Distance,{v,v2})
end function

export constant xVector3DistanceSqr = define_c_func(ray,"+Vector3DistanceSqr",{Vector3,Vector3},C_FLOAT)

public function Vector3DistanceSqr(sequence v,sequence v2)
	return c_func(xVector3DistanceSqr,{v,v2})
end function

export constant xVector3Angle = define_c_func(ray,"+Vector3Angle",{Vector3,Vector3},C_FLOAT)

public function Vector3Angle(sequence v,sequence v2)
	return c_func(xVector3Angle,{v,v2})
end function

export constant xVector3Negate = define_c_func(ray,"+Vector3Negate",{Vector3},Vector3)

public function Vector3Negate(sequence v)
	return c_func(xVector3Negate,{v})
end function

export constant xVector3Divide = define_c_func(ray,"+Vector3Divide",{Vector3,Vector3},Vector3)

public function Vector3Divide(sequence v,sequence v2)
	return c_func(xVector3Divide,{v,v2})
end function

export constant xVector3Normalize = define_c_func(ray,"+Vector3Normalize",{Vector3},Vector3)

public function Vector3Normalize(sequence v)
	return c_func(xVector3Normalize,{v})
end function

export constant xVector3OrthoNormalize = define_c_proc(ray,"+Vector3OrthoNormalize",{C_POINTER,C_POINTER})

public procedure Vector3OrthoNormalize(atom v,atom v2)
	c_proc(xVector3OrthoNormalize,{v,v2})
end procedure

export constant xVector3Transform = define_c_func(ray,"+Vector3Transform",{Vector3,Matrix},Vector3)

public function Vector3Transform(sequence v,sequence mat)
	return c_func(xVector3Transform,{v,mat})
end function

export constant xVector3RotateByQuaternion = define_c_func(ray,"+Vector3RotateByQuaternion",{Vector3,Quaternion},Vector3)

public function Vector3RotateByQuaternion(sequence v,sequence q)
	return c_func(xVector3RotateByQuaternion,{v,q})
end function

export constant xVector3RotateByAxisAngle = define_c_func(ray,"+Vector3RotateByAxisAngle",{Vector3,Vector3,C_FLOAT},Vector3)

public function Vector3RotateByAxisAngle(sequence v,sequence ax,atom ang)
	return c_func(xVector3RotateByAxisAngle,{v,ax,ang})
end function

export constant xVector3Lerp = define_c_func(ray,"+Vector3Lerp",{Vector3,Vector3,C_FLOAT},Vector3)

public function Vector3Lerp(sequence v,sequence v2,atom amt)
	return c_func(xVector3Lerp,{v,v2,amt})
end function

export constant xVector3Reflect = define_c_func(ray,"+Vector3Reflect",{Vector3,Vector3},Vector3)

public function Vector3Reflect(sequence v,sequence norm)
	return c_func(xVector3Reflect,{v,norm})
end function

export constant xVector3Min = define_c_func(ray,"+Vector3Min",{Vector3,Vector3},Vector3)

public function Vector3Min(sequence v,sequence v2)
	return c_func(xVector3Min,{v,v2})
end function

export constant xVector3Max = define_c_func(ray,"+Vector3Max",{Vector3,Vector3},Vector3)

public function Vector3Max(sequence v,sequence v2)
	return c_func(xVector3Max,{v,v2})
end function

export constant xVector3Barycenter = define_c_func(ray,"+Vector3Barycenter",{Vector3,Vector3,Vector3,Vector3},Vector3)

public function Vector3Barycenter(sequence p,sequence a,sequence b,sequence c)
	return c_func(xVector3Barycenter,{p,a,b,c})
end function

export constant xVector3Unproject = define_c_func(ray,"+Vector3Unproject",{Vector3,Matrix,Matrix},Vector3)

public function Vector3Unproject(sequence src,sequence prj,sequence vi)
	return c_func(xVector3Unproject,{src,prj,vi})
end function

export constant xVector3ToFloatV = define_c_func(ray,"+Vector3ToFloatV",{Vector3},Vector3)

public function Vector3ToFloatV(sequence v)
	return c_func(xVector3ToFloatV,{v})
end function

export constant xVector3Invert = define_c_func(ray,"+Vector3Invert",{Vector3},Vector3)

public function Vector3Invert(sequence v)
	return c_func(xVector3Invert,{v})
end function

export constant xVector3Clamp = define_c_func(ray,"+Vector3Clamp",{Vector3,Vector3,Vector3},Vector3)

public function Vector3Clamp(sequence v,sequence min,sequence max)
	return c_func(xVector3Clamp,{v,min,max})
end function

export constant xVector3ClampValue = define_c_func(ray,"+Vector3ClampValue",{Vector3,C_FLOAT,C_FLOAT},Vector3)

public function Vector3ClampValue(sequence v,atom min,atom max)
	return c_func(xVector3ClampValue,{v,min,max})
end function

export constant xVector3Equals = define_c_func(ray,"+Vector3Equals",{Vector3,Vector3},C_INT)

public function Vector3Equals(sequence p,sequence q)
	return c_func(xVector3Equals,{p,q})
end function

export constant xVector3Refract = define_c_func(ray,"+Vector3Refract",{Vector3,Vector3,C_FLOAT},Vector3)

public function Vector3Refract(sequence v,sequence n,atom r)
	return c_func(xVector3Refract,{v,n,r})
end function

export constant xMatrixDeterminant = define_c_func(ray,"+MatrixDeterminant",{Matrix},C_FLOAT)

public function MatrixDeterminant(sequence m)
	return c_func(xMatrixDeterminant,{m})
end function

export constant xMatrixTrace = define_c_func(ray,"+MatrixTrace",{Matrix},C_FLOAT)

public function MatrixTrace(sequence m)
	return c_func(xMatrixTrace,{m})
end function

export constant xMatrixTranspose = define_c_func(ray,"+MatrixTranspose",{Matrix},Matrix)

public function MatrixTranspose(sequence m)
	return c_func(xMatrixTranspose,{m})
end function

export constant xMatrixInvert = define_c_func(ray,"+MatrixInvert",{Matrix},Matrix)

public function MatrixInvert(sequence m)
	return c_func(xMatrixInvert,{m})
end function

export constant xMatrixIdentity = define_c_func(ray,"+MatrixIdentity",{},Matrix)

public function MatrixIdentity()
	return c_func(xMatrixIdentity,{})
end function

export constant xMatrixAdd = define_c_func(ray,"+MatrixAdd",{Matrix,Matrix},Matrix)

public function MatrixAdd(sequence l,sequence r)
	return c_func(xMatrixAdd,{l,r})
end function

export constant xMatrixSubtract = define_c_func(ray,"+MatrixSubtract",{Matrix,Matrix},Matrix)

public function MatrixSubtract(sequence l,sequence r)
	return c_func(xMatrixSubtract,{l,r})
end function

export constant xMatrixMultiply = define_c_func(ray,"+MatrixMultiply",{Matrix,Matrix},Matrix)

public function MatrixMultiply(sequence l,sequence r)
	return c_func(xMatrixAdd,{l,r})
end function

export constant xMatrixTranslate = define_c_func(ray,"+MatrixTranslate",{C_FLOAT,C_FLOAT,C_FLOAT},Matrix)

public function MatrixTranslate(atom x,atom y,atom z)
	return c_func(xMatrixTranslate,{x,y,z})
end function

export constant xMatrixRotate = define_c_func(ray,"+MatrixRotate",{Vector3,C_FLOAT},Matrix)

public function MatrixRotate(sequence ax,atom ang)
	return c_func(xMatrixRotate,{ax,ang})
end function

export constant xMatrixRotateX = define_c_func(ray,"+MatrixRotateX",{C_FLOAT},Matrix)

public function MatrixRotateX(atom ang)
	return c_func(xMatrixRotateX,{ang})
end function

export constant xMatrixRotateY = define_c_func(ray,"+MatrixRotateY",{C_FLOAT},Matrix)

public function MatrixRotateY(atom ang)
	return c_func(xMatrixRotateY,{ang})
end function

export constant xMatrixRotateZ = define_c_func(ray,"+MatrixRotateZ",{C_FLOAT},Matrix)

public function MatrixRotateZ(atom ang)
	return c_func(xMatrixRotateZ,{ang})
end function

export constant xMatrixRotateXYZ = define_c_func(ray,"+MatrixRotateXYZ",{Vector3},Matrix)

public function MatrixRotateXYZ(sequence ang)
	return c_func(xMatrixRotateXYZ,{ang})
end function

export constant xMatrixRotateZYX = define_c_func(ray,"+MatrixRotateZYX",{Vector3},Matrix)

public function MatrixRotateZYX(sequence ang)
	return c_func(xMatrixRotateZYX,{ang})
end function

export constant xMatrixScale = define_c_func(ray,"+MatrixScale",{C_FLOAT,C_FLOAT,C_FLOAT},Matrix)

public function MatrixScale(atom x,atom y,atom z)
	return c_func(xMatrixScale,{x,y,z})
end function

export constant xMatrixFrustum = define_c_func(ray,"+MatrixFrustum",{C_DOUBLE,C_DOUBLE,C_DOUBLE,C_DOUBLE,C_DOUBLE,C_DOUBLE},Matrix)

public function MatrixFrustum(atom left,atom right,atom bottom,atom top,atom near,atom far)
	return c_func(xMatrixFrustum,{left,right,bottom,top,near,far})
end function

export constant xMatrixPerspective = define_c_func(ray,"+MatrixPerspective",{C_DOUBLE,C_DOUBLE,C_DOUBLE,C_DOUBLE},Matrix)

public function MatrixPerspective(atom fovy,atom as,atom n,atom f)
	return c_func(xMatrixPerspective,{fovy,as,n,f})
end function

export constant xMatrixOrtho = define_c_func(ray,"+MatrixOrtho",{C_DOUBLE,C_DOUBLE,C_DOUBLE,C_DOUBLE,C_DOUBLE,C_DOUBLE},Matrix)

public function MatrixOrtho(atom left,atom right,atom bottom,atom top,atom near,atom far)
	return c_func(xMatrixOrtho,{left,right,bottom,top,near,far})
end function

export constant xMatrixLookAt = define_c_func(ray,"+MatrixLookAt",{Vector3,Vector3,Vector3},Matrix)

public function MatrixLookAt(sequence eye,sequence tar,sequence up)
	return c_func(xMatrixLookAt,{eye,tar,up})
end function

export constant xMatrixToFloatV = define_c_func(ray,"+MatrixToFloatV",{Matrix},C_FLOAT)

public function MatrixToFloatV(sequence m)
	return c_func(xMatrixToFloatV,{m})
end function

export constant xQuaternionAdd = define_c_func(ray,"+QuaternionAdd",{Quaternion,Quaternion},Quaternion)

public function QuaternionAdd(sequence q,sequence q2)
	return c_func(xQuaternionAdd,{q,q2})
end function

export constant xQuaternionAddValue = define_c_func(ray,"+QuaternionAddValue",{Quaternion,C_FLOAT},Quaternion)

public function QuaternionAddValue(sequence q,atom add)
	return c_func(xQuaternionAddValue,{q,add})
end function

export constant xQuaternionSubtract = define_c_func(ray,"+QuaternionSubtract",{Quaternion,Quaternion},Quaternion)

public function QuaternionSubtract(sequence q,sequence q2)
	return c_func(xQuaternionSubtract,{q,q2})
end function

export constant xQuaternionSubtractValue = define_c_func(ray,"+QuaternionSubtractValue",{Quaternion,C_FLOAT},Quaternion)

public function QuaternionSubtractValue(sequence q,atom sub)
	return c_func(xQuaternionSubtractValue,{q,sub})
end function

export constant xQuaternionIdentity = define_c_func(ray,"+QuaternionIdentity",{},Quaternion)

public function QuaternionIdentity()
	return c_func(xQuaternionIdentity,{})
end function

export constant xQuaternionLength = define_c_func(ray,"+QuaternionLength",{Quaternion},C_FLOAT)

public function QuaternionLength(sequence q)
	return c_func(xQuaternionLength,{q})
end function

export constant xQuaternionNormalize = define_c_func(ray,"+QuaternionNormalize",{Quaternion},Quaternion)

public function QuaternionNormalize(sequence q)
	return c_func(xQuaternionNormalize,{q})
end function

export constant xQuaternionInvert = define_c_func(ray,"+QuaternionInvert",{Quaternion},Quaternion)

public function QuaternionInvert(sequence q)
	return c_func(xQuaternionInvert,{q})
end function

export constant xQuaternionMultiply = define_c_func(ray,"+QuaternionMultiply",{Quaternion,Quaternion},Quaternion)

public function QuaternionMultiply(sequence q,sequence q2)
	return c_func(xQuaternionMultiply,{q,q2})
end function

export constant xQuaternionScale = define_c_func(ray,"+QuaternionScale",{Quaternion,C_FLOAT},Quaternion)

public function QuaternionScale(sequence q,atom m)
	return c_func(xQuaternionScale,{q,m})
end function

export constant xQuaternionDivide = define_c_func(ray,"+QuaternionDivide",{Quaternion,Quaternion},Quaternion)

public function QuaternionDivide(sequence q,sequence q2)
	return c_func(xQuaternionDivide,{q,q2})
end function

export constant xQuaternionLerp = define_c_func(ray,"+QuaternionLerp",{Quaternion,Quaternion,C_FLOAT},Quaternion)

public function QuaternionLerp(sequence q,sequence q2,atom amt)
	return c_func(xQuaternionLerp,{q,q2,amt})
end function

export constant xQuaternionNlerp = define_c_func(ray,"+QuaternionNlerp",{Quaternion,Quaternion,C_FLOAT},Quaternion)

public function QuaternionNlerp(sequence q,sequence q2,atom amt)
	return c_func(xQuaternionNlerp,{q,q2,amt})
end function

export constant xQuaternionSlerp = define_c_func(ray,"+QuaternionSlerp",{Quaternion,Quaternion,C_FLOAT},Quaternion)

public function QuaternionSlerp(sequence q,sequence q2,atom amt)
	return c_func(xQuaternionSlerp,{q,q2,amt})
end function

export constant xQuaternionFromVector3ToVector3 = define_c_func(ray,"+QuaternionFromVector3ToVector3",{Vector3,Vector3},Quaternion)

public function QuaternionFromVector3ToVector3(sequence f,sequence t)
	return c_func(xQuaternionFromVector3ToVector3,{f,t})
end function

export constant xQuaternionFromMatrix = define_c_func(ray,"+QuaternionFromMatrix",{Matrix},Quaternion)

public function QuaternionFromMatrix(sequence m)
	return c_func(xQuaternionFromMatrix,{m})
end function

export constant xQuaternionToMatrix = define_c_func(ray,"+QuaternionToMatrix",{Quaternion},Matrix)

public function QuaternionToMatrix(sequence q)
	return c_func(xQuaternionToMatrix,{q})
end function

export constant xQuaternionFromAxisAngle = define_c_func(ray,"+QuaternionFromAxisAngle",{Vector3,C_FLOAT},Quaternion)

public function QuaternionFromAxisAngle(sequence ax,atom ang)
	return c_func(xQuaternionFromAxisAngle,{ax,ang})
end function

export constant xQuaternionToAxisAngle = define_c_proc(ray,"+QuaternionToAxisAngle",{Quaternion,C_POINTER,C_POINTER})

public procedure QuaternionToAxisAngle(sequence q,atom out,atom oa)
	c_proc(xQuaternionToAxisAngle,{q,out,oa})
end procedure

export constant xQuaternionFromEuler = define_c_func(ray,"+QuaternionFromEuler",{C_FLOAT,C_FLOAT,C_FLOAT},Quaternion)

public function QuaternionFromEuler(atom pit,atom yaw,atom roll)
	return c_func(xQuaternionFromEuler,{pit,yaw,roll})
end function

export constant xQuaternionToEuler = define_c_func(ray,"+QuaternionToEuler",{Quaternion},Vector3)

public function QuaternionToEuler(sequence q)
	return c_func(xQuaternionToEuler,{q})
end function

export constant xQuaternionTransform = define_c_func(ray,"+QuaternionTransform",{Quaternion,Matrix},Quaternion)

public function QuaternionTransform(sequence q,sequence m)
	return c_func(xQuaternionTransform,{q,m})
end function

export constant xQuaternionEquals = define_c_func(ray,"+QuaternionEquals",{Quaternion,Quaternion},C_INT)

public function QuaternionEquals(sequence p,sequence q)
	return c_func(xQuaternionEquals,{p,q})
end function
­679.39
