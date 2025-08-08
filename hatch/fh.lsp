(defun fh (/ mode hatch_pattern hatch_scale firecode_layer done pt obj kword)
  ; Set default values
  (setq hatch_pattern "ANSI31"      ; Default hatch pattern for firecode
        hatch_scale 1.0             ; Default hatch scale
        firecode_layer "FIRECODE"   ; Target layer name
        mode "K"                    ; Start in K mode (pick internal point)
        done nil)
  
  ; Ensure firecode layer exists
  (if (not (tblsearch "LAYER" firecode_layer))
    (progn
      (command "LAYER" "N" firecode_layer "")
      (princ (strcat "\nCreated layer: " firecode_layer))
    )
  )
  
  ; Set current layer to firecode
  (setvar "CLAYER" firecode_layer)
  
  (princ "\nFirecode Hatch - Starting in pick point mode")
  
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
           (command "HATCH" "P" hatch_pattern hatch_scale "0" pt "")
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
           (command "HATCH" "S" (car obj) "" "P" hatch_pattern hatch_scale "0")
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