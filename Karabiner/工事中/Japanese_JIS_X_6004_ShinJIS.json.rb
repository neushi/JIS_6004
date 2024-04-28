#!/usr/bin/env ruby

# You can generate json by executing the following command on Terminal.
#
# $ ruby ./japanese_JIS_X_6004.json.rb
#

require "json"
require_relative "../lib/karabiner.rb"

NON_VIRTUAL_FROM_MODIFIERS =["caps_lock","left_command","left_control","left_option","left_shift", "right_command","right_control","right_option","right_shift","fn","command", "control","option","shift","left_alt","left_gui","right_alt","right_gui","any"]
VIRTUAL_FROM_MODIFIERS = ["spacebar"]

OYAYUBI_SHIFT_ON = "spacebar_on"

OYAYUBI_SHIFT_CONDITIONS = [{
                                      "type" => "variable_if",
                                      "name" => OYAYUBI_SHIFT_ON,
                                      "value" => 1,
                            }]

JIS_KEYBOARD_CONDITIONS = [{
  "type" => "keyboard_type_if",
  "keyboard_types" => ["jis"]
}]
ANSI_KEYBOARD_CONDITIONS = [{
  "type" => "keyboard_type_if",
  "keyboard_types" => ["ansi"]
}]

BASIC_CONDITIONS = [
  Karabiner.input_source_if([
                              {
                                "input_source_id" => "com.apple.inputmethod.Kotoeri.KanaTyping.Japanese",
                              },
                            ]),
  Karabiner.frontmost_application_unless(["loginwindow"]),
]

