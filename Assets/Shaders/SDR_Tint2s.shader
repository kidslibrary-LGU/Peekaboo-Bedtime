// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/Tint2s"
{
	Properties
	{
		_Color("Color", Color) = (0.5,0.5,0.5,1)
		_Diffuse("Diffuse", Range( 0 , 1)) = 1
		_2DSwitch("2D Switch", Range( 0 , 1)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#pragma target 3.0
		#pragma exclude_renderers xbox360 xboxone ps4 psp2 n3ds wiiu 
		#pragma surface surf Lambert keepalpha addshadow fullforwardshadows 
		struct Input
		{
			half filler;
		};

		uniform half _Diffuse;
		uniform float4 _Color;
		uniform half _2DSwitch;

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Albedo = ( _Diffuse * _Color ).rgb;
			o.Emission = ( _Color * _2DSwitch ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Mobile/Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16300
2196;91;2034;1261;-1529.366;735.312;1.206536;True;True
Node;AmplifyShaderEditor.RangedFloatNode;121;2433.455,161.8562;Half;False;Property;_2DSwitch;2D Switch;2;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;82;2091.16,-375.6297;Float;False;Property;_Color;Color;0;0;Create;True;0;0;False;0;0.5,0.5,0.5,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;122;2616.95,-280.7103;Half;False;Property;_Diffuse;Diffuse;1;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;123;2973.14,116.9142;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;124;2949.459,-101.8805;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3310.273,-63.43064;Float;False;True;2;Float;ASEMaterialInspector;0;0;Lambert;Custom/Tint2s;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;False;False;False;False;False;False;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;Mobile/Diffuse;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;123;0;82;0
WireConnection;123;1;121;0
WireConnection;124;0;122;0
WireConnection;124;1;82;0
WireConnection;0;0;124;0
WireConnection;0;2;123;0
ASEEND*/
//CHKSM=1248B69FAF05CFEC7EF3616CF0290D04F91D3CEA