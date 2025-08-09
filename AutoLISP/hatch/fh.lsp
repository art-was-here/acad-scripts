(defun fh (/ mode hatch_pattern hatch_scale firecode_layer done pt obj kword)
  ; Check if a firecode layer already exists (try common variations)
  (cond
    ((tblsearch "LAYER" "FIRECODE") (setq firecode_layer "FIRECODE"))
    ((tblsearch "LAYER" "FIRE-CODE") (setq firecode_layer "FIRE-CODE"))
    ((tblsearch "LAYER" "FIRE_CODE") (setq firecode_layer "FIRE_CODE"))
    ((tblsearch "LAYER" "FIRERATING") (setq firecode_layer "FIRERATING"))
    ((tblsearch "LAYER" "FIRE-RATING") (setq firecode_layer "FIRE-RATING"))
    (t (setq firecode_layer "PH-FIRECODE")) ; Use placeholder if none found
  )
  
  ; Check if a firecode hatch pattern exists (try common variations)
  (cond
    ((tblsearch "HATCH" "FIRECODE") (setq hatch_pattern "FIRECODE"))
    ((tblsearch "HATCH" "FIRE") (setq hatch_pattern "FIRE"))
    ((tblsearch "HATCH" "ANSI37") (setq hatch_pattern "ANSI37"))
    ((tblsearch "HATCH" "ANSI31") (setq hatch_pattern "ANSI31"))
    (t (setq hatch_pattern "PH-FIRECODE")) ; Use placeholder pattern name
  )
  
  ; Set default values
  (setq hatch_scale 1.0             ; Default hatch scale
        mode "K"                    ; Start in K mode (pick internal point)
        done nil)
  
  ; Only create layer if using placeholder name
  (if (and (= firecode_layer "PH-FIRECODE") (not (tblsearch "LAYER" firecode_layer)))
    (progn
      (command "LAYER" "N" firecode_layer "")
      (princ (strcat "\nUsing placeholder layer: " firecode_layer))
    )
  )
  
  ; Set current layer to firecode
  (setvar "CLAYER" firecode_layer)
  
  (princ "\nFirecode Hatch - Starting in pick point mode")
  (princ (strcat "\nUsing layer: " firecode_layer " | Pattern: " hatch_pattern))
  
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
           ; Use ANSI31 as fallback if placeholder pattern
           (if (= hatch_pattern "PH-FIRECODE")
             (command "HATCH" "P" "ANSI31" hatch_scale "0" pt "")
             (command "HATCH" "P" hatch_pattern hatch_scale "0" pt "")
           )
           (princ "\nFirecode hatch applied.")
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
           ; Use ANSI31 as fallback if placeholder pattern
           (if (= hatch_pattern "PH-FIRECODE")
             (command "HATCH" "S" (car obj) "" "P" "ANSI31" hatch_scale "0")
             (command "HATCH" "S" (car obj) "" "P" hatch_pattern hatch_scale "0")
           )
           (princ "\nFirecode hatch applied to selected object.")
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