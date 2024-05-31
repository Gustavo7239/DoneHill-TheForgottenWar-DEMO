shader_type canvas_item;

uniform sampler2D distortionTexture: repeat_enable; // Corrige el nombre aquí si es necesario
uniform vec2 scroll = vec2(0.05, 0.05);

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    // Ajusta las coordenadas UV de la textura de distorsión con el desplazamiento
    vec2 scrolledUV = UV + scroll * TIME;

    // Obtén las coordenadas UV distorsionadas usando la textura de distorsión desplazada
    vec2 distortedUV = SCREEN_UV + texture(distortionTexture, scrolledUV).r * 0.1;

    // Muestra el color de la pantalla en las coordenadas distorsionadas
    vec4 screenColor = texture(TEXTURE, distortedUV);
    COLOR = screenColor;
}
