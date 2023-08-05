#include .\ime\IMEv2.ahk

~Esc::IME_SET(0)
~^[::IME_SET(0)
~vk1C::IME_SET(1)
~vk1D::IME_SET(0)

vk1D & [::Send "{Esc}"
vk1D & Tab::AltTab
vk1D & Up::Send "{PgUp}"
vk1D & Down::Send "{PgDn}"
vk1D & Left::Send "{Home}"
vk1D & Right::Send "{End}"
vk1D & 1::Send "{F1}"
vk1D & 2::Send "{F2}"
vk1D & 3::Send "{F3}"
vk1D & 4::Send "{F4}"
vk1D & 5::Send "{F5}"
vk1D & 6::Send "{F6}"
vk1D & 7::Send "{F7}"
vk1D & 8::Send "{F8}"
vk1D & 9::Send "{F9}"
vk1D & 0::Send "{F10}"
vk1D & a::Send "^a"
vk1D & b::Send "^b"
vk1D & c::Send "^c"
vk1D & d::Send "^d"
vk1D & e::Send "^e"
vk1D & f::Send "^f"
vk1D & g::Send "^g"
vk1D & h::Send "^h"
vk1D & i::Send "^i"
vk1D & j::Send "^j"
vk1D & k::Send "^k"
vk1D & l::Send "^l"
vk1D & m::Send "^m"
vk1D & n::Send "^n"
vk1D & o::Send "^o"
vk1D & p::Send "^p"
vk1D & q::Send "^q"
vk1D & r::Send "^r"
vk1D & s::Send "^s"
vk1D & t::Send "^t"
vk1D & u::Send "^u"
vk1D & v::Send "^v"
vk1D & w::Send "^w"
vk1D & x::Send "^x"
vk1D & y::Send "^y"
vk1D & z::Send "^z"

#HotIf WinActive("ahk_exe OUTLOOK.EXE") and WinActive("ahk_class rctrl_renwnd32") and WinActive("- Outlook")
  f::HandleOutlook("^f", "f")
  j::HandleOutlook("{Down}", "j")
  +j::HandleOutlook("+{Down}", "+j")
  k::HandleOutlook("{Up}", "k")
  +k::HandleOutlook("+{Up}", "+k")
  h::HandleOutlook("{Left}", "h")
  l::HandleOutlook("{Right}", "l")
  i::HandleOutlook("^q", "i")
  n::HandleOutlook("^n", "n")
  o::HandleOutlook("+{Enter}", "o")
  r::HandleOutlook("^r", "r")
  +r::HandleOutlook("^+r", "+r")
  /::HandleOutlook("^e", "/")
  ^b::HandleOutlook("+{Space}", "^b")
  ^f::HandleOutlook("{space}", "^f")
  +g::HandleOutlook("{End}", "+g")
  :*b0:dd::HandleOutlook("{Del}", "dd")
  :*b0:gg::HandleOutlook("{Home}", "gg")
  :*b0:gy::HandleOutlook("^y", "gy")
#HotIf

#HotIf WinActive("ahk_exe OUTLOOK.EXE") and WinActive("ahk_class #32770")
  j::HandleOutlook("{Down}", "j")
  +j::HandleOutlook("+{Down}", "+j")
  k::HandleOutlook("{Up}", "k")
  +k::HandleOutlook("+{Up}", "+k")
  h::HandleOutlook("{Left}", "h")
  l::HandleOutlook("{Right}", "l")
  ^b::HandleOutlook("{PgUp}", "^b")
  ^f::HandleOutlook("{PgDn}", "^f")
  ^m::HandleOutlook("+{Enter}", "^m")
  :*b0:gg::HandleOutlook("{Home}", "gg")
  +g::HandleOutlook("{End}", "+g")
#HotIf

HandleOutlook(specialKey, normalKey)
{
  if (WinActive("- Outlook") and WinActive("ahk_class rctrl_renwnd32")) or (WinActive("ahk_exe OUTLOOK.EXE") and WinActive("ahk_class #32770"))
  {
    currentCtrl := ControlGetClassNN(ControlGetFocus("A"))
    ctrlList := ["Acrobat Preview Window1", "AfxWndW5", "AfxWndW6", "EXCEL71", "MsoCommandBar1", "OlkPicturePreviewer1", "paneClassDC1", "OutlookGrid1", "OutlookGrid2", "RichEdit20WPT2", "RichEdit20WPT4", "RichEdit20WPT5", "RICHEDIT50W1", "SUPERGRID2", "SUPERGRID1", "_WwG1", "SysTreeView321"]
    For ctrl in ctrlList
    {
      if currentCtrl = ctrl
      {
        Send specialKey
        return
      }
    }
    Send normalKey
  }
  return
}
