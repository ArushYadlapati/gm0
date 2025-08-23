# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Repository Overview

Game Manual 0 (gm0) is a comprehensive documentation repository for FTC (FIRST Tech Challenge) teams. It's built using Sphinx documentation generator with reStructuredText source files, producing both HTML and PDF outputs. This is a documentation-heavy project focused on educational content rather than application code.

## Architecture

### Documentation Structure
- **Source files**: All documentation is in `source/docs/` organized by topic areas:
  - `being-a-team/` - Team organization and collaboration
  - `design-skills/` - CAD and design processes  
  - `hardware-components/` - Physical components and tools
  - `common-mechanisms/` - Drivetrains, arms, intakes, etc.
  - `custom-manufacturing/` - 3D printing and machining
  - `power-and-electronics/` - Control systems, motors, sensors
  - `software/` - Programming guides
  - `awards/` - Competition awards information
  - `appendix/` - Glossary and vendor information

### Build System
- **Sphinx configuration**: `source/conf.py` contains comprehensive Sphinx settings
- **Theme**: Uses Furo theme with custom styling and logos
- **Extensions**: Includes GraphViz, MathJax, design components, and custom image handling
- **Custom extensions**: `source/_extensions/default_image_settings.py` handles automatic image sizing and centering

### Content Format
- **Primary format**: reStructuredText (.rst files)
- **Special features**: Custom roles and directives, grid layouts, tabbed content
- **Images**: Automatically centered and sized via custom extension
- **Cross-references**: Extensive internal linking between sections

## Development Commands

### Setup
```bash
# Install Python dependencies
python3 -m pip install -r source/requirements.txt

# Install system dependencies (macOS with Homebrew)
brew install graphviz

# For PDF generation, install LaTeX
brew install --cask mactex
```

### Building Documentation
```bash
# Build HTML version (most common for development)
make html

# Build PDF version
make latexpdf

# View all available build targets
make help
```

### Development Workflow
```bash
# Start development server with auto-rebuild on file changes
make autobuild
# Serves at http://127.0.0.1:8000 with live reload

# Lint documentation for style issues
make lint

# Windows-specific linting (ignores CRLF line ending errors)
make winlint

# Check all external links
make linkcheck
```

### Quality Checks
```bash
# Run linting (checks reStructuredText formatting)
make lint

# Check for broken external links
make linkcheck

# Check redirects (requires git main branch)
make rediraffecheckdiff
```

## File Organization

### Key Configuration Files
- `source/conf.py` - Main Sphinx configuration with theme, extensions, and build settings
- `source/requirements.txt` - Python dependencies for building documentation
- `Makefile` - Build targets and development commands
- `source/redirects.txt` - URL redirect mappings for moved content

### Content Structure
- `source/index.rst` - Main landing page with grid of section cards
- `source/docs/` - All documentation content organized by subject
- `source/_static/` - Images, CSS, and other static assets
- `source/_templates/` - Custom Sphinx templates
- `source/_extensions/` - Custom Sphinx extensions

### Build Outputs
- `build/html/` - Generated HTML documentation
- `build/latex/` - Generated LaTeX files and PDF output
- `build/linkcheck/` - Link checking results

## Development Notes

### Content Editing
- All content is written in reStructuredText format
- Images are automatically centered and sized via custom extension
- Use grid layouts for card-based content organization
- Cross-reference other sections using `:doc:` role

### Link Management
- External links that frequently cause issues are ignored in `source/conf.py` linkcheck_ignore
- Redirects for moved content are managed in `source/redirects.txt`
- Link checking is configured with timeouts and retry limits

### Theme Customization
- Uses Furo theme with custom light/dark logos
- Custom CSS variables for colors and fonts
- Favicon handling supports both light and dark mode preferences

### CI/CD Pipeline
The repository includes comprehensive GitHub Actions workflows:
- HTML and PDF build verification
- Link checking
- Documentation linting
- Spelling checks
- Redirect validation
- Unicode character validation

### Performance Considerations
- Link checking uses single worker to avoid rate limiting
- Custom image extension optimizes image loading
- OpenGraph meta tags configured for social sharing
