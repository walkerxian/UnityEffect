Shader "Custom/XCustomDiffuse" {
	

	Properties{		

		_MainColor("BaseColor",Color) = (1,0,0,1)

		_SpecColor("Glossiness",Color) = (1,1,0,1)

	}

	SubShader {


		Tags{"RenderType" = "Opaque"}

		LOD  200

		CGPROGRAM

		//已经更换为最新了的光照模型，带全局光照
		
		#pragma surface surf Lambert

		float4 _MainColor;

		struct Input
		{
			float4 col;
		};

		void surf(Input IN,inout SurfaceOutput o)
		{

			o.Albedo = _MainColor;
			o.Specular  = _SpecColor; 
		}
		
		ENDCG

	}

	FallBack "Diffuse"
}
