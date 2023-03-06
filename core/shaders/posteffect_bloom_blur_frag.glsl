////////////////////////////////////////////////////////
// PostEffect Bloom Blur - Fragment Shader
//
// Blur effect for the bloom post effect
////////////////////////////////////////////////////////

#version 120
#extension GL_ARB_texture_rectangle : enable

uniform sampler2DRect diffuseMap;
@define sampler_diffuseMap 0

// Initialize these down in MAIN due to Mac OS X OpenGL Driver
@ifdef FeatureNotSupported_ConstArray
	float vMul[7];
	float fOffset[7];
@else
	const float vMul[7] = float[7](0.1, 0.25, 0.3, 0.5, 0.3, 0.25, 0.1);
	const float fOffset[7] = float[7](-4.35, -2.5, -0.75, 0.0, 0.75, 2.5, 4.35);
@endif

void main()
{
	@ifdef FeatureNotSupported_ConstArray
		vMul[0] = 0.1;	vMul[1] = 0.25;	vMul[2] = 0.3;	vMul[3] = 0.5;	vMul[4] = 0.3;	vMul[5] = 0.25;	vMul[6] = 0.1;
		fOffset[0] = -4.35; fOffset[1] = -2.5; 	fOffset[2] = -0.75; fOffset[3] = 0.0; fOffset[4] = 0.75; fOffset[5] = 2.5; fOffset[6] = 4.35;
	@endif

	vec3 vAmount =vec3(0.0);
	float fMulSum =0;
	for(int i=0; i<7; i+=1)
	{	
		float fCoordOffset = fOffset[i] * 1.5;
		@ifdef BlurHorisontal
			vec2 vOffset = vec2(fCoordOffset * 1.5, fCoordOffset / 3.0);
		@else
			vec2 vOffset = vec2(fCoordOffset / 3.0, fCoordOffset * 1.5);
		@endif
		
		float fMul = vMul[i];
		
		vec3 vColor = texture2DRect(diffuseMap, gl_TexCoord[0].xy + vOffset).xyz;
		
		vAmount += vColor * fMul;
		fMulSum += fMul;
	}

	vAmount /= fMulSum;

	vec3(1,1,1); 
	gl_FragColor.xyz = vAmount;
	gl_FragColor.w = 8.0;
}