SHIN_JIS_MAP = {
  # 打ちたい文字列 => [実際に打つ(SHIN-JIS +α における)キーの組み合わせs] 　("from":)
  # "string you want to get" => [["keyCode", [modifiers]],...]
  # apple製の古いキーボードで打てないので、"right_shift"は使わない
  ## かな文字 ######################################
  "そ" => [["q", []]],
  "け" => [["w", []]],
  "せ" => [["e", []]],
  "て" => [["r", []]],
  "ょ" => [["t", []]],
  "つ" => [["y", []]],
  "ん" => [["u", []]],
  "の" => [["i", []]],
  "を" => [["o", []]],
  "り" => [["p", []]],
  "ち" => [["open_bracket", []]],
  "は" => [["a", []]],
  "か" => [["s", []]],
  "し" => [["d", []]],
  "と" => [["f", []]],
  "た" => [["g", []]],
  "く" => [["h", []]],
  "う" => [["j", []]],
  "い" => [["k", []]],
  "゛" => [["l", []]],
  "き" => [["semicolon", []]],
  "な" => [["quote", []]],
  "す" => [["z", []]],
  "こ" => [["x", []]],
  "に" => [["c", []]],
  "さ" => [["v", []]],
  "あ" => [["b", []]],
  "っ" => [["n", []]],
  "る" => [["m", []]],
  "、" => [["comma", []]],
  "。" => [["period", []]],
  "れ" => [["slash", []]],
  "ぁ" => [["q", ["spacebar"]]],
  "゜" => [["w", ["spacebar"]]],
  "ほ" => [["e", ["spacebar"]]],
  "ふ" => [["r", ["spacebar"]]],
  "め" => [["t", ["spacebar"]]],
  "ひ" => [["y", ["spacebar"]]],
  "え" => [["u", ["spacebar"]]],
  "み" => [["i", ["spacebar"]]],
  "や" => [["o", ["spacebar"]]],
  "ぬ" => [["p", ["spacebar"]]],
  "「" => [["open_bracket", ["spacebar"]]],
  "ぃ" => [["a", ["spacebar"]]],
  "へ" => [["s", ["spacebar"]]],
  "ら" => [["d", ["spacebar"]]],
  "ゅ" => [["f", ["spacebar"]]],
  "よ" => [["g", ["spacebar"]]],
  "ま" => [["h", ["spacebar"]]],
  "お" => [["j", ["spacebar"]]],
  "も" => [["k", ["spacebar"]]],
  "わ" => [["l", ["spacebar"]]],
  "ゆ" => [["semicolon", ["spacebar"]]],
  "」" => [["quote", ["spacebar"]]],
  "ぅ" => [["z", ["spacebar"]]],
  "ぇ" => [["x", ["spacebar"]]],
  "ぉ" => [["c", ["spacebar"]]],
  "ね" => [["v", ["spacebar"]]],
  "ゃ" => [["b", ["spacebar"]]],
  "む" => [["n", ["spacebar"]]],
  "ろ" => [["m", ["spacebar"]]],
  "・" => [["comma", ["spacebar"]]],
  "ー" => [["period", ["spacebar"]]],
## 数字キー（１２３、、、０）を半角数字に変更
  "1" => [["1", []], ["1", ["shift"]]],
  "2" => [["2", []], ["2", ["shift"]]],
  "3" => [["3", []], ["3", ["shift"]]],
  "4" => [["4", []], ["4", ["shift"]]],
  "5" => [["5", []], ["5", ["shift"]]],
  "6" => [["6", []], ["6", ["shift"]]],
  "7" => [["7", []], ["7", ["shift"]]],
  "8" => [["8", []], ["8", ["shift"]]],
  "9" => [["9", []], ["9", ["shift"]]],
  "0" => [["0", []], ["0", ["shift"]]],
## JISキーボードのキートップに書かれている文字を半角で入力する。
"-" => [["hyphen", ["shift"]]],
"^" => [["equal_sign", ["shift"]]],
"¥" => [["international3", ["shift"]]],
"q" => [["q", ["shift"]]],
"w" => [["w", ["shift"]]],
"e" => [["e", ["shift"]]],
"r" => [["r", ["shift"]]],
"t" => [["t", ["shift"]]],
"y" => [["y", ["shift"]]],
"u" => [["u", ["shift"]]],
"i" => [["i", ["shift"]]],
"o" => [["o", ["shift"]]],
"p" => [["p", ["shift"]]],
"@" => [["open_bracket", ["shift"]]],
"[" => [["close_bracket", ["shift"]]],
"a" => [["a", ["shift"]]],
"s" => [["s", ["shift"]]],
"d" => [["d", ["shift"]]],
"f" => [["f", ["shift"]]],
"g" => [["g", ["shift"]]],
"h" => [["h", ["shift"]]],
"j" => [["j", ["shift"]]],
"k" => [["k", ["shift"]]],
"l" => [["l", ["shift"]]],
";" => [["semicolon", ["shift"]]],
":" => [["quote", ["shift"]]],
"]" => [["non_us_pound", ["shift"]]],
"z" => [["z", ["shift"]]],
"x" => [["x", ["shift"]]],
"c" => [["c", ["shift"]]],
"v" => [["v", ["shift"]]],
"b" => [["b", ["shift"]]],
"n" => [["n", ["shift"]]],
"m" => [["m", ["shift"]]],
"," => [["comma", ["shift"]]],
"." => [["period", ["shift"]]],
"/" => [["slash", ["shift"]]],
"!" => [["1", ["shift","spacebar"]],["1", ["spacebar"]]],
"double_quote" => [["2", ["shift","spacebar"]]],
"#" => [["3", ["shift","spacebar"]]],
"$" => [["4", ["shift","spacebar"]]],
"%" => [["5", ["shift","spacebar"]]],
"&" => [["6", ["shift","spacebar"]]],
"quote" => [["7", ["shift","spacebar"]]],
"(" => [["8", ["shift","spacebar"]]],
")" => [["9", ["shift","spacebar"]]],
"=" => [["hyphen", ["shift","spacebar"]]],
"~" => [["equal_sign", ["shift","spacebar"]]],
"|" => [["international3", ["shift","spacebar"]]],
"Q" => [["q", ["shift","spacebar"]]],
"W" => [["w", ["shift","spacebar"]]],
"E" => [["e", ["shift","spacebar"]]],
"R" => [["r", ["shift","spacebar"]]],
"T" => [["t", ["shift","spacebar"]]],
"Y" => [["y", ["shift","spacebar"]]],
"U" => [["u", ["shift","spacebar"]]],
"I" => [["i", ["shift","spacebar"]]],
"O" => [["o", ["shift","spacebar"]]],
"P" => [["p", ["shift","spacebar"]]],
"`" => [["open_bracket", ["shift","spacebar"]]],
"{" => [["close_bracket", ["shift","spacebar"]]],
"A" => [["a", ["shift","spacebar"]]],
"S" => [["s", ["shift","spacebar"]]],
"D" => [["d", ["shift","spacebar"]]],
"F" => [["f", ["shift","spacebar"]]],
"G" => [["g", ["shift","spacebar"]]],
"H" => [["h", ["shift","spacebar"]]],
"J" => [["j", ["shift","spacebar"]]],
"K" => [["k", ["shift","spacebar"]]],
"L" => [["l", ["shift","spacebar"]]],
"+" => [["semicolon", ["shift","spacebar"]]],
"*" => [["quote", ["shift","spacebar"]]],
"}" => [["non_us_pound", ["shift","spacebar"]]],
"Z" => [["z", ["shift","spacebar"]]],
"X" => [["x", ["shift","spacebar"]]],
"C" => [["c", ["shift","spacebar"]]],
"V" => [["v", ["shift","spacebar"]]],
"B" => [["b", ["shift","spacebar"]]],
"N" => [["n", ["shift","spacebar"]]],
"M" => [["m", ["shift","spacebar"]]],
"<" => [["comma", ["shift","spacebar"]]],
">" => [["period", ["shift","spacebar"]]],
"?" => [["slash", ["shift","spacebar"]]],
"_" => [["international1", ["shift","spacebar"]]],
" " => [["spacebar", ["shift"]]],
## ANSIで必要 ######################################
"backslash" => [["backslash",[]],["backslash",["shift","spacebar"]]],

## 特殊 ######################################
"forward_delete" => [["delete_or_backspace",["shift"]]],
"escape_japanese_eisuu" => [["escape",[]], ["j", ["left_control", "left_shift"]], ["japanese_eisuu",[]]],
}

