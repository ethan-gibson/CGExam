Shader "Unlit/Outline"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color ("Color",Color) = (0,0,0,1)
        _Width("Outline Wisth", Range(0,1)) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            Cull Front
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertexOS : POSITION;
                float3 normal:NORMAL;
            };

            struct v2f
            {
                float4 vertexHCS:SV_POSITION;
                float4 color : COLOR;
            };

            sampler2D _MainTex;
            float4 _Color;
            float _Width;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertexHCS = UnityObjectToClipPos(v.vertexOS.xyz);
                float3 norm = normalize(mul((float3x3)UNITY_MATRIX_IT_MV,v.normal));
                float2 offset = TransformViewToProjection(norm.xy);
                o.vertexHCS.xy+=offset*o.vertexHCS.z*_Width;
                o.color=_Color;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
               return i.color;
            }
            ENDCG
        }
    }
}
