using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
[RequireComponent(typeof(Camera))]
public class ScreenDepth : MonoBehaviour
{
    [SerializeField] private Shader shad = null;
    [SerializeField] private DepthTextureMode dtm = DepthTextureMode.Depth;
    public Camera cam = null;
    public Material mat = null;



    private void Update()
    {
        if (cam == null)
        {
            cam = GetComponent<Camera>();
            cam.depthTextureMode = dtm;
        }

        if(mat == null)
        {
            mat = new Material(shad);
        }
    }

    private void OnPreRender()
    {
        var matrix = cam.cameraToWorldMatrix;
        Shader.SetGlobalMatrix(Shader.PropertyToID("UNITY_MATRIX_IV"), cam.cameraToWorldMatrix);
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
       Graphics.Blit(source, destination, mat);
    }
}
