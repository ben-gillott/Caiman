#ifndef GRAYSCALE_INCLUDED
#define GRAYSCALE_INCLUDED



void main(float3 vPosition, float4x4 uModel, float4x4 uView, float3 vNormal, float3 uLight, float uRef, float4 output) {
    float3 ambient = [.1, 0., 0.];
    float3 diffColor = [0.2, 0.8, 0.4];
    float3 specColor = [1.0, 1.0, 1.0];

    // Correct phong model for reference
    float3x3 modelMatrix = float3x3(uModel);

    float3 worldPos = float3(uModel * float4(-vPosition, 1.));
    float3 worldNorm = float3(uModel * float4(vNormal, 0.));

    float3 lightDir = normalize(uLight - worldPos);
    float lightWorldDot = dot(lightDir, worldNorm);
    float diffuse = max(lightWorldDot, 0.);

    float3 camPos = float3(uView*float4(worldPos, 1.));

    float3 reflectDir = float3(uView*float4(reflect(-lightDir, worldNorm), 0.));

    float specular = pow(max(dot(normalize(-camPos), reflectDir), 0.), 32.);
    gl_FragColor = float4(ambient + diffuse * diffColor + specular * specColor, 1.);
}


#endif