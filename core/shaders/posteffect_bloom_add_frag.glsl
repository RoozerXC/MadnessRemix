////////////////////////////////////////////////////////
// PostEffect Bloom Blur - Fragment Shader
//
// Blur effect for the bloom post effect
////////////////////////////////////////////////////////
#version 120

#extension GL_ARB_texture_rectangle : enable

uniform sampler2DRect blurMap;
@define sampler_blurMap 0

uniform sampler2DRect diffuseMap;
@define sampler_diffuseMap 1

uniform vec3 avRgbToIntensity;

void main()
{
	vec4 vBlurColor = 	texture2DRect(blurMap, 	  gl_TexCoord[0].xy);
	vec4 vDiffuseColor = 	texture2DRect(diffuseMap, gl_TexCoord[1].xy);
	
	//vBlurColor *= vBlurColor * dot(vBlurColor.xyz, avRgbToIntensity);
	//vBlurColor = clamp(vBlurColor, 0.0, 0.25);
	
	gl_FragColor = vDiffuseColor - (vDiffuseColor * vBlurColor) + (vBlurColor * vBlurColor) * 1.75;
	//gl_FragColor = vBlurColor;
}