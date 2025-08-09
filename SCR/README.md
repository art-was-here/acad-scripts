# AutoCAD LT Script Files (.scr)

This folder contains AutoCAD LT compatible script files converted from the AutoLISP versions. These scripts work with **AutoCAD LT** which does not support AutoLISP.

## How to Use Script Files

### Loading Scripts
1. Type `SCRIPT` command in AutoCAD LT
2. Browse to the `.scr` file you want to run
3. Click **Open** - the script executes immediately

### Alternative: Drag and Drop
- Drag the `.scr` file directly into AutoCAD LT
- The script will execute automatically

## Script Files Overview

### Rotation Scripts (`rotate/` folder)

| Script | Description | Usage |
|--------|-------------|-------|
| `R90.scr` | Rotate 90 degrees | Select objects → Base point |
| `R180.scr` | Rotate 180 degrees | Select objects → Base point |
| `R270.scr` | Rotate 270 degrees | Select objects → Base point |
| `rmatch.scr` | Reference rotation | Select objects → Base point → Reference points |

### Scaling Scripts (`scale/` folder)

| Script | Description | Usage |
|--------|-------------|-------|
| `rsc.scr` | Reference scale | Select objects → Base point → Reference length → New length |
| `scimg.scr` | Basic scaling | Select objects → Base point → Scale factor |

### Hatching Scripts (`hatch/` folder)

| Script | Description | Usage | Notes |
|--------|-------------|-------|-------|
| `fh.scr` | Firecode hatch | Pick internal point | Switch to firecode layer first |
| `fh-layer.scr` | Firecode hatch + layer | Pick internal point | Creates/switches to FIRECODE layer |
| `rh.scr` | Rafter hatch | Pick internal point | Switch to rafter layer first |
| `rh-layer.scr` | Rafter hatch + layer | Pick internal point | Creates/switches to RAFTERS layer |

### Layer Management (`layers/` folder)

| Script | Description | Usage | Notes |
|--------|-------------|-------|-------|
| `a1.scr` | Move to A1 layer | Select objects | Assumes A1-DIMS layer exists |
| `lc.scr` | Conduit lines | Draw lines | Automatically switches to CONDUIT layer |

## Script File Limitations

### What Scripts CAN Do:
- Execute command sequences
- Pause for user input (`\` character)
- Set properties and layers
- Load linetypes and patterns

### What Scripts CANNOT Do:
- Conditional logic (if/then statements)
- Variable calculations
- Dynamic layer detection
- Error handling
- Complex automation

## Key Script Characters

| Character | Meaning |
|-----------|---------|
| `\` | Pause for user input |
| `;` | Enter keypress |
| `^C^C` | Cancel current command |
| ` ` (space) | Same as Enter |

## Usage Tips

### 1. Layer Preparation
For best results, create your standard layers before running scripts:
- `FIRECODE` or `PH-FIRECODE`
- `RAFTERS` or `PH-RAFTERS`
- `CONDUIT` or `PH-CONDUIT`
- `A1-DIMS` or `PH-A1DIMS`

### 2. Linetype Loading
Load required linetypes before using conduit scripts:
```
Command: LINETYPE
Load linetypes: DASHED
```

### 3. Batch Operation
For repetitive tasks, you can:
1. Run the script multiple times
2. Create custom toolbar buttons with script commands
3. Use Action Macros for more complex sequences

## Creating Toolbar Buttons

To create toolbar buttons for these scripts:

1. Right-click toolbar → **Customize**
2. Create **New Button**
3. In macro field, enter: `^C^CSCRIPT;path/to/script.scr;`
4. Replace `path/to/script.scr` with actual path

### Example Toolbar Macros:
```
R90: ^C^CSCRIPT;C:\Scripts\SCR\rotate\R90.scr;
FH:  ^C^CSCRIPT;C:\Scripts\SCR\hatch\fh-layer.scr;
A1:  ^C^CSCRIPT;C:\Scripts\SCR\layers\a1.scr;
LC:  ^C^CSCRIPT;C:\Scripts\SCR\layers\lc.scr;
```

## Comparison with AutoLISP

| Feature | AutoLISP (.lsp) | Script (.scr) |
|---------|-----------------|---------------|
| AutoCAD LT Support | ❌ No | ✅ Yes |
| Conditional Logic | ✅ Yes | ❌ No |
| Layer Detection | ✅ Yes | ❌ No |
| Error Handling | ✅ Yes | ❌ Limited |
| User Interaction | ✅ Advanced | ✅ Basic |
| Ease of Creation | ❌ Complex | ✅ Simple |

## Recommended Workflow

1. **Start with basic scripts** (R90, R180, R270)
2. **Test layer scripts** with existing layers
3. **Use setup scripts** for new drawings
4. **Create toolbar buttons** for frequent tasks
5. **Combine with templates** for standardized workflows

## Support

For AutoCAD full version users, the AutoLISP versions in the `AutoLISP/` folder provide more advanced functionality including:
- Automatic layer detection
- Conditional logic
- Error handling
- Interactive mode switching 