SHIN_JIS_MAP_JIS_ANSI_DIFF = {
  "`" => [["grave_accent_and_tilde", ["shift"]]],
  "~" => [["grave_accent_and_tilde", ["shift","spacebar"]]],
  "@" => [["2", ["shift","spacebar"]]],
  "^" => [["6", ["shift","spacebar"]]],
  "&" => [["7", ["shift","spacebar"]]],
  "(" => [["9", ["shift","spacebar"]]],
  ")" => [["0", ["shift","spacebar"]]],
  "-" => [["hyphen", ["shift"]]],
  "_" => [["hyphen", ["shift","spacebar"]]],
  "=" => [["equal_sign", ["shift"]]],
  "+" => [["equal_sign", ["shift","spacebar"]]],
  "[" => [["open_bracket", ["shift"]]],
  "{" => [["open_bracket", ["shift","spacebar"]]],
  "]" => [["close_bracket", ["shift"]]],
  "}" => [["close_bracket", ["shift","spacebar"]]],
  "backslash" => [["backslash", ["shift"]]],
  "|" => [["backslash", ["shift","spacebar"]]],
  ";" => [["semicolon", ["shift"]]],
  ":" => [["semicolon", ["shift","spacebar"]]],
  "quote" => [["quote", ["shift"]]],
  "double_quote" => [["quote", ["shift","spacebar"]]],
}

KANA_MAP_JIS_ANSI_DIFF = {
  "へ" => [["backslash",[]]],
  "む" => [["close_bracket",[]]],
  "ー" => [["close_bracket",["shift"]]],
  "け" => [["quote",[]]],
  "ろ" => [["quote",["shift"]]],
  "゜" => [["equal_sign",[]]],
  "「" => [["equal_sign",["shift"]]],
  "゛" => [["open_bracket",[]]],
  "」" => [["open_bracket",["shift"]]],
  "`" => [["japanese_eisuu",[]], ["grave_accent_and_tilde",[]], ["japanese_kana",[]]],
  "~" => [["japanese_eisuu",[]], ["grave_accent_and_tilde",["shift"]], ["japanese_kana",[]]],
  "@" => [ ["japanese_eisuu",[]], ["2",["shift"]], ["japanese_kana",[]]],
  "^" => [ ["japanese_eisuu",[]], ["6",["shift"]], ["japanese_kana",[]]],
  "&" => [ ["japanese_eisuu",[]], ["7",["shift"]], ["japanese_kana",[]]],
  "(" => [ ["japanese_eisuu",[]], ["9",["shift"]], ["japanese_kana",[]]],
  ")" => [ ["japanese_eisuu",[]], ["0",["shift"]], ["japanese_kana",[]]],
  "-" => [["japanese_eisuu",[]], ["hyphen",[]], ["japanese_kana",[]]],
  "_" => [["japanese_eisuu",[]], ["hyphen",["shift"]], ["japanese_kana",[]]],
  "=" => [["japanese_eisuu",[]], ["equal_sign",[]], ["japanese_kana",[]]],
  "+" => [["japanese_eisuu",[]], ["equal_sign",["shift"]], ["japanese_kana",[]]],
  "[" => [ ["japanese_eisuu",[]], ["open_bracket",[]], ["japanese_kana",[]]],
  "{" => [ ["japanese_eisuu",[]], ["open_bracket",["shift"]], ["japanese_kana",[]]],
  "]" => [["japanese_eisuu",[]], ["close_bracket",[]], ["japanese_kana",[]]],
  "}" => [["japanese_eisuu",[]], ["close_bracket",["shift"]], ["japanese_kana",[]]],
  "backslash" => [["japanese_eisuu",[]], ["backslash",[]], ["japanese_kana",[]]],
  "|" => [["japanese_eisuu",[]], ["backslash",["shift"]], ["japanese_kana",[]]],
  ";" => [ ["japanese_eisuu",[]], ["semicolon",[]], ["japanese_kana",[]]],
  ":" => [ ["japanese_eisuu",[]], ["semicolon",["shift"]], ["japanese_kana",[]]],
  "quote" => [ ["japanese_eisuu",[]], ["quote",[]], ["japanese_kana",[]]],
  "double_quote" => [ ["japanese_eisuu",[]], ["quote",["left_shift"]], ["japanese_kana",[]]],

}

