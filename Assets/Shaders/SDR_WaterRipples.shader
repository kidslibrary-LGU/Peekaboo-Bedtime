// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/WaterRipples"
{
	Properties
	{
		_Tint("Tint", Color) = (0,0.03592106,0.105,0)
		_SmallWaves("SmallWaves", 2D) = "bump" {}
		_DistortionScale("DistortionScale", Range( 0 , 1)) = 0.3
		_RippleScale("RippleScale", Range( 0 , 20)) = 2
		_RippleSpeed("RippleSpeed", Range( 0 , 1)) = 0.1
		_TEX_CatScene_Ground_Water("TEX_CatScene_Ground_Water", 2D) = "bump" {}
		_Opacity("Opacity", Range( 0 , 1)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Transparent+2" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		GrabPass{ }
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Lambert keepalpha addshadow fullforwardshadows noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float4 screenPos;
			float2 uv_texcoord;
		};

		uniform sampler2D _GrabTexture;
		uniform sampler2D _SmallWaves;
		uniform float _RippleScale;
		uniform float _RippleSpeed;
		uniform float _DistortionScale;
		uniform sampler2D _TEX_CatScene_Ground_Water;
		uniform float4 _TEX_CatScene_Ground_Water_ST;
		uniform float4 _Tint;
		uniform float _Opacity;


		inline float4 ASE_ComputeGrabScreenPos( float4 pos )
		{
			#if UNITY_UV_STARTS_AT_TOP
			float scale = -1.0;
			#else
			float scale = 1.0;
			#endif
			float4 o = pos;
			o.y = pos.w * 0.5f;
			o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
			return o;
		}


		void surf( Input i , inout SurfaceOutput o )
		{
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float2 uv_TEX_CatScene_Ground_Water = i.uv_texcoord * _TEX_CatScene_Ground_Water_ST.xy + _TEX_CatScene_Ground_Water_ST.zw;
			float4 screenColor5 = tex2D( _GrabTexture, ( ( float4( UnpackNormal( tex2D( _SmallWaves, ( _RippleScale * (( ( _Time.y * _RippleSpeed ) + ase_grabScreenPosNorm )).xy ) ) ) , 0.0 ) * float4( ( _DistortionScale * UnpackNormal( tex2D( _TEX_CatScene_Ground_Water, uv_TEX_CatScene_Ground_Water ) ) ) , 0.0 ) * _Tint ) + ase_grabScreenPosNorm ).rg );
			o.Emission = ( screenColor5 * _Opacity ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16300
2196;73;2034;1279;2099.503;671.5494;1.507123;True;True
Node;AmplifyShaderEditor.TimeNode;14;-1634.708,34.53822;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;20;-1733.444,355.7454;Float;False;Property;_RippleSpeed;RippleSpeed;4;0;Create;True;0;0;False;0;0.1;0.07;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GrabScreenPosition;10;-1668.911,503.4621;Float;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-1515.676,256.5839;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;18;-1357.445,243.3362;Float;False;2;2;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-1324.512,42.47158;Float;False;Property;_RippleScale;RippleScale;3;0;Create;True;0;0;False;0;2;2;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;15;-1185.128,151.9887;Float;False;FLOAT2;0;1;2;0;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;23;-1087.215,-168.9276;Float;True;Property;_TEX_CatScene_Ground_Water;TEX_CatScene_Ground_Water;5;0;Create;True;0;0;False;0;None;dd2fd2df93418444c8e280f1d34deeb5;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;13;-1075.352,-345.8084;Float;False;Property;_DistortionScale;DistortionScale;2;0;Create;True;0;0;False;0;0.3;0.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-1005.423,108.4069;Float;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;24;-256.9746,802.4673;Float;False;Property;_Tint;Tint;0;0;Create;True;0;0;False;0;0,0.03592106,0.105,0;0.5235849,0.8721054,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;9;-806.9052,72.11033;Float;True;Property;_SmallWaves;SmallWaves;1;0;Create;True;0;0;False;0;dd2fd2df93418444c8e280f1d34deeb5;dd2fd2df93418444c8e280f1d34deeb5;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-705.3395,-125.7927;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-493.5251,-173.1885;Float;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;11;-368.8214,277.1034;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ScreenColorNode;5;-168.9637,235.1813;Float;False;Global;_GrabScreen0;Grab Screen 0;0;0;Create;True;0;0;False;0;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;27;-336.5658,498.4615;Float;False;Property;_Opacity;Opacity;6;0;Create;True;0;0;False;0;1;0.465;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;82.4342,247.4615;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;28;119.8045,586.5483;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;427.6315,167.9727;Float;False;True;2;Float;ASEMaterialInspector;0;0;Lambert;Custom/WaterRipples;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Translucent;0.5;True;True;2;False;Opaque;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;19;0;14;2
WireConnection;19;1;20;0
WireConnection;18;0;19;0
WireConnection;18;1;10;0
WireConnection;15;0;18;0
WireConnection;17;0;16;0
WireConnection;17;1;15;0
WireConnection;9;1;17;0
WireConnection;22;0;13;0
WireConnection;22;1;23;0
WireConnection;12;0;9;0
WireConnection;12;1;22;0
WireConnection;12;2;24;0
WireConnection;11;0;12;0
WireConnection;11;1;10;0
WireConnection;5;0;11;0
WireConnection;25;0;5;0
WireConnection;25;1;27;0
WireConnection;28;1;24;0
WireConnection;0;2;25;0
ASEEND*/
//CHKSM=EF53B59F40049C8C721240DB9130DF0C97E0276D