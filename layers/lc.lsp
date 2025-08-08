(defun lc (/ conduit_layer conduit_linetype conduit_color original_layer original_linetype original_color)
  ; Define conduit layer properties - use placeholder if no existing conduit layer
  (setq conduit_layer "PH-CONDUIT"
        conduit_linetype "DASHED"      ; Typical linetype for conduit
        conduit_color "6")             ; Magenta color (6) - common for conduit
  
  ; Check if a conduit layer already exists (try common variations)
  (cond
    ((tblsearch "LAYER" "CONDUIT") (setq conduit_layer "CONDUIT"))
    ((tblsearch "LAYER" "E-CONDUIT") (setq conduit_layer "E-CONDUIT"))
    ((tblsearch "LAYER" "ELEC-CONDUIT") (setq conduit_layer "ELEC-CONDUIT"))
    ((tblsearch "LAYER" "ELECTRICAL-CONDUIT") (setq conduit_layer "ELECTRICAL-CONDUIT"))
    (t (setq conduit_layer "PH-CONDUIT")) ; Use placeholder if none found
  )
  
  ; Store current settings to restore later
  (setq original_layer (getvar "CLAYER")
        original_linetype (getvar "CELTYPE")
        original_color (getvar "CECOLOR"))
  
  ; Only create layer if using placeholder name
  (if (and (= conduit_layer "PH-CONDUIT") (not (tblsearch "LAYER" conduit_layer)))
    (progn
      (command "LAYER" "N" conduit_layer "C" conduit_color conduit_layer "")
      (princ (strcat "\nUsing placeholder layer: " conduit_layer))
    )
  )
  
  ; Load DASHED linetype if not already loaded
  (if (not (tblsearch "LTYPE" conduit_linetype))
    (progn
      (command "LINETYPE" "L" conduit_linetype "ACAD.LIN" "")
      (princ (strcat "\nLoaded linetype: " conduit_linetype))
    )
  )
  
  ; Switch to conduit layer
  (setvar "CLAYER" conduit_layer)
  (setvar "CELTYPE" conduit_linetype)
  (setvar "CECOLOR" conduit_color)
  
  (princ (strcat "\nConduit Line Mode - Drawing on " conduit_layer " layer"))
  (princ "\nLinetype: DASHED | Color: Magenta")
  
  ; Start the LINE command
  (command "LINE")
  
  ; Restore original layer and properties
  (setvar "CLAYER" original_layer)
  (setvar "CELTYPE" original_linetype)
  (setvar "CECOLOR" original_color)
  
  (princ "\nConduit lines drawn. Layer settings restored.")
  (princ)
) 