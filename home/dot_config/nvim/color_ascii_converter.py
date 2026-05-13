#!/usr/bin/env python3
"""
Enhanced Color-Aware ASCII Art Converter
Converts an image to ASCII art with color information for Neovim dashboard
"""

from PIL import Image
import sys
import os
import colorsys

def get_color_intensity(r, g, b):
    """Get color intensity and determine if it's more red/orange/yellow"""
    # Convert to HSV to better analyze color
    h, s, v = colorsys.rgb_to_hsv(r/255.0, g/255.0, b/255.0)
    
    # Determine color category based on hue
    if s < 0.3:  # Low saturation = grayscale
        return 'gray', v
    elif h < 0.08 or h > 0.92:  # Red range
        return 'red', v
    elif 0.08 <= h < 0.17:  # Orange/Yellow range
        return 'orange', v
    else:  # Other colors
        return 'other', v

def image_to_colored_ascii(image_path, width=80, height=50):
    """
    Convert an image to ASCII art with color information
    
    Args:
        image_path (str): Path to the input image
        width (int): Width of ASCII output (characters)
        height (int): Height of ASCII output (lines)
    
    Returns:
        tuple: (ascii_lines, color_info)
    """
    
    # ASCII characters from darkest to lightest
    ascii_chars = "██▓▓▒▒░░  "
    
    try:
        # Open and process the image
        img = Image.open(image_path)
        
        # Convert to RGB if not already
        img = img.convert('RGB')
        
        # Resize image to fit ASCII dimensions
        img = img.resize((width, height))
        
        # Convert pixels to ASCII with color info
        ascii_lines = []
        color_lines = []
        pixels = list(img.getdata())
        
        for i in range(0, len(pixels), width):
            line = ""
            color_line = []
            
            for j in range(width):
                if i + j < len(pixels):
                    r, g, b = pixels[i + j]
                    
                    # Get brightness for ASCII character selection
                    brightness = (r + g + b) / 3
                    ascii_index = int(brightness * (len(ascii_chars) - 1) / 255)
                    char = ascii_chars[ascii_index]
                    
                    # Get color information
                    color_type, intensity = get_color_intensity(r, g, b)
                    
                    line += char
                    color_line.append((color_type, intensity, char))
                else:
                    line += " "
                    color_line.append(('gray', 0, ' '))
            
            ascii_lines.append(line)
            color_lines.append(color_line)
        
        return ascii_lines, color_lines
        
    except Exception as e:
        print(f"Error processing image: {e}")
        return None, None

def generate_colored_lua_code(ascii_lines, color_lines):
    """
    Generate Lua code with color highlighting for Neovim dashboard
    
    Args:
        ascii_lines (list): List of ASCII art lines
        color_lines (list): List of color information per line
    
    Returns:
        str: Lua code string with color highlights
    """
    
    lua_code = """      -- Custom highlight groups for image-based ASCII art
      vim.api.nvim_set_hl(0, "AsciiRed", { fg = "#FF4500" })     -- OrangeRed
      vim.api.nvim_set_hl(0, "AsciiOrange", { fg = "#FF8C00" })  -- DarkOrange  
      vim.api.nvim_set_hl(0, "AsciiYellow", { fg = "#FFD700" })  -- Gold
      vim.api.nvim_set_hl(0, "AsciiGray", { fg = "#808080" })    -- Gray
      vim.api.nvim_set_hl(0, "AsciiDark", { fg = "#2F2F2F" })    -- Dark
      
      dashboard.section.header.val = {
"""
    
    for line in ascii_lines:
        # Escape quotes and backslashes
        escaped_line = line.replace('\\', '\\\\').replace('"', '\\"')
        lua_code += f'        "{escaped_line}",\n'
    
    lua_code += "      }\n\n"
    
    # Add color highlighting based on dominant colors per line
    lua_code += "      -- Apply color highlighting\n"
    lua_code += "      dashboard.section.header.opts.hl = {\n"
    
    for i, color_line in enumerate(color_lines):
        # Determine dominant color for this line
        color_counts = {'red': 0, 'orange': 0, 'gray': 0, 'other': 0}
        for color_type, intensity, char in color_line:
            if char.strip():  # Only count non-space characters
                color_counts[color_type] += intensity
        
        # Choose highlight based on dominant color
        dominant_color = max(color_counts, key=color_counts.get)
        if dominant_color == 'red':
            highlight = "AsciiRed"
        elif dominant_color == 'orange':
            highlight = "AsciiOrange"
        elif color_counts['red'] + color_counts['orange'] > color_counts['gray']:
            highlight = "AsciiYellow"
        else:
            highlight = "AsciiGray"
        
        lua_code += f'        {{ "{highlight}", 0, -1 }},\n'
    
    lua_code += "      }\n"
    
    return lua_code

def main():
    if len(sys.argv) < 2:
        print("Usage: python color_ascii_converter.py <image_path> [width] [height]")
        print("Example: python color_ascii_converter.py my_image.jpg 80 50")
        return
    
    image_path = sys.argv[1]
    width = int(sys.argv[2]) if len(sys.argv) > 2 else 80
    height = int(sys.argv[3]) if len(sys.argv) > 3 else 50
    
    if not os.path.exists(image_path):
        print(f"Error: Image file '{image_path}' not found!")
        return
    
    print(f"Converting {image_path} to colored ASCII art...")
    print(f"Dimensions: {width}x{height}")
    
    # Convert image to ASCII with color info
    ascii_lines, color_lines = image_to_colored_ascii(image_path, width, height)
    
    if ascii_lines and color_lines:
        # Generate Lua code with colors
        lua_code = generate_colored_lua_code(ascii_lines, color_lines)
        
        # Save ASCII art to file
        output_file = "colored_ascii_output.txt"
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write("Colored ASCII Art:\n")
            f.write("=" * 80 + "\n")
            for line in ascii_lines:
                f.write(line + "\n")
            f.write("=" * 80 + "\n\n")
            f.write("Lua Code for Neovim (with colors):\n")
            f.write("=" * 80 + "\n")
            f.write(lua_code)
        
        print(f"Colored ASCII art saved to: {output_file}")
        print("\nPreview (first 10 lines):")
        for i, line in enumerate(ascii_lines[:10]):
            print(line)
        if len(ascii_lines) > 10:
            print("...")
        
        print(f"\nTotal lines: {len(ascii_lines)}")
        print("The output includes intelligent color mapping based on your image!")
        print("Copy the Lua code from the output file to your Neovim config!")
        
    else:
        print("Failed to convert image to ASCII art.")

if __name__ == "__main__":
    main()
