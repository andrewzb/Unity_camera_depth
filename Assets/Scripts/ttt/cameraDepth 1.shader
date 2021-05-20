Shader "Hidden/cameraDepth 1"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };


            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
            sampler2D _CameraDepthNormalsTexture;
            //sampler2D _CameraDepthTexture;
            
            float4x4 UNITY_MATRIX_IV;

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                float4 NormalDepth;

                DecodeDepthNormal(tex2D(_CameraDepthNormalsTexture, i.uv), NormalDepth.w, NormalDepth.xyz);
                //DecodeDepthNormal(tex2D(_CameraDepthTexture, i.uv), NormalDepth.w, NormalDepth.xyz);
                /*
                if (NormalDepth.x > 0)
                {
                    col.rgb = float3(1,0,0);
                }
                else {
                    col.rgb = float3(0,1,0);
                }
                */
                float3 WorldNormal = mul(UNITY_MATRIX_IV, float4(NormalDepth.xyz, 0)).xyz;
                //col.rgb = WorldNormal.rgb;
                //col.rgb = NormalDepth.w;
                if(i.uv.x > 2.0/3.0) col.rgb = float3(NormalDepth.w, NormalDepth.w,NormalDepth.w);
                if(i.uv.x < 1.0/3.0) col.rgb = WorldNormal.xyz;

                //col.rgb = WorldNormal.rgb;
                //if (UNITY_MATRIX_IV[0][0] > 0)
                /*
                if (UNITY_MATRIX_IV[0][0] < 0)
                {
                    col.rgb = float3(0,0,0);
                }
                else
                {
                    col.rgb = float3(1,1,1);
                }
                */


                return col;
            }
            ENDCG
        }
    }
}
