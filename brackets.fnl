(fn brackets [n]
  ((fn brackets-impl [left right str]
      (when (= left right 0)
        (print str))
      (when (> left 0)
        (brackets-impl (- left 1) (+ right 1) (.. str "[")))
      (when (> right 0)
        (brackets-impl left (- right 1) (.. str "]"))))
   n 0 ""
   arr))

(local n (if (= (# arg) 1)
             (tonumber (. arg 1))
             10))
(brackets n)
