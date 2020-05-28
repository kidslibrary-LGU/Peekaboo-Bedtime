// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/TintTexRimOutlineTex"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_Diffuse("Diffuse", Range( 0 , 1)) = 1
		_2DSwitch("2D Switch", Range( 0 , 1)) = 0
		_MainTex("MainTex", 2D) = "white" {}
		_OutlineMultiply("Outline Multiply", Color) = (1,1,1,0)
		_OutlineAdd("Outline Add", Color) = (0,0,0,0)
		_OutlineWidth("Outline Width", Float) = 0.001
		_RimIntensity("Rim Intensity", Range( 0 , 2)) = 0
		_RimPower("Rim Power", Range( 0 , 5)) = 1.5
		_RimColor("Rim Color", Color) = (1,1,1,1)
		_Rim_Shadow("Rim_Shadow", Range( 0 , 1)) = 0.5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ }
		Cull Front
		CGPROGRAM
		#pragma target 3.0
		#pragma surface outlineSurf Outline nofog  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc 
		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float outlineVar = _OutlineWidth;
			v.vertex.xyz += ( v.normal * outlineVar );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			half4 tex2DNode121 = tex2D( _MainTex, uv_MainTex );
			o.Emission = ( ( tex2DNode121 * _OutlineMultiply ) + ( tex2DNode121 * _OutlineAdd ) ).rgb;
		}
		ENDCG
		

		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityCG.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			half2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
		};

		uniform half4 _Color;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform half _Diffuse;
		uniform half _2DSwitch;
		uniform half _RimIntensity;
		uniform half _RimPower;
		uniform half _Rim_Shadow;
		uniform half4 _RimColor;
		uniform half _OutlineWidth;
		uniform half4 _OutlineMultiply;
		uniform half4 _OutlineAdd;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			v.vertex.xyz += 0;
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			half4 tex2DNode121 = tex2D( _MainTex, uv_MainTex );
			o.Albedo = ( _Color * tex2DNode121 * _Diffuse ).rgb;
			float3 ase_worldPos = i.worldPos;
			half3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			half3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV140 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode140 = ( 0.0 + _RimIntensity * pow( 1.0 - fresnelNdotV140, _RimPower ) );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult136 = dot( ase_worldNormal , ase_worldlightDir );
			float clampResult134 = clamp( dotResult136 , 0.0 , 1.0 );
			float clampResult141 = clamp( clampResult134 , _Rim_Shadow , 1.0 );
			o.Emission = ( ( _Color * tex2DNode121 * _2DSwitch ) + ( fresnelNode140 * clampResult141 * _RimColor ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma exclude_renderers xbox360 xboxone ps4 psp2 n3ds wiiu 
		#pragma surface surf Lambert keepalpha fullforwardshadows exclude_path:deferred nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float3 worldNormal : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldNormal = worldNormal;
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = IN.worldNormal;
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Mobile/Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16300
2186;23;1917;1077;-836.0416;362.5056;1.876646;True;True
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;135;1736.106,872.8942;Float;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;133;1749.93,713.0598;Float;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DotProductOpNode;136;2081.027,713.1201;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;121;1980.787,46.80424;Float;True;Property;_MainTex;MainTex;3;0;Create;True;0;0;False;0;None;9edaee0606cb7574a9a456d1b3898956;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;132;2140.531,536.0101;Half;False;Property;_OutlineAdd;Outline Add;5;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;125;2141.893,306.5699;Half;False;Property;_OutlineMultiply;Outline Multiply;4;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;138;2164.476,1068.883;Half;False;Property;_Rim_Shadow;Rim_Shadow;10;0;Create;True;0;0;False;0;0.5;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;137;1783.672,1410.563;Half;False;Property;_RimPower;Rim Power;8;0;Create;True;0;0;False;0;1.5;1.5;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;134;2355.076,716.9252;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;139;1805.722,1267.618;Half;False;Property;_RimIntensity;Rim Intensity;7;0;Create;True;0;0;False;0;0;0.3;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;142;2706.636,1547.194;Half;False;Property;_RimColor;Rim Color;9;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;129;2574.448,274.8906;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.503,0.503,0.503,1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;131;2579.57,448.9699;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.503,0.503,0.503,1;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;82;2133.984,-320.1593;Half;False;Property;_Color;Color;0;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;140;2273.324,1303.842;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;141;2627.293,1001.528;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;123;2590.792,176.2663;Half;False;Property;_2DSwitch;2D Switch;2;0;Create;True;0;0;False;0;0;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;143;2879.446,1209.427;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;130;2799.732,319.6902;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;126;2326.794,721.2701;Half;False;Property;_OutlineWidth;Outline Width;6;0;Create;True;0;0;False;0;0.001;0.0015;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;64;2271.638,-91.15847;Half;False;Property;_Diffuse;Diffuse;1;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;2988.297,117.3931;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;144;3142.439,97.2725;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OutlineNode;124;3027.111,392.8269;Float;False;0;True;None;0;0;Front;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;2887.067,-170.9124;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;1,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3336.758,-37.53226;Half;False;True;2;Half;ASEMaterialInspector;0;0;Lambert;Custom/TintTexRimOutlineTex;False;False;False;False;False;False;False;True;True;True;True;True;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;ForwardOnly;True;True;True;True;True;True;True;False;False;False;False;False;False;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0.0015;0,0,0,1;VertexOffset;True;False;Cylindrical;False;Relative;0;Mobile/Diffuse;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;136;0;133;0
WireConnection;136;1;135;0
WireConnection;134;0;136;0
WireConnection;129;0;121;0
WireConnection;129;1;125;0
WireConnection;131;0;121;0
WireConnection;131;1;132;0
WireConnection;140;2;139;0
WireConnection;140;3;137;0
WireConnection;141;0;134;0
WireConnection;141;1;138;0
WireConnection;143;0;140;0
WireConnection;143;1;141;0
WireConnection;143;2;142;0
WireConnection;130;0;129;0
WireConnection;130;1;131;0
WireConnection;57;0;82;0
WireConnection;57;1;121;0
WireConnection;57;2;123;0
WireConnection;144;0;57;0
WireConnection;144;1;143;0
WireConnection;124;0;130;0
WireConnection;124;1;126;0
WireConnection;66;0;82;0
WireConnection;66;1;121;0
WireConnection;66;2;64;0
WireConnection;0;0;66;0
WireConnection;0;2;144;0
WireConnection;0;11;124;0
ASEEND*/
//CHKSM=C0D7CDFDCD61C38FB1CBDA88F4C50C6E7254ECC1