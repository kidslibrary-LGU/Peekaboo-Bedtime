// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/Community/GradientTilling"
{
	Properties
	{
		_LineWidth("LineWidth", Range( 0 , 1)) = 0.2
		_TileY("Tile Y", Float) = 1
		_TileX("Tile X", Float) = 1
		_Color("Color", Color) = (0,1,0.1100326,1)
		_Emission("Emission", Range( 0 , 1)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		ZTest LEqual
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Lambert keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float3 worldPos;
		};

		uniform float4 _Color;
		uniform float _TileY;
		uniform float _LineWidth;
		uniform float _TileX;
		uniform float _Emission;

		void surf( Input i , inout SurfaceOutput o )
		{
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float temp_output_91_0 = (0.0 + (_LineWidth - 0.0) * (-1.0 - 0.0) / (1.0 - 0.0));
			float clampResult96 = clamp( ( ( ( frac( (ase_vertex3Pos.y*_TileY + 1.0) ) + temp_output_91_0 ) / 0.0 ) + ( ( frac( (ase_vertex3Pos.x*_TileX + 1.0) ) + temp_output_91_0 ) / 0.0 ) ) , 0.0 , 1.0 );
			float4 lerpResult97 = lerp( _Color , float4( 1,1,1,1 ) , clampResult96);
			o.Albedo = lerpResult97.rgb;
			o.Emission = ( lerpResult97 * _Emission ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16300
2183;403;2034;1082;357.3359;349.0288;1.362846;True;True
Node;AmplifyShaderEditor.RangedFloatNode;79;-69.0167,59.08992;Float;False;Property;_TileY;Tile Y;1;0;Create;True;0;0;True;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;82;-226.4153,322.1649;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;83;-190.5357,499.8406;Float;False;Property;_TileX;Tile X;2;0;Create;True;0;0;True;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;67;-104.8964,-118.5859;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;78;188.2129,-24.99981;Float;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;84;66.69363,415.7507;Float;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;66;57.3378,206.7;Float;False;Property;_LineWidth;LineWidth;0;0;Create;True;0;0;False;0;0.2;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;76;417.7151,-44.70602;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;91;429.9057,179.4769;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;86;296.1958,396.0445;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;87;566.342,513.0937;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;69;687.8611,72.34306;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;70;894.1586,63.54512;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;88;809.0403,514.6957;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;90;1046.103,88.47712;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;96;1297.006,114.4775;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;93;901.8045,-241.723;Float;False;Property;_Color;Color;5;0;Create;True;0;0;False;0;0,1,0.1100326,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;97;1375.156,-289.1862;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;1,1,1,1;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;99;1184.043,558.6265;Float;False;Property;_Emission;Emission;6;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;19;156.7253,-1238.817;Float;False;Property;_Bot_XZ;Bot_XZ;4;0;Create;True;0;0;False;0;1,1,1,1;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;21;166.9269,-1445.632;Float;False;Property;_Bot_Y;Bot_Y;3;0;Create;True;0;0;False;0;0,0,0,1;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;17;739.6219,-1402.924;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;98;1432.081,441.4218;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1711.739,-41.61039;Float;False;True;2;Float;ASEMaterialInspector;0;0;Lambert;ASESampleShaders/Community/GradientTilling;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;3;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;4;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;1;False;-1;1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;78;0;67;2
WireConnection;78;1;79;0
WireConnection;84;0;82;1
WireConnection;84;1;83;0
WireConnection;76;0;78;0
WireConnection;91;0;66;0
WireConnection;86;0;84;0
WireConnection;87;0;86;0
WireConnection;87;1;91;0
WireConnection;69;0;76;0
WireConnection;69;1;91;0
WireConnection;70;0;69;0
WireConnection;88;0;87;0
WireConnection;90;0;70;0
WireConnection;90;1;88;0
WireConnection;96;0;90;0
WireConnection;97;0;93;0
WireConnection;97;2;96;0
WireConnection;17;0;21;0
WireConnection;17;1;19;0
WireConnection;98;0;97;0
WireConnection;98;1;99;0
WireConnection;0;0;97;0
WireConnection;0;2;98;0
ASEEND*/
//CHKSM=67DF0278966AD6CF1237D53EF48D0FEDD33067F5