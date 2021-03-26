(TeX-add-style-hook
 "robust_sensitive_ate"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "hidelinks" "11pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("cancel" "makeroom") ("titlesec" "md") ("geometry" "margin=1.2in") ("natbib" "authoryear") ("hyperref" "pagebackref=true")))
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art11"
    "setspace"
    "mathpazo"
    "cancel"
    "arabtex"
    "indentfirst"
    "titlesec"
    "xcolor"
    "mwe"
    "lipsum"
    "graphicx"
    "tikz"
    "subcaption"
    "caption"
    "rotating"
    "geometry"
    "natbib"
    "hyperref"
    "amssymb")
   (LaTeX-add-bibliographies
    "/users/oliverlang/bibliography1"))
 :latex)