KANA_MAP = {
  # "打ちたい文字列" => "かな入力"におけるキーの組み合わせs　("to":)
  # "string you want to get" => [["keyCode", [modifiers]],...]
  ## かな文字 ######################################
    "あ" => [["3",[]]],
    "い" => [["e",[]]],
    "う" => [["4",[]]],
    "え" => [["5",[]]],
    "お" => [["6",[]]],
    "ぁ" => [["3",["left_shift"]]],
    "ぃ" => [["e",["left_shift"]]],
    "ぅ" => [["4",["left_shift"]]],
    "ぇ" => [["5",["left_shift"]]],
    "ぉ" => [["6",["left_shift"]]],
    "か" => [["t",[]]],
    "き" => [["g",[]]],
    "く" => [["h",[]]],
    "け" => [["quote",[]]],
    "こ" => [["b",[]]],
    "さ" => [["x",[]]],
    "し" => [["d",[]]],
    "す" => [["r",[]]],
    "せ" => [["p",[]]],
    "そ" => [["c",[]]],
    "た" => [["q",[]]],
    "ち" => [["a",[]]],
    "つ" => [["z",[]]],
    "っ" => [["z",["left_shift"]]],
    "て" => [["w",[]]],
    "と" => [["s",[]]],
    "な" => [["u",[]]],
    "に" => [["i",[]]],
    "ぬ" => [["1",[]]],
    "ね" => [["comma",[]]],
    "の" => [["k",[]]],
    "は" => [["f",[]]],
    "ひ" => [["v",["left_shift"]]],
    "ふ" => [["2",["left_shift"]]],
    "へ" => [["equal_sign",[]]],
    "ほ" => [["hyphen",[]]],
    "ま" => [["j",["left_shift"]]],
    "み" => [["n",["left_shift"]]],
    "む" => [["non_us_pound",[]]],
    "め" => [["slash",[]]],
    "も" => [["m",["left_shift"]]],
    "や" => [["7",[]]],
    "ゆ" => [["8",[]]],
    "よ" => [["9",[]]],
    "ゃ" => [["7",["left_shift"]]],
    "ゅ" => [["8",["left_shift"]]],
    "ょ" => [["9",["left_shift"]]],
    "ら" => [["o",[]]],
    "り" => [["l",[]]],
    "る" => [["period",[]]],
    "れ" => [["semicolon",[]]],
    "ろ" => [["international1",[]]],
    "わ" => [["0",[]]],
    "を" => [["0",["left_shift"]]],
    "ん" => [["y",[]]],
    "゛" => [["open_bracket",[]]],
    "゜" => [["close_bracket",[]]],
    "、" => [["comma",["left_shift"]]],
    "。" => [["period",["left_shift"]]],
    "ー" => [["international3",["left_shift"]]],
    "「" => [["close_bracket",["left_shift"]]],
    "」" => [["non_us_pound",["left_shift"]]],
    "・" => [["slash",["left_shift"]]],
    ## 半角英字記号 ######################################
    "1" => [ ["japanese_eisuu",[]], ["1",[]], ["japanese_kana",[]]],
    "2" => [ ["japanese_eisuu",[]], ["2",[]], ["japanese_kana",[]]],
    "3" => [ ["japanese_eisuu",[]], ["3",[]], ["japanese_kana",[]]],
    "4" => [ ["japanese_eisuu",[]], ["4",[]], ["japanese_kana",[]]],
    "5" => [ ["japanese_eisuu",[]], ["5",[]], ["japanese_kana",[]]],
    "6" => [ ["japanese_eisuu",[]], ["6",[]], ["japanese_kana",[]]],
    "7" => [ ["japanese_eisuu",[]], ["7",[]], ["japanese_kana",[]]],
    "8" => [ ["japanese_eisuu",[]], ["8",[]], ["japanese_kana",[]]],
    "9" => [ ["japanese_eisuu",[]], ["9",[]], ["japanese_kana",[]]],
    "0" => [ ["japanese_eisuu",[]], ["0",[]], ["japanese_kana",[]]],
    "-" => [ ["japanese_eisuu",[]], ["hyphen",[]], ["japanese_kana",[]]],
    "^" => [ ["japanese_eisuu",[]], ["equal_sign",[]], ["japanese_kana",[]]],
    "¥" => [ ["japanese_eisuu",[]], ["international3",[]], ["japanese_kana",[]]],

    "q" => [ ["japanese_eisuu",[]], ["q",[]], ["japanese_kana",[]]],
    "w" => [ ["japanese_eisuu",[]], ["w",[]], ["japanese_kana",[]]],
    "e" => [ ["japanese_eisuu",[]], ["e",[]], ["japanese_kana",[]]],
    "r" => [ ["japanese_eisuu",[]], ["r",[]], ["japanese_kana",[]]],
    "t" => [ ["japanese_eisuu",[]], ["t",[]], ["japanese_kana",[]]],
    "y" => [ ["japanese_eisuu",[]], ["y",[]], ["japanese_kana",[]]],
    "u" => [ ["japanese_eisuu",[]], ["u",[]], ["japanese_kana",[]]],
    "i" => [ ["japanese_eisuu",[]], ["i",[]], ["japanese_kana",[]]],
    "o" => [ ["japanese_eisuu",[]], ["o",[]], ["japanese_kana",[]]],
    "p" => [ ["japanese_eisuu",[]], ["p",[]], ["japanese_kana",[]]],
    "@" => [ ["japanese_eisuu",[]], ["open_bracket",[]], ["japanese_kana",[]]],
    "[" => [ ["japanese_eisuu",[]], ["close_bracket",[]], ["japanese_kana",[]]],
    
    "a" => [ ["japanese_eisuu",[]], ["a",[]], ["japanese_kana",[]]],
    "s" => [ ["japanese_eisuu",[]], ["s",[]], ["japanese_kana",[]]],
    "d" => [ ["japanese_eisuu",[]], ["d",[]], ["japanese_kana",[]]],
    "f" => [ ["japanese_eisuu",[]], ["f",[]], ["japanese_kana",[]]],
    "g" => [ ["japanese_eisuu",[]], ["g",[]], ["japanese_kana",[]]],
    "h" => [ ["japanese_eisuu",[]], ["h",[]], ["japanese_kana",[]]],
    "j" => [ ["japanese_eisuu",[]], ["j",[]], ["japanese_kana",[]]],
    "k" => [ ["japanese_eisuu",[]], ["k",[]], ["japanese_kana",[]]],
    "l" => [ ["japanese_eisuu",[]], ["l",[]], ["japanese_kana",[]]],
    ";" => [ ["japanese_eisuu",[]], ["semicolon",[]], ["japanese_kana",[]]],
    ":" => [ ["japanese_eisuu",[]], ["quote",[]], ["japanese_kana",[]]],
    "]" => [ ["japanese_eisuu",[]], ["non_us_pound",[]], ["japanese_kana",[]]],
    
    "z" => [ ["japanese_eisuu",[]], ["z",[]], ["japanese_kana",[]]],
    "x" => [ ["japanese_eisuu",[]], ["x",[]], ["japanese_kana",[]]],
    "c" => [ ["japanese_eisuu",[]], ["c",[]], ["japanese_kana",[]]],
    "v" => [ ["japanese_eisuu",[]], ["v",[]], ["japanese_kana",[]]],
    "b" => [ ["japanese_eisuu",[]], ["b",[]], ["japanese_kana",[]]],
    "n" => [ ["japanese_eisuu",[]], ["n",[]], ["japanese_kana",[]]],
    "m" => [ ["japanese_eisuu",[]], ["m",[]], ["japanese_kana",[]]],
    "," => [ ["japanese_eisuu",[]], ["comma",[]], ["japanese_kana",[]]],
    "." => [ ["japanese_eisuu",[]], ["period",[]], ["japanese_kana",[]]],
    "/" => [ ["japanese_eisuu",[]], ["slash",[]], ["japanese_kana",[]]],

    "!" => [ ["japanese_eisuu",[]], ["1",["left_shift"]], ["japanese_kana",[]]],
    "double_quote" => [ ["japanese_eisuu",[]], ["2",["left_shift"]], ["japanese_kana",[]]],
    "#" => [ ["japanese_eisuu",[]], ["3",["left_shift"]], ["japanese_kana",[]]],
    "$" => [ ["japanese_eisuu",[]], ["4",["left_shift"]], ["japanese_kana",[]]],
    "%" => [ ["japanese_eisuu",[]], ["5",["left_shift"]], ["japanese_kana",[]]],
    "&" => [ ["japanese_eisuu",[]], ["6",["left_shift"]], ["japanese_kana",[]]],
    "quote" => [ ["japanese_eisuu",[]], ["7",["left_shift"]], ["japanese_kana",[]]],
    "(" => [ ["japanese_eisuu",[]], ["8",["left_shift"]], ["japanese_kana",[]]],
    ")" => [ ["japanese_eisuu",[]], ["9",["left_shift"]], ["japanese_kana",[]]],
    "=" => [ ["japanese_eisuu",[]], ["hyphen",["left_shift"]], ["japanese_kana",[]]],
    "~" => [ ["japanese_eisuu",[]], ["equal_sign",["left_shift"]], ["japanese_kana",[]]],
    "|" => [ ["japanese_eisuu",[]], ["international3",["left_shift"]], ["japanese_kana",[]]],
    
    "Q" => [ ["japanese_eisuu",[]], ["q",["left_shift"]], ["japanese_kana",[]]],
    "W" => [ ["japanese_eisuu",[]], ["w",["left_shift"]], ["japanese_kana",[]]],
    "E" => [ ["japanese_eisuu",[]], ["e",["left_shift"]], ["japanese_kana",[]]],
    "R" => [ ["japanese_eisuu",[]], ["r",["left_shift"]], ["japanese_kana",[]]],
    "T" => [ ["japanese_eisuu",[]], ["t",["left_shift"]], ["japanese_kana",[]]],
    "Y" => [ ["japanese_eisuu",[]], ["y",["left_shift"]], ["japanese_kana",[]]],
    "U" => [ ["japanese_eisuu",[]], ["u",["left_shift"]], ["japanese_kana",[]]],
    "I" => [ ["japanese_eisuu",[]], ["i",["left_shift"]], ["japanese_kana",[]]],
    "O" => [ ["japanese_eisuu",[]], ["o",["left_shift"]], ["japanese_kana",[]]],
    "P" => [ ["japanese_eisuu",[]], ["p",["left_shift"]], ["japanese_kana",[]]],
    "`" => [ ["japanese_eisuu",[]], ["open_bracket",["left_shift"]], ["japanese_kana",[]]],
    "{" => [ ["japanese_eisuu",[]], ["close_bracket",["left_shift"]], ["japanese_kana",[]]],
    
    "A" => [ ["japanese_eisuu",[]], ["a",["left_shift"]], ["japanese_kana",[]]],
    "S" => [ ["japanese_eisuu",[]], ["s",["left_shift"]], ["japanese_kana",[]]],
    "D" => [ ["japanese_eisuu",[]], ["d",["left_shift"]], ["japanese_kana",[]]],
    "F" => [ ["japanese_eisuu",[]], ["f",["left_shift"]], ["japanese_kana",[]]],
    "G" => [ ["japanese_eisuu",[]], ["g",["left_shift"]], ["japanese_kana",[]]],
    "H" => [ ["japanese_eisuu",[]], ["h",["left_shift"]], ["japanese_kana",[]]],
    "J" => [ ["japanese_eisuu",[]], ["j",["left_shift"]], ["japanese_kana",[]]],
    "K" => [ ["japanese_eisuu",[]], ["k",["left_shift"]], ["japanese_kana",[]]],
    "L" => [ ["japanese_eisuu",[]], ["l",["left_shift"]], ["japanese_kana",[]]],
    "+" => [ ["japanese_eisuu",[]], ["semicolon",["left_shift"]], ["japanese_kana",[]]],
    "*" => [ ["japanese_eisuu",[]], ["quote",["left_shift"]], ["japanese_kana",[]]],
    "}" => [ ["japanese_eisuu",[]], ["non_us_pound",["left_shift"]], ["japanese_kana",[]]],

    "Z" => [ ["japanese_eisuu",[]], ["z",["left_shift"]], ["japanese_kana",[]]],
    "X" => [ ["japanese_eisuu",[]], ["x",["left_shift"]], ["japanese_kana",[]]],
    "C" => [ ["japanese_eisuu",[]], ["c",["left_shift"]], ["japanese_kana",[]]],
    "V" => [ ["japanese_eisuu",[]], ["v",["left_shift"]], ["japanese_kana",[]]],
    "B" => [ ["japanese_eisuu",[]], ["b",["left_shift"]], ["japanese_kana",[]]],
    "N" => [ ["japanese_eisuu",[]], ["n",["left_shift"]], ["japanese_kana",[]]],
    "M" => [ ["japanese_eisuu",[]], ["m",["left_shift"]], ["japanese_kana",[]]],
    "<" => [ ["japanese_eisuu",[]], ["comma",["left_shift"]], ["japanese_kana",[]]],
    ">" => [ ["japanese_eisuu",[]], ["period",["left_shift"]], ["japanese_kana",[]]],
    "?" => [ ["japanese_eisuu",[]], ["slash",["left_shift"]], ["japanese_kana",[]]],
    "_" => [ ["japanese_eisuu",[]], ["international1",["left_shift"]], ["japanese_kana",[]]],
    " " => [ ["japanese_eisuu",[]], ["spacebar",["left_shift"]], ["japanese_kana",[]]],
    ## ANSIで必要 ######################################
    "backslash" => [["backslash",[]]],
    ## 特殊 ######################################
    "（）" => [["8",["option","left_shift"]], ["9",["option","left_shift"]], ["left_arrow",[]]],
    "()" => [["japanese_eisuu",[]], ["8",["left_shift"]], ["9",["left_shift"]], ["left_arrow",[]]],
    "forward_delete" => [["delete_or_backspace",["fn"]]],
    "escape_japanese_eisuu" => [["escape",[]], ["j", ["left_control", "left_shift"]], ["japanese_eisuu",[]]],
}

