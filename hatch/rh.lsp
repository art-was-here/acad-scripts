(defun rh (/ mode hatch_pattern hatch_scale rafter_layer done pt obj kword)
  ; Check if a rafter layer already exists (try common variations)
  (cond
    ((tblsearch "LAYER" "RAFTERS") (setq rafter_layer "RAFTERS"))
    ((tblsearch "LAYER" "RAFTER") (setq rafter_layer "RAFTER"))
    ((tblsearch "LAYER" "STRUCT-RAFTERS") (setq rafter_layer "STRUCT-RAFTERS"))
    ((tblsearch "LAYER" "STRUCTURE-RAFTERS") (setq rafter_layer "STRUCTURE-RAFTERS"))
    ((tblsearch "LAYER" "FRAMING-RAFTERS") (setq rafter_layer "FRAMING-RAFTERS"))
    ((tblsearch "LAYER" "WOOD-RAFTERS") (setq rafter_layer "WOOD-RAFTERS"))
    (t (setq rafter_layer "PH-RAFTERS")) ; Use placeholder if none found
  )
  
  ; Check if a rafter hatch pattern exists (try common variations)
  (cond
    ((tblsearch "HATCH" "RAFTER") (setq hatch_pattern "RAFTER"))
    ((tblsearch "HATCH" "RAFTERS") (setq hatch_pattern "RAFTERS"))
    ((tblsearch "HATCH" "WOOD") (setq hatch_pattern "WOOD"))
    ((tblsearch "HATCH" "LUMBER") (setq hatch_pattern "LUMBER"))
    ((tblsearch "HATCH" "AR-RSHKE") (setq hatch_pattern "AR-RSHKE"))
    ((tblsearch "HATCH" "ANSI33") (setq hatch_pattern "ANSI33"))
    (t (setq hatch_pattern "PH-RAFTER")) ; Use placeholder pattern name
  )
  
  ; Set default values
  (setq hatch_scale 1.0             ; Default hatch scale
        mode "K"                    ; Start in K mode (pick internal point)
        done nil)
  
  ; Only create layer if using placeholder name
  (if (and (= rafter_layer "PH-RAFTERS") (not (tblsearch "LAYER" rafter_layer)))
    (progn
      (command "LAYER" "N" rafter_layer "")
      (princ (strcat "\nUsing placeholder layer: " rafter_layer))
    )
  )
  
  ; Set current layer to rafter
  (setvar "CLAYER" rafter_layer)
  
  (princ "\nRafter Hatch - Starting in pick point mode")
  (princ (strcat "\nUsing layer: " rafter_layer " | Pattern: " hatch_pattern))
  
  ; Main loop
  (while (not done)
    (if (= mode "K")
      ; K mode - pick internal point
      (progn
        (initget "S")
        (setq pt (getpoint "\nPick internal point to hatch [S for Select object mode]: "))
        (cond
          ((= pt "S")
           (setq mode "S")
           (princ "\nSwitched to Select object mode")
          )
          ((and pt (listp pt))
           ; Use ANSI33 as fallback if placeholder pattern (good for wood/lumber)
           (if (= hatch_pattern "PH-RAFTER")
             (command "HATCH" "P" "ANSI33" hatch_scale "0" pt "")
             (command "HATCH" "P" hatch_pattern hatch_scale "0" pt "")
           )
           (princ "\nRafter hatch applied.")
           (setq done t)
          )
          (t
           (princ "\nNo point selected or invalid input.")
           (setq done t)
          )
        )
      )
      ; S mode - select object
      (progn
        (initget "K")
        (setq obj (entsel "\nSelect object to hatch [K for pick point mode]: "))
        (cond
          ((= obj "K")
           (setq mode "K")
           (princ "\nSwitched to pick point mode")
          )
          ((and obj (listp obj))
           ; Use ANSI33 as fallback if placeholder pattern (good for wood/lumber)
           (if (= hatch_pattern "PH-RAFTER")
             (command "HATCH" "S" (car obj) "" "P" "ANSI33" hatch_scale "0")
             (command "HATCH" "S" (car obj) "" "P" hatch_pattern hatch_scale "0")
           )
           (princ "\nRafter hatch applied to selected object.")
           (setq done t)
          )
          (t
           (princ "\nNo object selected or invalid input.")
           (setq done t)
          )
        )
      )
    )
  )
  
  (princ)
) 