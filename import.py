import re

# Read the locals.tf file
with open('locals.tf', 'r') as file:
    locals_content = file.read()

# Function to find and process all locals blocks
def find_and_process_locals_blocks(content):
    globals_content = 'globals {\n'
    locals_pattern = re.compile(r'locals\s*{([^{}]*(?:{[^{}]*}[^{}]*)*)}', re.DOTALL)
    matches = locals_pattern.findall(content)

    if matches:
        for match in matches:
            globals_content += process_block(match, 1)
        globals_content += '}'
    return globals_content

# Function to process a block of HCL content
def process_block(block, indent_level):
    lines = block.split('\n')
    result = ""
    indent = '  ' * indent_level
    open_braces = 0

    for line in lines:
        stripped_line = line.strip()
        if stripped_line:
            if '{' in stripped_line and '}' not in stripped_line:
                open_braces += stripped_line.count('{')
                result += indent + stripped_line + '\n'
                indent_level += 1
                indent = '  ' * indent_level
            elif '}' in stripped_line and '{' not in stripped_line:
                open_braces -= stripped_line.count('}')
                indent_level -= 1
                indent = '  ' * indent_level
                result += indent + stripped_line + '\n'
            else:
                result += indent + stripped_line + '\n'

    # Ensure all braces are closed properly
    while open_braces > 0:
        indent_level -= 1
        indent = '  ' * indent_level
        result += indent + '}\n'
        open_braces -= 1

    return result

# Process the locals.tf content
globals_content = find_and_process_locals_blocks(locals_content)

# Write the processed content to globals.tm.hcl
with open('globals.tm.hcl', 'w') as file:
    file.write(globals_content)

print("globals.tm.hcl file has been created successfully.")
