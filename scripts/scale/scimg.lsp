(defun scimg (/ img box img_data box_data img_corners box_corners img_min img_max box_min box_max img_width img_height box_width box_height scale_x scale_y scale_factor img_center box_center move_vector)
  (princ "\nSelect image to scale and fit: ")
  (if (setq img (car (entsel)))
    (progn
      ; Verify it's an image
      (setq img_data (entget img))
      (if (= (cdr (assoc 0 img_data)) "IMAGE")
        (progn
          (princ "\nSelect containing box (rectangle/polyline): ")
          (if (setq box (car (entsel)))
            (progn
              (setq box_data (entget box))
              ; Check if it's a rectangle, polyline, or other closed shape
              (if (or (= (cdr (assoc 0 box_data)) "LWPOLYLINE")
                      (= (cdr (assoc 0 box_data)) "POLYLINE")
                      (= (cdr (assoc 0 box_data)) "RECTANGLE"))
                (progn
                  ; Get extents of both objects
                  (setq img_corners (geomcalc img "EXTENTS"))
                  (setq box_corners (geomcalc box "EXTENTS"))
                  
                  (if (and img_corners box_corners)
                    (progn
                      ; Extract min and max points for image
                      (setq img_min (car img_corners)
                            img_max (cadr img_corners))
                      
                      ; Extract min and max points for box
                      (setq box_min (car box_corners)
                            box_max (cadr box_corners))
                      
                      ; Calculate dimensions
                      (setq img_width (- (car img_max) (car img_min))
                            img_height (- (cadr img_max) (cadr img_min))
                            box_width (- (car box_max) (car box_min))
                            box_height (- (cadr box_max) (cadr box_min)))
                      
                      ; Calculate scale factors
                      (setq scale_x (/ box_width img_width)
                            scale_y (/ box_height img_height))
                      
                      ; Use smaller scale factor to fit within box
                      (setq scale_factor (min scale_x scale_y))
                      
                      ; Calculate centers
                      (setq img_center (list (/ (+ (car img_min) (car img_max)) 2.0)
                                           (/ (+ (cadr img_min) (cadr img_max)) 2.0))
                            box_center (list (/ (+ (car box_min) (car box_max)) 2.0)
                                           (/ (+ (cadr box_min) (cadr box_max)) 2.0)))
                      
                      ; Scale the image first (from its center)
                      (command "SCALE" img "" img_center scale_factor)
                      
                      ; Calculate move vector (difference between centers)
                      (setq move_vector (list (- (car box_center) (car img_center))
                                            (- (cadr box_center) (cadr img_center))))
                      
                      ; Move the scaled image to center it in the box
                      (command "MOVE" img "" img_center box_center)
                      
                      (princ (strcat "\nImage scaled by " (rtos scale_factor 2 4) " and centered in box."))
                    )
                    (princ "\nCould not determine object extents. Make sure both objects are valid.")
                  )
                )
                (princ "\nSelected box must be a rectangle, polyline, or similar closed shape.")
              )
            )
            (princ "\nNo containing box selected.")
          )
        )
        (princ "\nFirst selection must be an image.")
      )
    )
    (princ "\nNo image selected.")
  )
  (princ)
) 