def modified_key_first(characters)
  reorder_work = {}
  characters.each {|ch|
    SHIN_JIS_MAP[ch].each {|key_combination|
      reorder_work[key_combination[0]] = [key_combination[1]]
    }
  }
end

def set_virtual_modifier(key_code, var_name)
    {
      "type" => "basic",
      "from" => {
        "key_code" => key_code,
        "modifiers" => {
          "mandatory" => [],
          "optional" => ["any"],
        },
      },
      "to" => [
        {
          "set_variable" => {
          "name" => var_name,
          "value" => 1,
          },
          "lazy" => true
        },
      ],
      "to_after_key_up" => [
        {
                "set_variable" => {
                  "name" => var_name,
                  "value" => 0,
                },
              },
      ],
      "to_if_alone" => [
          {
            "key_code" => key_code
          }
      ]
    }
end

def gen_change(kana_map, shin_JIS_map, keyboard_conditions, strs)
  manipulators = []
  strs.each  { |str|
    raise "shin_JIS_map error on #{str}" if  shin_JIS_map[str] == nil
    raise "kana_map error on #{str}" if  kana_map[str] == nil

    shin_JIS_map[str].each { |from_KC|
      from_key_code = from_KC[0]
      extended_modifiers = from_KC[1]
      raise "modifier(from) undefined on #{str}" if extended_modifiers == nil
      from_modifiers = extended_modifiers.intersection(NON_VIRTUAL_FROM_MODIFIERS)
      raise "undefined modifier" unless (extended_modifiers - NON_VIRTUAL_FROM_MODIFIERS - VIRTUAL_FROM_MODIFIERS).empty?
      if extended_modifiers.intersection(VIRTUAL_FROM_MODIFIERS).empty?
          conditions = BASIC_CONDITIONS + keyboard_conditions
      else
          conditions = BASIC_CONDITIONS + OYAYUBI_SHIFT_CONDITIONS + keyboard_conditions
      end
      from_key_combination = {
        "key_code" => from_key_code,
        "modifiers" => {
          "mandatory" => from_modifiers,
          "optional" => []
        }
      }
      to_key_combinations = []
      kana_map[str].each { |to_KC|
        to_key_code = to_KC[0]
        to_modifiers = to_KC[1]
        to_key_combinations << {
            "key_code" => to_key_code,
            "modifiers" => to_modifiers,
            "repeat" => false
        }
      }
      
      manipulators << [extended_modifiers, {
            "type" => "basic",
            "from" => from_key_combination,
            "to" => to_key_combinations,
            "conditions" => conditions,}
      ]
    }
  }
  return manipulators
