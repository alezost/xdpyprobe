;;; Xdpyprobe --- Check connection to X server DISPLAY

;; Copyright © 2016 Alex Kost <alezost@gmail.com>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This is a GNU Guix development package for xdpyprobe.  To build, run:
;;
;;   guix build -f guix.scm

;;; Code:

(use-modules
 (guix packages)
 (guix git-download)
 (guix licenses)
 (guix build-system gnu)
 (gnu packages autotools)
 (gnu packages man)
 (gnu packages xorg))

(define xdpyprobe-devel
  (let ((commit "968a9408d398f96c003470bc37bd23927143a612"))
    (package
      (name "xdpyprobe")
      (version (string-append "0.1-1." (string-take commit 7)))
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (url "git://github.com/alezost/xdpyprobe.git")
                      (commit commit)))
                (file-name (string-append name "-" version "-checkout"))
                (sha256
                 (base32
                  "168fc8wy5blccjhjlaa71wz20sarwk2j49sc7qb7pqzy3h4jn8vm"))))
      (build-system gnu-build-system)
      (arguments
       '(#:phases
         (modify-phases %standard-phases
           (add-after 'unpack 'patch-configure.ac
             (lambda _
               ;; Man page is generated only "if BUILD_FROM_GIT" (when
               ;; ".git" directory exists).  Make this conditional true.
               (substitute* "configure.ac"
                 (("^(AM_CONDITIONAL\\(\\[BUILD_FROM_GIT\\],).*" all beg)
                  (string-append beg " [true])\n")))))
           (add-after 'patch-configure.ac 'autogen
             (lambda _ (zero? (system* "sh" "autogen.sh")))))))
      (native-inputs
       `(("autoconf" ,autoconf)
         ("automake" ,automake)
         ("help2man" ,help2man)))
      (inputs
       `(("libx11" ,libx11)))
      (home-page "https://github.com/alezost/xdpyprobe")
      (synopsis "Probe X server for connectivity")
      (description
       "Xdpyprobe is a tiny C program whose only purpose is to probe a
connectivity of the X server running on a particular @code{DISPLAY}.")
      (license gpl3+))))

xdpyprobe-devel
