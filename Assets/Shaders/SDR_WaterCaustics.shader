// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/Water"
{
	Properties
	{
		_WaterNormal("Water Normal", 2D) = "bump" {}
		_NormalScale("Normal Scale", Float) = 0
		_DeepColor("Deep Color", Color) = (0,0.03609375,0.21,0)
		_EdgeColor("Edge Color", Color) = (0,0.8078432,0.8078432,1)
		_ColorMask("ColorMask", 2D) = "white" {}
		_Foam("Foam", 2D) = "white" {}
		_Caustic("Caustic", 2D) = "black" {}
		_CausticIntensity("Caustic Intensity", Range( 0 , 2)) = 0.5
		_ColorEmission("Color Emission", Range( 0 , 1)) = 0
		_WaterSpecular("Water Specular", Range( 0 , 1)) = 0
		_WaterSmoothness("Water Smoothness", Range( 0 , 1)) = 0
		_FoamIntesity("Foam Intesity", Range( 0 , 3)) = 1
		_Speed("Speed", Range( 0 , 3)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		ZTest LEqual
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma exclude_renderers xbox360 xboxone ps4 psp2 n3ds wiiu 
		#pragma surface surf StandardSpecular keepalpha nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			half2 uv_texcoord;
		};

		uniform sampler2D _WaterNormal;
		uniform half _NormalScale;
		uniform half _Speed;
		uniform float4 _WaterNormal_ST;
		uniform half4 _DeepColor;
		uniform half4 _EdgeColor;
		uniform sampler2D _ColorMask;
		uniform float4 _ColorMask_ST;
		uniform sampler2D _Foam;
		uniform float4 _Foam_ST;
		uniform half _FoamIntesity;
		uniform half _ColorEmission;
		uniform sampler2D _Caustic;
		uniform float4 _Caustic_ST;
		uniform half _CausticIntensity;
		uniform half _WaterSpecular;
		uniform half _WaterSmoothness;

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float mulTime242 = _Time.y * ( 1.0 * _Speed );
			float2 uv_WaterNormal = i.uv_texcoord * _WaterNormal_ST.xy + _WaterNormal_ST.zw;
			float2 panner22 = ( mulTime242 * float2( -0.03,0 ) + uv_WaterNormal);
			float mulTime245 = _Time.y * ( 1.3 * _Speed );
			float2 panner233 = ( mulTime245 * float2( 0.04,-0.01 ) + ( uv_WaterNormal * float2( 0.95,0.95 ) ));
			float3 lerpResult231 = lerp( UnpackScaleNormal( tex2D( _WaterNormal, panner22 ), _NormalScale ) , UnpackScaleNormal( tex2D( _WaterNormal, panner233 ), _NormalScale ) , float3( 0,0,0 ));
			float mulTime246 = _Time.y * ( 1.2 * _Speed );
			float2 panner19 = ( mulTime246 * float2( 0.04,0.04 ) + ( uv_WaterNormal * float2( 1.25,1.25 ) ));
			float mulTime254 = _Time.y * ( 1.2 * _Speed );
			float2 panner257 = ( mulTime254 * float2( -0.06,-0.02 ) + ( uv_WaterNormal * float2( 1.15,1.15 ) ));
			float3 lerpResult256 = lerp( UnpackScaleNormal( tex2D( _WaterNormal, panner19 ), _NormalScale ) , UnpackScaleNormal( tex2D( _WaterNormal, panner257 ), _NormalScale ) , float3( 0,0,0 ));
			o.Normal = BlendNormals( lerpResult231 , lerpResult256 );
			float2 uv_ColorMask = i.uv_texcoord * _ColorMask_ST.xy + _ColorMask_ST.zw;
			float4 lerpResult13 = lerp( _DeepColor , _EdgeColor , tex2D( _ColorMask, uv_ColorMask ));
			float2 uv_Foam = i.uv_texcoord * _Foam_ST.xy + _Foam_ST.zw;
			float2 panner204 = ( mulTime242 * float2( -0.03,0 ) + uv_Foam);
			float2 panner238 = ( mulTime245 * float2( 0.04,-0.01 ) + ( uv_Foam * float2( 0.95,0.95 ) ));
			float4 lerpResult235 = lerp( tex2D( _Foam, panner204 ) , tex2D( _Foam, panner238 ) , float4( 0,0,0,0 ));
			float2 panner206 = ( mulTime246 * float2( 0.04,0.04 ) + ( uv_Foam * float2( 1.25,1.25 ) ));
			float2 panner250 = ( mulTime254 * float2( -0.06,-0.02 ) + ( uv_Foam * float2( 1.15,1.15 ) ));
			float4 lerpResult252 = lerp( tex2D( _Foam, panner206 ) , tex2D( _Foam, panner250 ) , float4( 0,0,0,0 ));
			half4 blendOpSrc198 = lerpResult235;
			half4 blendOpDest198 = lerpResult252;
			float4 temp_output_172_0 = ( lerpResult13 + ( ( saturate( ( blendOpSrc198 * blendOpDest198 ) )) * _FoamIntesity ) );
			o.Albedo = temp_output_172_0.rgb;
			float4 lerpResult209 = lerp( float4( 0,0,0,0 ) , temp_output_172_0 , _ColorEmission);
			float2 uv_Caustic = i.uv_texcoord * _Caustic_ST.xy + _Caustic_ST.zw;
			float2 panner178 = ( mulTime242 * float2( 0.05,0.04 ) + uv_Caustic);
			float mulTime247 = _Time.y * ( 0.98 * _Speed );
			float2 panner225 = ( mulTime247 * float2( -0.045,-0.035 ) + ( uv_Caustic * float2( 1.3,1.3 ) ));
			float4 lerpResult223 = lerp( tex2D( _Caustic, panner178 ) , tex2D( _Caustic, panner225 ) , float4( 0,0,0,0 ));
			float2 panner179 = ( mulTime245 * float2( 0.035,-0.025 ) + ( uv_Caustic * float2( 1.5,1.5 ) ));
			float2 panner229 = ( mulTime246 * float2( -0.03,0.035 ) + ( uv_Caustic * float2( 0.93,0.93 ) ));
			float4 lerpResult227 = lerp( tex2D( _Caustic, panner179 ) , tex2D( _Caustic, panner229 ) , float4( 0,0,0,0 ));
			half4 blendOpSrc173 = lerpResult223;
			half4 blendOpDest173 = lerpResult227;
			float4 lerpResult177 = lerp( float4( 0,0,0,0 ) , ( saturate( ( blendOpSrc173 * blendOpDest173 ) )) , _CausticIntensity);
			o.Emission = ( lerpResult209 + lerpResult177 ).rgb;
			half3 temp_cast_2 = (_WaterSpecular).xxx;
			o.Specular = temp_cast_2;
			o.Smoothness = _WaterSmoothness;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16300
2158;152;2034;1106;3414.504;2292.081;3.803291;True;True
Node;AmplifyShaderEditor.CommentaryNode;159;-821.9468,-1450.362;Float;False;1826.442;1288.054;Depths controls and colors;23;13;212;156;157;213;198;166;200;11;12;235;206;237;201;204;238;222;239;205;249;250;251;252;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;241;-2753.473,1153.413;Float;False;Property;_Speed;Speed;12;0;Create;True;0;0;False;0;1;1;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;244;-2265.464,372.6447;Float;False;2;2;0;FLOAT;1.2;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;240;-2279.072,-94.54243;Float;False;2;2;0;FLOAT;1;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;253;-2250.363,-320.843;Float;False;2;2;0;FLOAT;1.2;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;205;-796.947,-875.9886;Float;False;0;201;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;243;-2279.16,180.9004;Float;False;2;2;0;FLOAT;1.3;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;246;-1960.622,492.1176;Float;False;1;0;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;254;-1948.319,-312.6943;Float;False;1;0;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;222;-486.2289,-595.228;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1.25,1.25;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;251;-504.147,-394.49;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1.15,1.15;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;242;-2064.969,-76.80462;Float;False;1;0;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;153;-1239.823,958.5485;Float;False;1808.422;978.0755;Foam controls and texture;15;228;174;227;173;223;105;179;224;178;225;220;226;180;229;230;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;239;-470.473,-800.1406;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0.95,0.95;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;245;-2035.675,156.5517;Float;False;1;0;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;180;-1339.678,1207.543;Float;False;0;105;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;204;-358.3859,-1029.721;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.03,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;250;-210.4471,-370.89;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.06,-0.02;False;1;FLOAT;1.2;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;248;-2078.652,936.4138;Float;False;2;2;0;FLOAT;0.98;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;238;-264.8295,-776.2448;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.04,-0.01;False;1;FLOAT;1.3;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;206;-231.7371,-584.7191;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.04,0.04;False;1;FLOAT;1.2;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;200;5.596329,-615.0221;Float;True;Property;_Foam2;Foam2;5;0;Create;True;0;0;False;0;5a0d64b525049c74bb0c19c19682e57d;5a0d64b525049c74bb0c19c19682e57d;True;0;False;white;Auto;False;Instance;201;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;201;7.667315,-1020.642;Float;True;Property;_Foam;Foam;5;0;Create;True;0;0;False;0;5a0d64b525049c74bb0c19c19682e57d;5a0d64b525049c74bb0c19c19682e57d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;237;63.79895,-838.1273;Float;True;Property;_TextureSample3;Texture Sample 3;5;0;Create;True;0;0;False;0;5a0d64b525049c74bb0c19c19682e57d;5a0d64b525049c74bb0c19c19682e57d;True;0;False;white;Auto;False;Instance;201;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;249;9.026648,-399.6597;Float;True;Property;_TextureSample4;Texture Sample 4;5;0;Create;True;0;0;False;0;5a0d64b525049c74bb0c19c19682e57d;5a0d64b525049c74bb0c19c19682e57d;True;0;False;white;Auto;False;Instance;201;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;220;-931.4997,1488.442;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1.5,1.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;247;-1736.621,1015.125;Float;False;1;0;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;226;-928.6882,1266.365;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1.3,1.3;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;230;-966.6356,1693.501;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0.93,0.93;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;151;-1313.154,-124.4095;Float;False;1835.091;1034.901;Blend panning normals to fake noving ripples;16;232;233;19;221;48;23;17;231;24;22;21;234;255;256;257;258;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PannerNode;179;-730.0169,1492.886;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.035,-0.025;False;1;FLOAT;1.3;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;12;-530.0743,-1409.096;Float;False;Property;_DeepColor;Deep Color;2;0;Create;True;0;0;False;0;0,0.03609375,0.21,0;0,0.03609375,0.21,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;235;361.799,-1038.127;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PannerNode;229;-814.5994,1738.101;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.03,0.035;False;1;FLOAT;0.8;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;21;-1304.898,19.26457;Float;False;0;17;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;225;-762.688,1270.394;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.045,-0.035;False;1;FLOAT;0.98;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;11;-529.1329,-1241.762;Float;False;Property;_EdgeColor;Edge Color;3;0;Create;True;0;0;False;0;0,0.8078432,0.8078432,1;0,0.8078432,0.8078432,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;252;444.8879,-705.4604;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PannerNode;178;-759.4774,1064.399;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.05,0.04;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;224;-530.418,1231.618;Float;True;Property;_TextureSample0;Texture Sample 0;6;0;Create;True;0;0;False;0;dd5053c9414ca0c4aa227c0cb8915ca3;daa19e387b4a74d469ee70308494db7a;True;0;False;black;Auto;False;Instance;105;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;213;450.8574,-485.1011;Float;False;Property;_FoamIntesity;Foam Intesity;11;0;Create;True;0;0;False;0;1;1;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;258;-933.0933,725.0201;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1.15,1.15;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BlendOpsNode;198;576.0557,-1018.503;Float;True;Multiply;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;157;69.57819,-1284.864;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;221;-1002.828,316.757;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1.25,1.25;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;174;-492.3499,1430.12;Float;True;Property;_Caustic2;Caustic2;6;0;Create;True;0;0;False;0;dd5053c9414ca0c4aa227c0cb8915ca3;dd5053c9414ca0c4aa227c0cb8915ca3;True;0;False;black;Auto;False;Instance;105;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;166;-84.82513,-1240.244;Float;True;Property;_ColorMask;ColorMask;4;0;Create;True;0;0;False;0;d7d3fc845af0e88478cb39def2082396;d611d6f49dd07344aa1277ada0f6bf6c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;105;-559.156,1012.861;Float;True;Property;_Caustic;Caustic;6;0;Create;True;0;0;False;0;dd5053c9414ca0c4aa227c0cb8915ca3;2cf724dede19b71429447ed0c9edc777;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;234;-929.0811,132.8977;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0.95,0.95;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;156;67.67832,-1377.464;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;228;-484.3242,1662.389;Float;True;Property;_TextureSample1;Texture Sample 1;6;0;Create;True;0;0;False;0;dd5053c9414ca0c4aa227c0cb8915ca3;dd5053c9414ca0c4aa227c0cb8915ca3;True;0;False;black;Auto;False;Instance;105;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;13;471.0653,-1333.265;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;223;-91.24854,1037.513;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PannerNode;19;-739.4915,353.4858;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.04,0.04;False;1;FLOAT;1.2;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;233;-758.8858,147.6752;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.04,-0.01;False;1;FLOAT;1.3;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;257;-683.337,747.6485;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.06,-0.02;False;1;FLOAT;1.2;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-1202.624,601.793;Float;False;Property;_NormalScale;Normal Scale;1;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;227;-64.12802,1459.954;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;212;753.0973,-607.8813;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PannerNode;22;-819.4852,-57.4901;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.03,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;232;-500.3166,154.397;Float;True;Property;_TextureSample2;Texture Sample 2;0;0;Create;True;0;0;False;0;None;None;True;0;True;bump;Auto;True;Instance;17;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;173;122.3716,1175.616;Float;True;Multiply;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;255;-419.4602,693.3473;Float;True;Property;_TextureSample5;Texture Sample 5;0;0;Create;True;0;0;False;0;dd2fd2df93418444c8e280f1d34deeb5;dd2fd2df93418444c8e280f1d34deeb5;True;0;True;bump;Auto;True;Instance;17;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;176;804.8307,650.0627;Float;False;Property;_CausticIntensity;Caustic Intensity;7;0;Create;True;0;0;False;0;0.5;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;17;-485.1666,448.4064;Float;True;Property;_WaterNormal;Water Normal;0;0;Create;True;0;0;False;0;dd2fd2df93418444c8e280f1d34deeb5;dd2fd2df93418444c8e280f1d34deeb5;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;210;1010.08,353.7498;Float;False;Property;_ColorEmission;Color Emission;8;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;23;-536.3031,-81.41154;Float;True;Property;_Normal2;Normal2;0;0;Create;True;0;0;False;0;None;None;True;0;True;bump;Auto;True;Instance;17;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;172;1026.133,-665.5529;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;177;846.1271,212.1909;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;256;-123.2901,283.5209;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;209;1200.581,85.34984;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;231;-131.167,23.52409;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BlendNormalsNode;24;98.24879,64.8893;Float;True;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;26;1346.986,631.1322;Float;False;Property;_WaterSmoothness;Water Smoothness;10;0;Create;True;0;0;False;0;0;0.95;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;104;1315.848,403.0625;Float;False;Property;_WaterSpecular;Water Specular;9;0;Create;True;0;0;False;0;0;0.026;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;211;1463.739,104.6012;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1902.298,-14.25123;Half;False;True;2;Half;ASEMaterialInspector;0;0;StandardSpecular;Custom/Water;False;False;False;False;False;False;False;True;True;True;True;True;False;False;False;False;False;False;False;False;Back;2;False;-1;3;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;False;False;False;False;False;False;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;4;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;1;False;-1;1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;244;1;241;0
WireConnection;240;1;241;0
WireConnection;253;1;241;0
WireConnection;243;1;241;0
WireConnection;246;0;244;0
WireConnection;254;0;253;0
WireConnection;222;0;205;0
WireConnection;251;0;205;0
WireConnection;242;0;240;0
WireConnection;239;0;205;0
WireConnection;245;0;243;0
WireConnection;204;0;205;0
WireConnection;204;1;242;0
WireConnection;250;0;251;0
WireConnection;250;1;254;0
WireConnection;248;1;241;0
WireConnection;238;0;239;0
WireConnection;238;1;245;0
WireConnection;206;0;222;0
WireConnection;206;1;246;0
WireConnection;200;1;206;0
WireConnection;201;1;204;0
WireConnection;237;1;238;0
WireConnection;249;1;250;0
WireConnection;220;0;180;0
WireConnection;247;0;248;0
WireConnection;226;0;180;0
WireConnection;230;0;180;0
WireConnection;179;0;220;0
WireConnection;179;1;245;0
WireConnection;235;0;201;0
WireConnection;235;1;237;0
WireConnection;229;0;230;0
WireConnection;229;1;246;0
WireConnection;225;0;226;0
WireConnection;225;1;247;0
WireConnection;252;0;200;0
WireConnection;252;1;249;0
WireConnection;178;0;180;0
WireConnection;178;1;242;0
WireConnection;224;1;225;0
WireConnection;258;0;21;0
WireConnection;198;0;235;0
WireConnection;198;1;252;0
WireConnection;157;0;11;0
WireConnection;221;0;21;0
WireConnection;174;1;179;0
WireConnection;105;1;178;0
WireConnection;234;0;21;0
WireConnection;156;0;12;0
WireConnection;228;1;229;0
WireConnection;13;0;156;0
WireConnection;13;1;157;0
WireConnection;13;2;166;0
WireConnection;223;0;105;0
WireConnection;223;1;224;0
WireConnection;19;0;221;0
WireConnection;19;1;246;0
WireConnection;233;0;234;0
WireConnection;233;1;245;0
WireConnection;257;0;258;0
WireConnection;257;1;254;0
WireConnection;227;0;174;0
WireConnection;227;1;228;0
WireConnection;212;0;198;0
WireConnection;212;1;213;0
WireConnection;22;0;21;0
WireConnection;22;1;242;0
WireConnection;232;1;233;0
WireConnection;232;5;48;0
WireConnection;173;0;223;0
WireConnection;173;1;227;0
WireConnection;255;1;257;0
WireConnection;255;5;48;0
WireConnection;17;1;19;0
WireConnection;17;5;48;0
WireConnection;23;1;22;0
WireConnection;23;5;48;0
WireConnection;172;0;13;0
WireConnection;172;1;212;0
WireConnection;177;1;173;0
WireConnection;177;2;176;0
WireConnection;256;0;17;0
WireConnection;256;1;255;0
WireConnection;209;1;172;0
WireConnection;209;2;210;0
WireConnection;231;0;23;0
WireConnection;231;1;232;0
WireConnection;24;0;231;0
WireConnection;24;1;256;0
WireConnection;211;0;209;0
WireConnection;211;1;177;0
WireConnection;0;0;172;0
WireConnection;0;1;24;0
WireConnection;0;2;211;0
WireConnection;0;3;104;0
WireConnection;0;4;26;0
ASEEND*/
//CHKSM=C130E2381F0207C4A823EA277C37C1AC46698F4E