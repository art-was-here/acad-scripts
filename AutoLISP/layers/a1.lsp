(defun a1 (/ a1_layer ss obj_count)
  ; Check if an A1 dimensions layer already exists (try common variations)
  (cond
    ((tblsearch "LAYER" "A1-DIMS") (setq a1_layer "A1-DIMS"))
    ((tblsearch "LAYER" "A1-DIMENSIONS") (setq a1_layer "A1-DIMENSIONS"))
    ((tblsearch "LAYER" "A1_DIMS") (setq a1_layer "A1_DIMS"))
    ((tblsearch "LAYER" "DIMS-A1") (setq a1_layer "DIMS-A1"))
    ((tblsearch "LAYER" "DIMENSIONS-A1") (setq a1_layer "DIMENSIONS-A1"))
    (t (setq a1_layer "PH-A1DIMS")) ; Use placeholder if none found
  )
  
  ; Only create layer if using placeholder name
  (if (and (= a1_layer "PH-A1DIMS") (not (tblsearch "LAYER" a1_layer)))
    (progn
      (command "LAYER" "N" a1_layer "C" "3" a1_layer "") ; Create layer with green color (color 3)
      (princ (strcat "\nUsing placeholder layer: " a1_layer))
    )
  )
  
  ; Prompt user to select objects
  (princ "\nSelect objects to move to A1 dimensions layer: ")
  (if (setq ss (ssget))
    (progn
      ; Get the number of selected objects
      (setq obj_count (sslength ss))
      
      ; Move all selected objects to the A1 layer
      (command "CHANGE" ss "" "P" "LA" a1_layer "")
      
      (princ (strcat "\n" (itoa obj_count) " object(s) moved to layer " a1_layer))
    )
    (princ "\nNo objects selected.")
  )
  
  (princ)
) 