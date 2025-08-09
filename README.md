# AutoCAD Scripts Collection

A collection of AutoLISP scripts and AutoCAD LT compatible script files designed to streamline common AutoCAD workflows for architectural, structural, and electrical drawings.

## Quick Start

- **AutoCAD Full Version**: Use scripts in `AutoLISP/` folder (.lsp files)
- **AutoCAD LT**: Use scripts in `SCR/` folder (.scr files)

## Table of Contents

- [Features](#features)
- [Installation](#installation)
  - [AutoLISP Scripts (AutoCAD Full)](#autolisp-scripts-autocad-full)
  - [Script Files (AutoCAD LT)](#script-files-autocad-lt)
- [Scripts Overview](#scripts-overview)
  - [Rotation Scripts](#rotation-scripts)
  - [Scaling Scripts](#scaling-scripts)
  - [Hatching Scripts](#hatching-scripts)
  - [Layer Management Scripts](#layer-management-scripts)
- [Usage](#usage)
- [Layer and Pattern Conventions](#layer-and-pattern-conventions)
- [Contributing](#contributing)
- [License](#license)

## Features

- **Dual Compatibility**: Works with both AutoCAD full and AutoCAD LT
- **Smart Layer Detection**: AutoLISP scripts automatically detect existing project layers
- **Placeholder Naming**: Uses `PH-` prefix for placeholder layers when standards aren't found
- **Non-Intrusive**: Respects existing drawing standards and layer structures
- **User-Friendly**: Simple command names and clear prompts
- **Professional Standards**: Follows industry-standard CAD practices

## Installation

### AutoLISP Scripts (AutoCAD Full)

1. Download or clone this repository
2. In AutoCAD, use the `APPLOAD` command or drag `.lsp` files from `AutoLISP/` folder into AutoCAD
3. Type the command name (e.g., `fh`, `rh`, `a1`) to use the script

### Script Files (AutoCAD LT)

1. Download or clone this repository
2. Use the `SCRIPT` command in AutoCAD LT and browse to `.scr` files in `SCR/` folder
3. Alternatively, drag `.scr` files directly into AutoCAD LT

**Note**: See `SCR/README.md` for detailed AutoCAD LT usage instructions.

### Batch Loading

To load all scripts at once, you can create a startup script or use AutoCAD's startup suite to load the entire collection.

## Scripts Overview

### Rotation Scripts
Located in `rotate/` folder:

#### `R90` - Rotate 90 Degrees
- **File**: `R90.lsp`
- **Usage**: Type `R90` to rotate selected objects 90 degrees
- **Prompts**: Select object → Specify base point

#### `R180` - Rotate 180 Degrees
- **File**: `R180.lsp`
- **Usage**: Type `R180` to rotate selected objects 180 degrees
- **Prompts**: Select object → Specify base point

#### `R270` - Rotate 270 Degrees
- **File**: `R270.lsp`
- **Usage**: Type `R270` to rotate selected objects 270 degrees
- **Prompts**: Select object → Specify base point

#### `rmatch` - Rotate to Match Line Angle
- **File**: `rmatch.lsp`
- **Usage**: Type `rmatch` to rotate an object to match a line's angle
- **Prompts**: Select object → Specify base point → Select reference line
- **Supports**: LINE, LWPOLYLINE entities

### Scaling Scripts
Located in `scale/` folder:

#### `scimg` - Scale Image to Fit Box
- **File**: `scimg.lsp`
- **Usage**: Type `scimg` to scale an image to fit within a container
- **Workflow**: Select image → Select containing box → Automatic scaling and centering

#### `rsc` - Reference Scale
- **File**: `rsc.lsp`
- **Usage**: Type `rsc` for simplified reference scaling
- **Workflow**: Select object → Base point → Reference length (2 points) → New length
- **Benefit**: Eliminates manual "R" and Enter keypresses

### Hatching Scripts
Located in `hatch/` folder:

#### `fh` - Firecode Hatch
- **File**: `fh.lsp`
- **Usage**: Type `fh` for firecode hatching
- **Modes**: 
  - **K Mode (Default)**: Pick internal point to hatch
  - **S Mode**: Select object to hatch
- **Layer Detection**: Searches for FIRECODE, FIRE-CODE, FIRE_CODE, etc.
- **Pattern Detection**: Searches for FIRECODE, FIRE, ANSI37, ANSI31 patterns

#### `rh` - Rafter Hatch
- **File**: `rh.lsp`
- **Usage**: Type `rh` for rafter/wood hatching
- **Modes**: Same K/S switching as `fh`
- **Layer Detection**: Searches for RAFTERS, RAFTER, STRUCT-RAFTERS, etc.
- **Pattern Detection**: Searches for RAFTER, WOOD, LUMBER, AR-RSHKE, ANSI33 patterns

### Layer Management Scripts
Located in `layers/` folder:

#### `a1` - Move to A1 Dimensions Layer
- **File**: `a1.lsp`
- **Usage**: Type `a1` to move objects to A1 dimensions layer
- **Layer Detection**: Searches for A1-DIMS, A1-DIMENSIONS, A1_DIMS, etc.
- **Fallback**: Creates PH-A1DIMS if no existing layer found

#### `lc` - Line Conduit
- **File**: `lc.lsp`
- **Usage**: Type `lc` to draw lines on conduit layer
- **Layer Detection**: Searches for CONDUIT, E-CONDUIT, ELEC-CONDUIT, etc.
- **Properties**: Uses DASHED linetype and magenta color
- **Behavior**: Temporarily switches to conduit layer, restores settings after drawing

## Usage

### Basic Usage
```
Command: [script-name]
```

### Example Workflows

**Firecode Hatching:**
```
Command: fh
Pick internal point to hatch [S for Select object mode]: [click inside area]
Firecode hatch applied.
```

**Reference Scaling:**
```
Command: rsc
Select image to scale by reference: [click image]
Specify base point: [click base point]
Specify first point of reference length: [click point 1]
Specify second point of reference length: [click point 2]
Specify new length: [click new endpoint]
```

**Layer Assignment:**
```
Command: a1
Select objects to move to A1 dimensions layer: [select objects]
3 object(s) moved to layer A1-DIMS
```

## Layer and Pattern Conventions

### Smart Detection
Scripts search for existing layers and patterns in this priority order:

**Firecode Layers**: FIRECODE → FIRE-CODE → FIRE_CODE → FIRERATING → FIRE-RATING
**Rafter Layers**: RAFTERS → RAFTER → STRUCT-RAFTERS → STRUCTURE-RAFTERS → FRAMING-RAFTERS → WOOD-RAFTERS
**Conduit Layers**: CONDUIT → E-CONDUIT → ELEC-CONDUIT → ELECTRICAL-CONDUIT
**A1 Dimension Layers**: A1-DIMS → A1-DIMENSIONS → A1_DIMS → DIMS-A1 → DIMENSIONS-A1

### Placeholder Naming
When no existing layers/patterns are found, scripts use placeholder names:
- Format: `PH-[Description]`
- Examples: `PH-FIRECODE`, `PH-RAFTERS`, `PH-CONDUIT`, `PH-A1DIMS`

### Fallback Patterns
- Firecode: Uses ANSI31 if no specific pattern found
- Rafter: Uses ANSI33 if no specific pattern found

## Contributing

1. Fork the repository
2. Create a feature branch
3. Follow the existing code style and conventions
4. Test scripts thoroughly
5. Submit a pull request

### Coding Guidelines
- Use descriptive variable names
- Include comments explaining logic
- Follow placeholder naming convention (`PH-`)
- Respect existing layer structures
- Provide clear user feedback

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For issues, suggestions, or contributions, please open an issue on the project repository.

---

**Note**: These scripts are designed to work with standard AutoCAD installations and follow industry-standard CAD practices. Always test scripts in a non-production environment before using in critical projects. 