end

def main

  all_characters = [
  # 新JISで扱うかな文字
  "そ", "け", "せ", "て", "ょ", "つ", "ん", "の", "を", "り", "ち",
  "は", "か", "し", "と", "た", "く", "う", "い", "゛", "き", "な",
  "す", "こ", "に", "さ", "あ", "っ", "る", "、", "。", "れ",
  "ぁ", "゜", "ほ", "ふ", "め", "ひ", "え", "み", "や", "ぬ", "「",
  "ぃ", "へ", "ら", "ゅ", "よ", "ま", "お", "も", "わ", "ゆ", "」",
  "ぅ", "ぇ", "ぉ", "ね", "ゃ", "む", "ろ", "・", "ー",
  "そ", "け", "せ", "て", "ょ", "つ", "ん", "の", "を", "り", "ち",
  "は", "か", "し", "と", "た", "く", "う", "い", "゛", "き", "な",
  "す", "こ", "に", "さ", "あ", "っ", "る", "、", "。", "れ",
  # JISキーボードのキートップに書かれている文字を半角で入力する。
  "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "^", "¥",
  "q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "@", "[",
  "a", "s", "d", "f", "g", "h", "j", "k", "l", ";", ":", "]",
  "z", "x", "c", "v", "b", "n", "m", ",", ".", "/",
  "!", "double_quote", "#", "$", "%", "&", "quote", "(", ")", "=", "~", "|",
  "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "`", "{",
  "A", "S", "D", "F", "G", "H", "J", "K", "L", "+", "*", "}",
  "Z", "X", "C", "V", "B", "N", "M", "<", ">", "?", "_",
  " ",
  # ANSIキーボード
  "backslash",
  # 特殊な便利機能
  "forward_delete", ]
  changes = gen_change(KANA_MAP, SHIN_JIS_MAP, JIS_KEYBOARD_CONDITIONS, all_characters)
  kana_map_ANSI = KANA_MAP.dup.merge(KANA_MAP_JIS_ANSI_DIFF)
  shih_JIS_map_ANSI = SHIN_JIS_MAP.dup.merge(SHIN_JIS_MAP_JIS_ANSI_DIFF)
  changes = changes + gen_change(kana_map_ANSI, shih_JIS_map_ANSI, ANSI_KEYBOARD_CONDITIONS, all_characters)
#  p SHIN_JIS_MAP["^"]
#  p KANA_MAP["^"]
  # from条件の厳しいものを先にする
  sorted_changes = []
  changes.sort_by{|x| x[0]}.each {|y|
    sorted_changes.prepend(y[1])
  }

  puts JSON.pretty_generate(
    "title" => "Kotoeri.KanaTyping.Japanese => Japanese JIS X 6004 （新JIS配列）(rev 0.2)",
    "rules" => [
      {
        "description" => 'かな入力を新JIS配列に入れ替える',
        # シフトありから並べること
        "manipulators" => [set_virtual_modifier("spacebar", OYAYUBI_SHIFT_ON),] + sorted_changes
      },
    ]
  )
end

main

=begin ## 同時押しのメモ　使ってない
def simultaneous_shift_key(shiftKey, key, char)
    find_KANA_MAP_error(char, "simultaneous")
  {
    "type" => "basic",
    "from" => {
      "simultaneous" => [
        {
          "key_code" => key,
        },
        {
          "key_code" => shiftKey,
        },
      ],
    },
    "to" => KANA_MAP[char],
    "conditions" => BASIC_CONDITIONS,
  }
end
=end

