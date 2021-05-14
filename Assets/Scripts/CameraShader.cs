using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class CameraShader : MonoBehaviour
{
    public Shader newCameraShader = null;
    public Camera mainCamera = null;

    private void OnEnable()
    {
        if (newCameraShader != null)
            mainCamera.SetReplacementShader(newCameraShader, "RenderType");
        mainCamera.depthTextureMode = DepthTextureMode.Depth;



    }
    private void OnDisable()
    {
        mainCamera.ResetReplacementShader();
    }

}
