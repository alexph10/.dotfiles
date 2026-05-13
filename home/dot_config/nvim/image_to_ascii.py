#!/usr/bin/env python3
"""
Image to ASCII Art Converter
Converts an image to ASCII art suitable for Neovim dashboard
"""

from PIL import Image
import sys
import os

def image_to_ascii(image_path, width=80, height=50):
    """
    Convert an image to ASCII art
    
    Args:
        image_path (str): Path to the input image
        width (int): Width of ASCII output (characters)
        height (int): Height of ASCII output (lines)
    
    Returns:
        list: List of strings representing ASCII art lines
    """
    
    # ASCII characters from darkest to lightest (inverted for reversed highlighting)
    ascii_chars = " .:-=+*#%@"
    
    try:
        # Open and process the image
        img = Image.open(image_path)
        
        # Convert to grayscale
        img = img.convert('L')
        
        # Resize image to fit ASCII dimensions
        # Account for character aspect ratio (characters are taller than wide)
        img = img.resize((width, height))
        
        # Convert pixels to ASCII
        ascii_lines = []
        pixels = list(img.getdata())
        
        for i in range(0, len(pixels), width):
            line = ""
            for j in range(width):
                if i + j < len(pixels):
                    # Map pixel brightness (0-255) to ASCII character (inverted)
                    pixel = pixels[i + j]
                    # Invert the pixel value for reversed highlighting
                    inverted_pixel = 255 - pixel
                    ascii_index = int(inverted_pixel * (len(ascii_chars) - 1) / 255)
                    line += ascii_chars[ascii_index]
                else:
                    line += " "
            ascii_lines.append(line)
        
        return ascii_lines
        
    except Exception as e:
        print(f"Error processing image: {e}")
        return None

def generate_lua_code(ascii_lines, colors=None):
    """
    Generate Lua code for Neovim dashboard
    
    Args:
        ascii_lines (list): List of ASCII art lines
        colors (list): Optional list of color names for gradient effect
    
    Returns:
        str: Lua code string
    """
    
    if not colors:
        colors = ["DashboardHeader1", "DashboardHeader2", "DashboardHeader3"]
    
    lua_code = "      dashboard.section.header.val = {\n"
    
    for i, line in enumerate(ascii_lines):
        # Escape quotes and backslashes
        escaped_line = line.replace('\\', '\\\\').replace('"', '\\"')
        lua_code += f'        "{escaped_line}",\n'
    
    lua_code += "      }\n"
    
    return lua_code

def main():
    if len(sys.argv) < 2:
        print("Usage: python image_to_ascii.py <image_path> [width] [height]")
        print("Example: python image_to_ascii.py my_image.jpg 80 50")
        return
    
    image_path = sys.argv[1]
    width = int(sys.argv[2]) if len(sys.argv) > 2 else 80
    height = int(sys.argv[3]) if len(sys.argv) > 3 else 50
    
    if not os.path.exists(image_path):
        print(f"Error: Image file '{image_path}' not found!")
        return
    
    print(f"Converting {image_path} to ASCII art...")
    print(f"Dimensions: {width}x{height}")
    
    # Convert image to ASCII
    ascii_lines = image_to_ascii(image_path, width, height)
    
    if ascii_lines:
        # Generate Lua code
        lua_code = generate_lua_code(ascii_lines)
        
        # Save ASCII art to file
        output_file = "ascii_art_output.txt"
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write("ASCII Art:\n")
            f.write("=" * 80 + "\n")
            for line in ascii_lines:
                f.write(line + "\n")
            f.write("=" * 80 + "\n\n")
            f.write("Lua Code for Neovim:\n")
            f.write("=" * 80 + "\n")
            f.write(lua_code)
        
        print(f"ASCII art saved to: {output_file}")
        print("\nPreview (first 10 lines):")
        for i, line in enumerate(ascii_lines[:10]):
            print(line)
        if len(ascii_lines) > 10:
            print("...")
        
        print(f"\nTotal lines: {len(ascii_lines)}")
        print("Copy the Lua code from the output file to your Neovim config!")
        
    else:
        print("Failed to convert image to ASCII art.")

if __name__ == "__main__":
    main()
