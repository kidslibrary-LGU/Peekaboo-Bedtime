// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/TintTexOutline"
{
	Properties
	{
		_ASEOutlineColor( "Outline Color", Color ) = (0,0,0,1)
		_ASEOutlineWidth( "Outline Width", Float ) = 0.0015
		_Color("Color", Color) = (1,1,1,1)
		_Diffuse("Diffuse", Range( 0 , 1)) = 1
		_2DSwitch("2D Switch", Range( 0 , 1)) = 0
		_MainTex("MainTex", 2D) = "white" {}
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
		
		
		
		struct Input {
			half filler;
		};
		uniform half4 _ASEOutlineColor;
		uniform half _ASEOutlineWidth;
		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			v.vertex.xyz += ( v.normal * _ASEOutlineWidth );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			o.Emission = _ASEOutlineColor.rgb;
			o.Alpha = 1;
		}
		ENDCG
		

		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma exclude_renderers xbox360 xboxone ps4 psp2 n3ds wiiu 
		#pragma surface surf Lambert keepalpha addshadow fullforwardshadows exclude_path:deferred nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			half2 uv_texcoord;
		};

		uniform half4 _Color;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform half _Diffuse;
		uniform half _2DSwitch;

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			half4 tex2DNode121 = tex2D( _MainTex, uv_MainTex );
			o.Albedo = ( _Color * tex2DNode121 * _Diffuse ).rgb;
			o.Emission = ( _Color * tex2DNode121 * _2DSwitch ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Mobile/Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16300
2144;173;2034;1094;-1816.138;354.9702;1.045;True;True
Node;AmplifyShaderEditor.RangedFloatNode;64;2271.638,-91.15847;Half;False;Property;_Diffuse;Diffuse;1;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;123;2400.071,285.0662;Half;False;Property;_2DSwitch;2D Switch;2;0;Create;True;0;0;False;0;0;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;121;2006.387,159.4442;Float;True;Property;_MainTex;MainTex;3;0;Create;True;0;0;False;0;None;9edaee0606cb7574a9a456d1b3898956;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;82;2133.984,-320.1593;Float;False;Property;_Color;Color;0;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;126;2325.514,581.7499;Half;False;Property;_OutlineWidth;Outline Width;5;0;Create;True;0;0;False;0;0.001;0.0015;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;125;2394.057,387.2098;Half;False;Property;_OutlineColor;Outline Color;4;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SwitchByFaceNode;127;2613.999,597.7902;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;2988.297,117.3931;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;2887.067,-170.9124;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;1,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OutlineNode;124;2915.751,392.8269;Float;False;0;True;None;0;0;Front;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3336.758,-37.53226;Half;False;True;2;Half;ASEMaterialInspector;0;0;Lambert;Custom/TintTexOutline;False;False;False;False;False;False;False;True;True;True;True;True;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;ForwardOnly;True;True;True;True;True;True;True;False;False;False;False;False;False;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;True;0.0015;0,0,0,1;VertexOffset;True;False;Cylindrical;False;Relative;0;Mobile/Diffuse;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;127;1;126;0
WireConnection;57;0;82;0
WireConnection;57;1;121;0
WireConnection;57;2;123;0
WireConnection;66;0;82;0
WireConnection;66;1;121;0
WireConnection;66;2;64;0
WireConnection;124;0;125;0
WireConnection;124;1;127;0
WireConnection;0;0;66;0
WireConnection;0;2;57;0
ASEEND*/
//CHKSM=F527783D166FF33202FFB7A9739C4AAE956274BE