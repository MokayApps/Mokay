import os
import json
import re
from pathlib import Path

def load_json(file_path):
    with open(file_path, encoding="utf-8") as f:
        return json.load(f)

def resolve_reference(ref, palette):
    """
    Разрешает ссылки вида {colors.primary.500} через палитру
    """
    match = re.match(r"\{colors\.([a-zA-Z0-9]+)\.([0-9]+)\}", ref)
    if match:
        color_family, shade = match.groups()
        return palette["colors"][color_family][shade]["value"]
    return ref

def flatten_tokens(tokens, prefix=""):
    """
    Плоская структура: {'primary_background': '#FFFFFF'}
    """
    flat = {}
    for key, val in tokens.items():
        new_prefix = f"{prefix}_{key}" if prefix else key
        if isinstance(val, dict) and "value" in val:
            flat[new_prefix] = val["value"]
        elif isinstance(val, dict):
            flat.update(flatten_tokens(val, new_prefix))
    return flat

def hex_to_color_params(hex_str):
    """
    Преобразует #RRGGBB или #RRGGBBAA в (hex_uint, alpha_float)
    """
    hex_str = hex_str.lstrip("#")
    if len(hex_str) == 6:  # только RGB
        rgb = f"0x{hex_str.upper()}"
        alpha = "1.0"
    elif len(hex_str) == 8:  # RGBA
        rgb = f"0x{hex_str[:6].upper()}"
        alpha_hex = hex_str[6:8]
        alpha = f"{int(alpha_hex, 16) / 255:.3f}"
    else:
        rgb = "0x000000"
        alpha = "1.0"
    return rgb, alpha

def make_safe_name(token):
    """
    Преобразует имя токена в безопасное для Swift (только буквы, цифры, _)
    """
    return re.sub(r'[^0-9a-zA-Z_]', '_', token)

def main():
    base_dir = Path.cwd()

    palette = load_json("colorPalette.json")
    tokens_light = flatten_tokens(load_json("tokensLightTheme.json")["tokens"])
    tokens_dark = flatten_tokens(load_json("tokensDarkTheme.json")["tokens"])

    all_keys = sorted(set(tokens_light.keys()) | set(tokens_dark.keys()))

    lines = []
    lines.append("// Auto-generated file. Do not edit manually.\n")
    lines.append("import SwiftUI\n\n")
    lines.append("public extension Color {\n")

    for token in all_keys:
        light_value = tokens_light.get(token)
        dark_value = tokens_dark.get(token)

        if light_value:
            light_hex = resolve_reference(light_value, palette)
        else:
            light_hex = dark_hex = resolve_reference(dark_value, palette)

        if dark_value:
            dark_hex = resolve_reference(dark_value, palette)
        else:
            dark_hex = light_hex

        light_uint, light_alpha = hex_to_color_params(light_hex)
        dark_uint, dark_alpha = hex_to_color_params(dark_hex)

        safe_name = make_safe_name(token)

        # SwiftUI Color
        lines.append(f"    static let {safe_name} = Color(\n")
        lines.append(f"        light: Color({light_uint}, alpha: {light_alpha}),\n")
        lines.append(f"        dark: Color({dark_uint}, alpha: {dark_alpha})\n")
        lines.append("    )\n\n")

    lines.append("}\n")

    out_path = base_dir / "MokayColors.swift"
    os.makedirs(base_dir, exist_ok=True)
    with open(out_path, "w", encoding="utf-8") as f:
        f.writelines(lines)

    print(f"✅ Generated {out_path.relative_to(base_dir)}")

if __name__ == "__main__":
    main()
