#Include IME.ahk

~Esc::IME_SET(0)
~^[::IME_SET(0)

#IfWinActive ahk_exe EXCEL.EXE
    ^u::
        Send {F2}
        Return
#IfWinActive
