Shader "Unlit/AmbiSpecShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _MainColor("Color",Color) = (1,1,1,0)
        _SpecColor("Shine Color",Color) = (0,0,0,1)
        _Shininess("Shininess",range(0,100)) = 50
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "RenderQueue" = "UniversalPipeline"}

        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

            struct appdata
            {
                float4 vertexOS : POSITION;
                float2 uv : TEXCOORD0;
                float3 normalOS:TEXCOORD1;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertexHCS : SV_POSITION;
                float3 normalHCS:TEXCOORD1;
                float3 viewDir:TEXCOORD2;
            };

            TEXTURE2D(_MainTex);
            SAMPLER(sampler_MainTex);

            CBUFFER_START(UnityPerMaterial)
                float4 _MainColor;
                float4 _SpecColor;
                float _Shininess;
            CBUFFER_END

            v2f vert (appdata v)
            {
                v2f o;
                o.vertexHCS=TransformObjectToHClip(v.vertexOS.xyz);
                o.normalHCS=normalize(TransformObjectToWorldNormal(v.normalOS));
                float3 worldpos = TransformObjectToWorld(v.vertexOS.xyz);
                o.viewDir=normalize(GetCameraPositionWS()-worldpos);
                o.uv=v.uv;
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                half4 texColor = SAMPLE_TEXTURE2D(_MainTex,sampler_MainTex,i.uv);
                Light mainLight = GetMainLight();
                float3 lightDir = normalize(mainLight.direction);
                half3 normalWS = normalize(i.normalHCS);
                half3 ambient = SampleSH(normalWS);
                half3 reflectDir = reflect(-lightDir,normalWS);
                half3 viewDir = normalize(i.viewDir);
                half specAmount = pow(saturate(dot(reflectDir,viewDir)),_Shininess);
                half3 specular = _SpecColor.rgb*specAmount;
                half3 final = ambient*texColor.rgb*_MainColor.rgb+specular;

                return half4(final,1);
            }
            ENDHLSL
        }
    }
}
