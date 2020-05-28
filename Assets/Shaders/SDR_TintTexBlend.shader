// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/TintTexBlend"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Color("Color", Color) = (1,1,1,1)
		_Diffuse("Diffuse", Range( 0 , 1)) = 1
		_2DSwitch("2D Switch", Range( 0 , 1)) = 0
		_MainTex("MainTex", 2D) = "white" {}
		_MainTex2("MainTex2", 2D) = "white" {}
		_BlendTextures("Blend Textures", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Back
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#pragma target 3.0
		#pragma exclude_renderers xbox360 xboxone ps4 psp2 n3ds wiiu 
		#pragma surface surf Lambert keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Color;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform sampler2D _MainTex2;
		uniform float4 _MainTex2_ST;
		uniform half _BlendTextures;
		uniform half _Diffuse;
		uniform half _2DSwitch;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode121 = tex2D( _MainTex, uv_MainTex );
			float2 uv_MainTex2 = i.uv_texcoord * _MainTex2_ST.xy + _MainTex2_ST.zw;
			float4 tex2DNode126 = tex2D( _MainTex2, uv_MainTex2 );
			float4 lerpResult125 = lerp( tex2DNode121 , tex2DNode126 , _BlendTextures);
			o.Albedo = ( _Color * lerpResult125 * _Diffuse ).rgb;
			o.Emission = ( _Color * lerpResult125 * _2DSwitch ).rgb;
			o.Alpha = 1;
			float lerpResult128 = lerp( tex2DNode121.a , tex2DNode126.a , _BlendTextures);
			clip( lerpResult128 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Mobile/Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16300
2183;289;2034;1082;-1401.986;501.9781;1.295988;True;True
Node;AmplifyShaderEditor.SamplerNode;121;2012.867,68.725;Float;True;Property;_MainTex;MainTex;4;0;Create;True;0;0;False;0;None;778635da83e23874ea93cdbd1d455091;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;126;2043.5,338.4707;Float;True;Property;_MainTex2;MainTex2;5;0;Create;True;0;0;False;0;None;778635da83e23874ea93cdbd1d455091;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;124;2047.389,615.8121;Half;False;Property;_BlendTextures;Blend Textures;6;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;64;2271.638,-91.15847;Half;False;Property;_Diffuse;Diffuse;2;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;82;2133.984,-320.1593;Float;False;Property;_Color;Color;1;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;123;2494.677,338.2018;Half;False;Property;_2DSwitch;2D Switch;3;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;125;2493.206,53.35383;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;2988.297,117.3931;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;2887.067,-170.9124;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;1,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;128;3009.011,401.3255;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3243.068,-98.21226;Float;False;True;2;Float;ASEMaterialInspector;0;0;Lambert;Custom/TintTexBlend;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;False;Transparent;;AlphaTest;All;True;True;True;True;True;True;True;False;False;False;False;False;False;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;Mobile/Diffuse;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;125;0;121;0
WireConnection;125;1;126;0
WireConnection;125;2;124;0
WireConnection;57;0;82;0
WireConnection;57;1;125;0
WireConnection;57;2;123;0
WireConnection;66;0;82;0
WireConnection;66;1;125;0
WireConnection;66;2;64;0
WireConnection;128;0;121;4
WireConnection;128;1;126;4
WireConnection;128;2;124;0
WireConnection;0;0;66;0
WireConnection;0;2;57;0
WireConnection;0;10;128;0
ASEEND*/
//CHKSM=92BE9C73D81FDB199090C8AA5AB430FB0ED240D8