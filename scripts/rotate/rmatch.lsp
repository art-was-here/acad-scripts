(defun rmatch (/ obj line base_pt line_data start_pt end_pt line_angle rotation_angle vertex_list)
  (princ "\nSelect object to rotate: ")
  (if (setq obj (car (entsel)))
    (progn
      (princ "\nSpecify base point for rotation: ")
      (if (setq base_pt (getpoint))
        (progn
          (princ "\nSelect line to match angle: ")
          (if (setq line (car (entsel)))
            (progn
              ; Get line entity data
              (setq line_data (entget line))
              
              ; Check entity type and calculate angle accordingly
              (cond
                ; Handle LINE entities
                ((= (cdr (assoc 0 line_data)) "LINE")
                 (progn
                   ; Get start and end points of the line
                   (setq start_pt (cdr (assoc 10 line_data))
                         end_pt (cdr (assoc 11 line_data)))
                   
                   ; Calculate the angle of the line
                   (setq line_angle (angle start_pt end_pt))
                   (setq rotation_angle (rtod line_angle))
                   
                   ; Rotate the object to match the line angle
                   (command "ROTATE" obj "" base_pt line_angle)
                   
                   (princ (strcat "\nObject rotated to match line angle: " (rtos rotation_angle 2 1) " degrees"))
                 )
                )
                
                ; Handle LWPOLYLINE entities
                ((= (cdr (assoc 0 line_data)) "LWPOLYLINE")
                 (progn
                   ; Get the first two vertices of the polyline
                   (setq vertex_list (list))
                   (foreach item line_data
                     (if (= (car item) 10)
                       (setq vertex_list (append vertex_list (list (cdr item))))
                     )
                   )
                   
                   (if (>= (length vertex_list) 2)
                     (progn
                       (setq start_pt (nth 0 vertex_list)
                             end_pt (nth 1 vertex_list))
                       
                       ; Calculate angle between first two vertices
                       (setq line_angle (angle start_pt end_pt))
                       (setq rotation_angle (rtod line_angle))
                       
                       (command "ROTATE" obj "" base_pt line_angle)
                       
                       (princ (strcat "\nObject rotated to match polyline angle: " (rtos rotation_angle 2 1) " degrees"))
                     )
                     (princ "\nPolyline must have at least two vertices.")
                   )
                 )
                )
                
                ; Handle POLYLINE entities
                ((= (cdr (assoc 0 line_data)) "POLYLINE")
                 (progn
                   (princ "\nNote: For POLYLINE entities, using start point and direction.")
                   ; For polylines, we'll use a simplified approach
                   (setq start_pt (cdr (assoc 10 line_data)))
                   (setq end_pt (polar start_pt 0 1)) ; Default to horizontal, user should convert to LWPOLYLINE for better results
                   
                   (setq line_angle 0) ; Default horizontal
                   (setq rotation_angle 0)
                   
                   (command "ROTATE" obj "" base_pt line_angle)
                   
                   (princ "\nObject rotated horizontally. Convert POLYLINE to LWPOLYLINE for accurate angle matching.")
                 )
                )
                
                ; Handle other entity types
                (t
                 (princ "\nSelected entity must be a LINE or LWPOLYLINE for accurate angle matching.")
                )
              )
            )
            (princ "\nNo line selected.")
          )
        )
        (princ "\nNo base point specified.")
      )
    )
    (princ "\nNo object selected.")
  )
  (princ)
) 