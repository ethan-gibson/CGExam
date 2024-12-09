Shader "Unlit/VertexColor"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "RenderPipeLine" = "UniversalPipeline"}
        

        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

            struct attributes{
                float4 positionOS:POSITION;
                float2 uv:TEXCOORD0;
            };
            struct varyings{
                float4 positionHCS:POSITION;
                float2 uv:TEXCOORD0;
                float4 color:COLOR;
            };

            varyings vert(attributes IN){
                varyings OUT;
                OUT.positionHCS=TransformObjectToHClip(IN.positionOS.xyz);
                OUT.color.r = OUT.positionHCS.x>12?0:1;
                OUT.color.g = OUT.positionHCS.x>50?0:OUT.positionHCS.y;
                OUT.color.b = OUT.positionHCS.x<60?0:OUT.positionHCS.z;
                OUT.color.a = 0.5;
                return OUT;
            }
            half4 frag(varyings IN):SV_Target{
                half4 color = IN.color;
                return color;
            }
            ENDHLSL
        }
    }
}
