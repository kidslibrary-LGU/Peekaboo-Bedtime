// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/CausticsProjection"
{
	Properties
	{
		_Color0("Color 0", Color) = (0.902,0.9496,1,1)
		_Caustic("Caustic", 2D) = "black" {}
		_CausticIntensity("Caustic Intensity", Range( 0 , 1)) = 0.5
		_Speed("Speed", Range( 0 , 3)) = 1
		_CausticSize("Caustic Size", Range( 0 , 1)) = 0.5
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		ZTest LEqual
		Blend SrcAlpha OneMinusSrcAlpha
		BlendOp Add
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma exclude_renderers xbox360 xboxone ps4 psp2 n3ds wiiu 
		#pragma surface surf StandardCustomLighting keepalpha 
		struct Input
		{
			float3 worldPos;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform half4 _Color0;
		uniform sampler2D _Caustic;
		uniform half _Speed;
		uniform half _CausticSize;
		uniform half _CausticIntensity;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float mulTime242 = _Time.y * ( 1.0 * _Speed );
			float3 ase_worldPos = i.worldPos;
			float2 temp_output_263_0 = ( (ase_worldPos).xz * _CausticSize );
			float2 panner178 = ( mulTime242 * float2( 0.05,0.04 ) + temp_output_263_0);
			float mulTime247 = _Time.y * ( 0.98 * _Speed );
			float2 panner225 = ( mulTime247 * float2( -0.045,-0.035 ) + temp_output_263_0);
			float4 lerpResult223 = lerp( tex2D( _Caustic, panner178 ) , tex2D( _Caustic, panner225 ) , float4( 0,0,0,0 ));
			float mulTime245 = _Time.y * ( 1.3 * _Speed );
			float2 panner179 = ( mulTime245 * float2( 0.035,-0.025 ) + temp_output_263_0);
			float mulTime246 = _Time.y * ( 1.2 * _Speed );
			float2 panner229 = ( mulTime246 * float2( -0.03,0.035 ) + temp_output_263_0);
			float4 lerpResult227 = lerp( tex2D( _Caustic, panner179 ) , tex2D( _Caustic, panner229 ) , float4( 0,0,0,0 ));
			half4 blendOpSrc173 = lerpResult223;
			half4 blendOpDest173 = lerpResult227;
			float4 lerpResult177 = lerp( float4( 0,0,0,1 ) , ( saturate( ( blendOpSrc173 * blendOpDest173 ) )) , _CausticIntensity);
			c.rgb = 0;
			c.a = lerpResult177.r;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Emission = _Color0.rgb;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16300
2196;91;2034;1261;2867.633;-738.6326;1;True;True
Node;AmplifyShaderEditor.RangedFloatNode;241;-2753.473,1153.413;Float;False;Property;_Speed;Speed;4;0;Create;True;0;0;False;0;1;3;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;260;-2418.411,1284.771;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;240;-2279.072,-94.54243;Float;False;2;2;0;FLOAT;1;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;264;-2369.309,1533.061;Float;False;Property;_CausticSize;Caustic Size;5;0;Create;True;0;0;False;0;0.5;0.202;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;248;-2078.652,936.4138;Float;False;2;2;0;FLOAT;0.98;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;244;-2265.464,372.6447;Float;False;2;2;0;FLOAT;1.2;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;262;-2050.351,1302.553;Float;False;True;False;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;243;-2279.16,180.9004;Float;False;2;2;0;FLOAT;1.3;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;242;-2064.969,-76.80462;Float;False;1;0;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;263;-1648.301,1168.537;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0.1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;247;-1736.621,1015.125;Float;False;1;0;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;245;-2035.675,156.5517;Float;False;1;0;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;246;-1960.622,492.1176;Float;False;1;0;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;153;-1239.823,958.5485;Float;False;1808.422;978.0755;Foam controls and texture;11;228;174;227;173;223;105;179;224;178;225;229;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PannerNode;225;-762.688,1270.394;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.045,-0.035;False;1;FLOAT;0.98;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;178;-759.4774,1064.399;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.05,0.04;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;179;-730.0169,1492.886;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.035,-0.025;False;1;FLOAT;1.3;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;229;-814.5994,1738.101;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.03,0.035;False;1;FLOAT;0.8;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;105;-559.156,1012.861;Float;True;Property;_Caustic;Caustic;2;0;Create;True;0;0;False;0;dd5053c9414ca0c4aa227c0cb8915ca3;dd5053c9414ca0c4aa227c0cb8915ca3;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;224;-530.418,1231.618;Float;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;False;0;dd5053c9414ca0c4aa227c0cb8915ca3;daa19e387b4a74d469ee70308494db7a;True;0;False;black;Auto;False;Instance;105;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;228;-484.3242,1662.389;Float;True;Property;_TextureSample1;Texture Sample 1;2;0;Create;True;0;0;False;0;dd5053c9414ca0c4aa227c0cb8915ca3;dd5053c9414ca0c4aa227c0cb8915ca3;True;0;False;black;Auto;False;Instance;105;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;174;-492.3499,1430.12;Float;True;Property;_Caustic2;Caustic2;2;0;Create;True;0;0;False;0;dd5053c9414ca0c4aa227c0cb8915ca3;dd5053c9414ca0c4aa227c0cb8915ca3;True;0;False;black;Auto;False;Instance;105;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;223;-91.24854,1037.513;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;227;-64.12802,1459.954;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;173;122.3716,1175.616;Float;True;Multiply;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;176;745.5319,737.2528;Float;False;Property;_CausticIntensity;Caustic Intensity;3;0;Create;True;0;0;False;0;0.5;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;177;991.1271,251.1909;Float;True;3;0;COLOR;0,0,0,1;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;259;1566.001,413.9305;Half;False;Property;_Color0;Color 0;1;0;Create;True;0;0;False;0;0.902,0.9496,1,1;0.8537736,0.9463837,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1967.098,93.24877;Half;False;True;2;Half;ASEMaterialInspector;0;0;CustomLighting;Custom/CausticsProjection;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;2;False;-1;3;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;TransparentCutout;;Transparent;All;True;True;True;True;True;True;True;False;False;False;False;False;False;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;4;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;1;False;-1;1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;240;1;241;0
WireConnection;248;1;241;0
WireConnection;244;1;241;0
WireConnection;262;0;260;0
WireConnection;243;1;241;0
WireConnection;242;0;240;0
WireConnection;263;0;262;0
WireConnection;263;1;264;0
WireConnection;247;0;248;0
WireConnection;245;0;243;0
WireConnection;246;0;244;0
WireConnection;225;0;263;0
WireConnection;225;1;247;0
WireConnection;178;0;263;0
WireConnection;178;1;242;0
WireConnection;179;0;263;0
WireConnection;179;1;245;0
WireConnection;229;0;263;0
WireConnection;229;1;246;0
WireConnection;105;1;178;0
WireConnection;224;1;225;0
WireConnection;228;1;229;0
WireConnection;174;1;179;0
WireConnection;223;0;105;0
WireConnection;223;1;224;0
WireConnection;227;0;174;0
WireConnection;227;1;228;0
WireConnection;173;0;223;0
WireConnection;173;1;227;0
WireConnection;177;1;173;0
WireConnection;177;2;176;0
WireConnection;0;2;259;0
WireConnection;0;9;177;0
ASEEND*/
//CHKSM=4E576C532665BF1A72CD3444FCC8B1A453B9C5E1