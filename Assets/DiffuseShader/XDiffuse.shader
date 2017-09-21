Shader "Custom/XDiffuse" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM

		//surface表示该 Shader以 surface shader格式来编写。
		//surfaceFunction”是指surface的函数，在一定条件下可以随便取名，在默认创建的Surface Shader中的"surf"就是函数名，下面也有对应的函数体。
		//Smoothness”是平滑度，描述的是高光的强度
		//Metallic”表示的是金属质感，调整这个系数可以修改金属质感的强度，金属质感原理就是如果光照射非常光滑的金属物体，有镜面反射的部分光会很集中，形成高亮，没有镜面反射的地方就会很暗淡。

		//有反射的地方会变得非常高亮，没有反射的地方会变得非常暗淡。
		//#pragma target 3.0”表示我们将要对这个着色器使用硬件的“shader model 3.0”的能力
		//fullforwardshadows”表示它能够在Forward渲染路径下支持所有的阴影类型，默认的shader仅仅能支持一个方向光的阴影，如要在Forward渲染路径下使用点光源或聚光灯产生的阴影就需要使用该指令。

		// Physically based Standard lighting model, and enable shadows on all light types

		#pragma surface surf Standard fullforwardshadows
		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_CBUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_CBUFFER_END

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;

			o.Albedo = c.rgb;

			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;

			o.Smoothness = _Glossiness;

			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
