#!/usr/bin/env ruby

# You can generate json by executing the following command on Terminal.
#
# $ ruby ./Japanese_JIS_X_6004_ShinJIS.json.rb
#

require "json"
require_relative "../lib/karabiner.rb"

########################################
DEBUG = false
# 親指シフトのキーコード
OYAYUBI_SHIFT_KEY_CODE = "spacebar".freeze
OYAYUBI_SHIFT_ON = "spacebar_on".freeze
########################################
# 有効になる条件

BASIC_CONDITIONS = [
  Karabiner.input_source_if([
                              {
                                "input_mode_id" => "com.apple.inputmethod.Japanese",
                              },
                              {
                                "input_mode_id" => "com.apple.inputmethod.Japanese.Hiragana",
                              },
                              {
                                "input_mode_id" => "com.apple.inputmethod.Japanese.Katakana",
                              },
                              {
                                "input_mode_id" => "com.apple.inputmethod.Japanese.HalfWidthKana",
                              },
                            ]),
  Karabiner.frontmost_application_unless(["loginwindow"]),
].freeze

########################################
# 修飾キー、前置キー、後置キーを含めてあるキーを打つ

def key(key_code, modifiers)
    if modifiers == [] then
        {
            "key_code" => key_code,
            "repeat" => false,
        }
    else
        {
            "key_code" => key_code,
            "modifiers" => modifiers,
            "repeat" => false,
        }
    end
end

def zenkaku_eiji()
    key("l", ["left_control", "left_shift"])
end

def hiragana()
    key("j", ["left_control", "left_shift"])
end

def key_array_hankaku(key_code,modifiers)
    [key("japanese_eisuu",[]), key(key_code,modifiers), key("japanese_kana",[])]
end

def key_array_zenkaku(key_code,modifiers)
  [zenkaku_eiji(), key(key_code,modifiers), hiragana()]
end


KANA_MAP = {
## 全角 ######################################
  "あ" => [key("3",[])],
  "い" => [key("e",[])],
  "う" => [key("4",[])],
  "え" => [key("5",[])],
  "お" => [key("6",[])],
  "ぁ" => [key("3",["left_shift"])],
  "ぃ" => [key("e",["left_shift"])],
  "ぅ" => [key("4",["left_shift"])],
  "ぇ" => [key("5",["left_shift"])],
  "ぉ" => [key("6",["left_shift"])],
  "か" => [key("t",[])],
  "き" => [key("g",[])],
  "く" => [key("h",[])],
  "け" => [key("quote",[])],
  "こ" => [key("b",[])],
  "さ" => [key("x",[])],
  "し" => [key("d",[])],
  "す" => [key("r",[])],
  "せ" => [key("p",[])],
  "そ" => [key("c",[])],
  "た" => [key("q",[])],
  "ち" => [key("a",[])],
  "つ" => [key("z",[])],
  "っ" => [key("z",["left_shift"])],
  "て" => [key("w",[])],
  "と" => [key("s",[])],
  "な" => [key("u",[])],
  "に" => [key("i",[])],
  "ぬ" => [key("1",[])],
  "ね" => [key("comma",[])],
  "の" => [key("k",[])],
  "は" => [key("f",[])],
  "ひ" => [key("v",["left_shift"])],
  "ふ" => [key("2",["left_shift"])],
  "へ" => [key("equal_sign",["left_shift"])],
  "ほ" => [key("hyphen",["left_shift"])],
  "ま" => [key("j",["left_shift"])],
  "み" => [key("n",["left_shift"])],
  "む" => [key("backslash",[])],
  "め" => [key("slash",[])],
  "も" => [key("m",["left_shift"])],
  "や" => [key("7",[])],
  "ゆ" => [key("8",[])],
  "よ" => [key("9",[])],
  "ゃ" => [key("7",["left_shift"])],
  "ゅ" => [key("8",["left_shift"])],
  "ょ" => [key("9",["left_shift"])],
  "ら" => [key("o",[])],
  "り" => [key("l",[])],
  "る" => [key("period",[])],
  "れ" => [key("semicolon",[])],
  "ろ" => [key("international1",[])],
  "わ" => [key("0",[])],
  "を" => [key("0",["left_shift"])],
  "ん" => [key("y",[])],
  "゛" => [key("open_bracket",[])],
  "゜" => [key("close_bracket",[])],
  "、" => [key("comma",["left_shift"])],
  "。" => [key("period",["left_shift"])],
  "ー" => [key("international3",["left_shift"])],
  "「" => [key("close_bracket",["left_shift"])],
  "」" => [key("backslash",["left_shift"])],
  "・" => [key("slash",["left_shift"])],
  "１" => [key("1",["option"])],
  "２" => [key("2",["option"])],
  "３" => [key("3",["option"])],
  "４" => [key("4",["option"])],
  "５" => [key("5",["option"])],
  "６" => [key("6",["option"])],
  "７" => [key("7",["option"])],
  "８" => [key("8",["option"])],
  "９" => [key("9",["option"])],
  "０" => [key("0",["option"])],
  "＾" => [key("equal_sign",["option"])],
  "￥" => [key("international3",["option"])],
  "＠" => [key("open_bracket",["option"])],
  "［" => [key("close_bracket",["option"])],
  "；" => [key("semicolon",["option"])],
  "：" => [key("quote",["option"])],
  "］" => [key("backslash",["option"])],
  "，" => [key("comma",["option"])],
  "．" => [key("period",["option"])],
  "／" => [key("slash",["option"])],
  "＿" => [key("international1",["option"])],
  "！" => [key("1",["option","left_shift"])],
  "＂" => [key("2",["option","left_shift"])],
  "＃" => [key("3",["option","left_shift"])],
  "＄" => [key("4",["option","left_shift"])],
  "％" => [key("5",["option","left_shift"])],
  "＆" => [key("6",["option","left_shift"])],
  "＇" => [key("7",["option","left_shift"])],
  "（" => [key("8",["option","left_shift"])],
  "）" => [key("9",["option","left_shift"])],
  "＝" => [key("hyphen",["option","left_shift"])],
  "〜" => [key("equal_sign",["option","left_shift"])],  # 本プログラムでは"〜"を正とし、"～"は使わない
  "｜" => [key("international3",["option","left_shift"])],
  "｀" => [key("open_bracket",["option","left_shift"])],
  "｛" => [key("close_bracket",["option","left_shift"])],
  "＋" => [key("semicolon",["option","left_shift"])],
  "＊" => [key("quote",["option","left_shift"])],
  "｝" => [key("backslash",["option","left_shift"])],
  "＜" => [key("comma",["option","left_shift"])],
  "＞" => [key("period",["option","left_shift"])],
  "？" => [key("slash",["option","left_shift"])],
  "Ａ" => key_array_zenkaku("a",["left_shift"]),
  "Ｂ" => key_array_zenkaku("b",["left_shift"]),
  "Ｃ" => key_array_zenkaku("c",["left_shift"]),
  "Ｄ" => key_array_zenkaku("d",["left_shift"]),
  "Ｅ" => key_array_zenkaku("e",["left_shift"]),
  "Ｆ" => key_array_zenkaku("f",["left_shift"]),
  "Ｇ" => key_array_zenkaku("g",["left_shift"]),
  "Ｈ" => key_array_zenkaku("h",["left_shift"]),
  "Ｉ" => key_array_zenkaku("i",["left_shift"]),
  "Ｊ" => key_array_zenkaku("j",["left_shift"]),
  "Ｋ" => key_array_zenkaku("k",["left_shift"]),
  "Ｌ" => key_array_zenkaku("l",["left_shift"]),
  "Ｍ" => key_array_zenkaku("m",["left_shift"]),
  "Ｎ" => key_array_zenkaku("n",["left_shift"]),
  "Ｏ" => key_array_zenkaku("o",["left_shift"]),
  "Ｐ" => key_array_zenkaku("p",["left_shift"]),
  "Ｑ" => key_array_zenkaku("q",["left_shift"]),
  "Ｒ" => key_array_zenkaku("r",["left_shift"]),
  "Ｓ" => key_array_zenkaku("s",["left_shift"]),
  "Ｔ" => key_array_zenkaku("t",["left_shift"]),
  "Ｕ" => key_array_zenkaku("u",["left_shift"]),
  "Ｖ" => key_array_zenkaku("v",["left_shift"]),
  "Ｗ" => key_array_zenkaku("w",["left_shift"]),
  "Ｘ" => key_array_zenkaku("x",["left_shift"]),
  "Ｙ" => key_array_zenkaku("y",["left_shift"]),
  "Ｚ" => key_array_zenkaku("z",["left_shift"]),

## 半角 ######################################
  "1" => key_array_hankaku("1",[]),
  "2" => key_array_hankaku("2",[]),
  "3" => key_array_hankaku("3",[]),
  "4" => key_array_hankaku("4",[]),
  "5" => key_array_hankaku("5",[]),
  "6" => key_array_hankaku("6",[]),
  "7" => key_array_hankaku("7",[]),
  "8" => key_array_hankaku("8",[]),
  "9" => key_array_hankaku("9",[]),
  "0" => key_array_hankaku("0",[]),
  "-" => key_array_hankaku("hyphen",[]),
  "^" => key_array_hankaku("equal_sign",[]),
  "¥" => key_array_hankaku("international3",[]),
  "@" => key_array_hankaku("open_bracket",[]),
  "[" => key_array_hankaku("close_bracket",[]),
  ";" => key_array_hankaku("semicolon",[]),
  ":" => key_array_hankaku("quote",[]),
  "]" => key_array_hankaku("backslash",[]),
  "," => key_array_hankaku("comma",[]),
  "." => key_array_hankaku("period",[]),
  "/" => key_array_hankaku("slash",[]),
  "_" => key_array_hankaku("international1",[]),
  "!" => key_array_hankaku("1",["left_shift"]),
  "double_quote" => key_array_hankaku("2",["left_shift"]),
  "#" => key_array_hankaku("3",["left_shift"]),
  "$" => key_array_hankaku("4",["left_shift"]),
  "%" => key_array_hankaku("5",["left_shift"]),
  "&" => key_array_hankaku("6",["left_shift"]),
  "quote" => key_array_hankaku("7",["left_shift"]),
  "(" => key_array_hankaku("8",["left_shift"]),
  ")" => key_array_hankaku("9",["left_shift"]),
  "=" => key_array_hankaku("hyphen",["left_shift"]),
  "~" => key_array_hankaku("equal_sign",["left_shift"]),
  "|" => key_array_hankaku("international3",["left_shift"]),
  "`" => key_array_hankaku("open_bracket",["left_shift"]),
  "{" => key_array_hankaku("close_bracket",["left_shift"]),
  "+" => key_array_hankaku("semicolon",["left_shift"]),
  "*" => key_array_hankaku("quote",["left_shift"]),
  "}" => key_array_hankaku("backslash",["left_shift"]),
  "<" => key_array_hankaku("comma",["left_shift"]),
  ">" => key_array_hankaku("period",["left_shift"]),
  "?" => key_array_hankaku("slash",["left_shift"]),
  " " => key_array_hankaku("spacebar",["left_shift"]),
## 特殊 ######################################
  "japanese_eisuu" => [key("japanese_eisuu",[])],
  "escape_japanese_eisuu" => [key("escape",[]), key("japanese_eisuu",[])],
  "japanese_kana" => [key("japanese_kana",[])],
  "escape" => [key("escape",[])],
  "delete" => [key("delete_or_backspace",[])],
  "（）" => [key("8",["option","left_shift"]), key("9",["option","left_shift"]), key("left_arrow",[])],
  "()" => [key("japanese_eisuu",[]), key("8",["left_shift"]), key("9",["left_shift"]), key("left_arrow",[]), key("japanese_kana",[])],
  "全キーMacBook_Air_M1_2020" => []
# カナ入力ではoption-,option-shift-は全角の英字を出す。
#  '？' => [key("slash",["option"])],
}.freeze

########################################
# You cannot specify multiple items(set_variable & key_code) into one "to" entry.
def set_virtual_modifier(key, var_name)
  {
    "type" => "basic",
    "from" => {
      "key_code" => key,
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
          "key_code" => key
        }
    ]
  }
end

def map_key(key, modifiers, char)
  find_KANA_MAP_error(char, "shift")
  if modifiers == [] then
    {
        "type" => "basic",
        "from" => {
          "key_code" => key,
        },
        "to" => KANA_MAP[char],
        "conditions" => BASIC_CONDITIONS,
    }
  else
    {
        "type" => "basic",
        "from" => {
          "key_code" => key,
          "modifiers" => {
              "mandatory" => modifiers,
              "optional" => ["any"],
          },
        },
          "to" => KANA_MAP[char],
          "conditions" => BASIC_CONDITIONS,
    }
  end
end

def virtual_shift_key(key, shiftVar, char)
  find_KANA_MAP_error(char, "virtual_shift")
  {
    "type" => "basic",
    "from" => {
      "key_code" => key,
      "modifiers" => {
        "mandatory" => [],
        "optional" => ["any"],
      },
    },
    "to" => KANA_MAP[char],
    "conditions" => BASIC_CONDITIONS + [{
                                          "type" => "variable_if",
                                          "name" => shiftVar,
                                          "value" => 1,
                                        }]
  }
end

## 同時押しが好きな人はこちら
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

########################################
def find_KANA_MAP_error(char, str = "line number or something")
    return unless DEBUG
    if KANA_MAP[char] == nil
        p "=================="
        p "「" + char + "」 @ " + str
        p "=================="
    end
end
########################################
def test_pattern
    
end


########################################
def main
  puts JSON.pretty_generate(
    "title" => "Japanese JIS X 6004 （新JIS配列）(rev 0.1)",
    "rules" => [
      {
        "description" => '新JIS（main）　入力方法は"かな入力"　shiftはspaceBar　数字は半角　今のところJISキーボード用(rev 0.1)',
        ## シフトはスペースキーです\n
        ## 半角数字と新JISで未使用キーの記号はそのまま打てます
        ## 1234567890-^\[]_ !"#$%&'()0=~|{}_
        ## 全角数字・全角記号はopt・opt-shift（カナ入力と同じ）
        ## １２３４５６７８９０ー＾￥＠［；：］，．／＿
        ## ！"＃＄％＆’（）０＝〜｜｀｛＋＊｝＜＞？＿
        "manipulators" => [
          set_virtual_modifier(OYAYUBI_SHIFT_KEY_CODE, OYAYUBI_SHIFT_ON),
          # シフトありから並べること
          # ------------------------------
          # 親指シフト
          virtual_shift_key("u", OYAYUBI_SHIFT_ON, "え"),
          virtual_shift_key("j", OYAYUBI_SHIFT_ON, "お"),
          virtual_shift_key("p", OYAYUBI_SHIFT_ON, "ぬ"),
          virtual_shift_key("v", OYAYUBI_SHIFT_ON, "ね"),
          virtual_shift_key("y", OYAYUBI_SHIFT_ON, "ひ"),
          virtual_shift_key("r", OYAYUBI_SHIFT_ON, "ふ"),
          virtual_shift_key("s", OYAYUBI_SHIFT_ON, "へ"),
          virtual_shift_key("e", OYAYUBI_SHIFT_ON, "ほ"),
          virtual_shift_key("h", OYAYUBI_SHIFT_ON, "ま"),
          virtual_shift_key("i", OYAYUBI_SHIFT_ON, "み"),
          virtual_shift_key("n", OYAYUBI_SHIFT_ON, "む"),
          virtual_shift_key("t", OYAYUBI_SHIFT_ON, "め"),
          virtual_shift_key("k", OYAYUBI_SHIFT_ON, "も"),
          virtual_shift_key("o", OYAYUBI_SHIFT_ON, "や"),
          virtual_shift_key("semicolon", OYAYUBI_SHIFT_ON, "ゆ"),
          virtual_shift_key("g", OYAYUBI_SHIFT_ON, "よ"),
          virtual_shift_key("d", OYAYUBI_SHIFT_ON, "ら"),
          virtual_shift_key("m", OYAYUBI_SHIFT_ON, "ろ"),
          virtual_shift_key("l", OYAYUBI_SHIFT_ON, "わ"),
          virtual_shift_key("q", OYAYUBI_SHIFT_ON, "ぁ"),
          virtual_shift_key("a", OYAYUBI_SHIFT_ON, "ぃ"),
          virtual_shift_key("z", OYAYUBI_SHIFT_ON, "ぅ"),
          virtual_shift_key("x", OYAYUBI_SHIFT_ON, "ぇ"),
          virtual_shift_key("c", OYAYUBI_SHIFT_ON, "ぉ"),
          virtual_shift_key("b", OYAYUBI_SHIFT_ON, "ゃ"),
          virtual_shift_key("f", OYAYUBI_SHIFT_ON, "ゅ"),
          virtual_shift_key("w", OYAYUBI_SHIFT_ON, "゜"),
          virtual_shift_key("comma", OYAYUBI_SHIFT_ON, "・"),
          virtual_shift_key("period", OYAYUBI_SHIFT_ON, "ー"),
          virtual_shift_key("open_bracket", OYAYUBI_SHIFT_ON, "「"),
          virtual_shift_key("quote", OYAYUBI_SHIFT_ON, "」"),
          virtual_shift_key("1", OYAYUBI_SHIFT_ON, "!"),
          virtual_shift_key("2", OYAYUBI_SHIFT_ON, "double_quote"),
          virtual_shift_key("3", OYAYUBI_SHIFT_ON, "#"),
          virtual_shift_key("4", OYAYUBI_SHIFT_ON, "$"),
          virtual_shift_key("5", OYAYUBI_SHIFT_ON, "%"),
          virtual_shift_key("6", OYAYUBI_SHIFT_ON, "&"),
          virtual_shift_key("7", OYAYUBI_SHIFT_ON, "quote"),
          virtual_shift_key("8", OYAYUBI_SHIFT_ON, "("),
          virtual_shift_key("9", OYAYUBI_SHIFT_ON, ")"),
          virtual_shift_key("0", OYAYUBI_SHIFT_ON, "()"),
          virtual_shift_key("hyphen", OYAYUBI_SHIFT_ON, "="),
          virtual_shift_key("equal_sign", OYAYUBI_SHIFT_ON, "~"),
          virtual_shift_key("international3", OYAYUBI_SHIFT_ON, "|"),
          #         virtual_shift_key('open_bracket', OYAYUBI_SHIFT_ON, '`'),
          virtual_shift_key("close_bracket", OYAYUBI_SHIFT_ON, "{"),
          #         virtual_shift_key('semicolon', OYAYUBI_SHIFT_ON, '+'),
          #         virtual_shift_key('quote', OYAYUBI_SHIFT_ON, '*'),
          virtual_shift_key("backslash", OYAYUBI_SHIFT_ON, "}"),
          #         virtual_shift_key('comma', OYAYUBI_SHIFT_ON, '<'),
          #         virtual_shift_key('period', OYAYUBI_SHIFT_ON, '>'),
          #         virtual_shift_key('slash', OYAYUBI_SHIFT_ON, '?'),
          # ------------------------------
          # 左シフト
          map_key("a",["left_shift"], "Ａ"),
          map_key("b",["left_shift"], "Ｂ"),
          map_key("c",["left_shift"], "Ｃ"),
          map_key("d",["left_shift"], "Ｄ"),
          map_key("e",["left_shift"], "Ｅ"),
          map_key("f",["left_shift"], "Ｆ"),
          map_key("g",["left_shift"], "Ｇ"),
          map_key("h",["left_shift"], "Ｈ"),
          map_key("i",["left_shift"], "Ｉ"),
          map_key("j",["left_shift"], "Ｊ"),
          map_key("k",["left_shift"], "Ｋ"),
          map_key("l",["left_shift"], "Ｌ"),
          map_key("m",["left_shift"], "Ｍ"),
          map_key("n",["left_shift"], "Ｎ"),
          map_key("o",["left_shift"], "Ｏ"),
          map_key("p",["left_shift"], "Ｐ"),
          map_key("q",["left_shift"], "Ｑ"),
          map_key("r",["left_shift"], "Ｒ"),
          map_key("s",["left_shift"], "Ｓ"),
          map_key("t",["left_shift"], "Ｔ"),
          map_key("u",["left_shift"], "Ｕ"),
          map_key("v",["left_shift"], "Ｖ"),
          map_key("w",["left_shift"], "Ｗ"),
          map_key("x",["left_shift"], "Ｘ"),
          map_key("y",["left_shift"], "Ｙ"),
          map_key("z",["left_shift"], "Ｚ"),
          map_key("1",["left_shift"], "！"),
          map_key("2",["left_shift"], "＂"),
          map_key("3",["left_shift"], "＃"),
          map_key("4",["left_shift"], "＄"),
          map_key("5",["left_shift"], "％"),
          map_key("6",["left_shift"], "＆"),
          map_key("7",["left_shift"], "＇"),
          map_key("8",["left_shift"], "（"),
          map_key("9",["left_shift"], "）"),
          map_key("0",["left_shift"], "（）"),
          map_key("hyphen",["left_shift"], "＝"),
          map_key("equal_sign",["left_shift"], "〜"),
          map_key("international3",["left_shift"], "｜"),
          map_key("open_bracket",["left_shift"], "｀"),
          map_key("close_bracket",["left_shift"], "｛"),
          map_key("semicolon",["left_shift"], "＋"),
          map_key("quote",["left_shift"], "＊"),
          map_key("backslash",["left_shift"], "｝"),
          map_key("comma",["left_shift"], "＜"),
          map_key("period",["left_shift"], "＞"),
          map_key("slash",["left_shift"], "？"),
          # ------------------------------
          # 右シフト
          ## 古いキーボードではright_shiftは使えないので左と一緒にしておく
          map_key("a",["right_shift"], "Ａ"),
          map_key("b",["right_shift"], "Ｂ"),
          map_key("c",["right_shift"], "Ｃ"),
          map_key("d",["right_shift"], "Ｄ"),
          map_key("e",["right_shift"], "Ｅ"),
          map_key("f",["right_shift"], "Ｆ"),
          map_key("g",["right_shift"], "Ｇ"),
          map_key("h",["right_shift"], "Ｈ"),
          map_key("i",["right_shift"], "Ｉ"),
          map_key("j",["right_shift"], "Ｊ"),
          map_key("k",["right_shift"], "Ｋ"),
          map_key("l",["right_shift"], "Ｌ"),
          map_key("m",["right_shift"], "Ｍ"),
          map_key("n",["right_shift"], "Ｎ"),
          map_key("o",["right_shift"], "Ｏ"),
          map_key("p",["right_shift"], "Ｐ"),
          map_key("q",["right_shift"], "Ｑ"),
          map_key("r",["right_shift"], "Ｒ"),
          map_key("s",["right_shift"], "Ｓ"),
          map_key("t",["right_shift"], "Ｔ"),
          map_key("u",["right_shift"], "Ｕ"),
          map_key("v",["right_shift"], "Ｖ"),
          map_key("w",["right_shift"], "Ｗ"),
          map_key("x",["right_shift"], "Ｘ"),
          map_key("y",["right_shift"], "Ｙ"),
          map_key("z",["right_shift"], "Ｚ"),
          map_key("1",["right_shift"], "！"),
          map_key("2",["right_shift"], "＂"),
          map_key("3",["right_shift"], "＃"),
          map_key("4",["right_shift"], "＄"),
          map_key("5",["right_shift"], "％"),
          map_key("6",["right_shift"], "＆"),
          map_key("7",["right_shift"], "＇"),
          map_key("8",["right_shift"], "（"),
          map_key("9",["right_shift"], "）"),
          map_key("0",["right_shift"], "（）"),
          map_key("hyphen",["right_shift"], "＝"),
          map_key("equal_sign",["right_shift"], "〜"),
          map_key("international3",["right_shift"], "｜"),
          map_key("open_bracket",["right_shift"], "｀"),
          map_key("close_bracket",["right_shift"], "｛"),
          map_key("semicolon",["right_shift"], "＋"),
          map_key("quote",["right_shift"], "＊"),
          map_key("backslash",["right_shift"], "｝"),
          map_key("comma",["right_shift"], "＜"),
          map_key("period",["right_shift"], "＞"),
          map_key("slash",["right_shift"], "？"),
          # ------------------------------
          # シフトなし
          map_key("b",[], "あ"),
          map_key("k",[], "い"),
          map_key("j",[], "う"),
          map_key("s",[], "か"),
          map_key("semicolon",[], "き"),
          map_key("h",[], "く"),
          map_key("w",[], "け"),
          map_key("x",[], "こ"),
          map_key("v",[], "さ"),
          map_key("d",[], "し"),
          map_key("z",[], "す"),
          map_key("e",[], "せ"),
          map_key("q",[], "そ"),
          map_key("g",[], "た"),
          map_key("open_bracket",[], "ち"),
          map_key("y",[], "つ"),
          map_key("r",[], "て"),
          map_key("f",[], "と"),
          map_key("quote",[], "な"),
          map_key("c",[], "に"),
          map_key("i",[], "の"),
          map_key("a",[], "は"),
          map_key("p",[], "り"),
          map_key("m",[], "る"),
          map_key("slash",[], "れ"),
          map_key("o",[], "を"),
          map_key("u",[], "ん"),
          map_key("t",[], "ょ"),
          map_key("n",[], "っ"),
          map_key("l",[], "゛"),
          map_key("comma",[], "、"),
          map_key("period",[], "。"),
          map_key("delete_or_backspace",[], "delete"),
          map_key("1",[], "1"),
          map_key("2",[], "2"),
          map_key("3",[], "3"),
          map_key("4",[], "4"),
          map_key("5",[], "5"),
          map_key("6",[], "6"),
          map_key("7",[], "7"),
          map_key("8",[], "8"),
          map_key("9",[], "9"),
          map_key("0",[], "0"),
          map_key("hyphen",[], "-"),
          map_key("equal_sign",[], "^"),
          map_key("international3",[], "¥"),
          #         map_key('open_bracket',[], '@'),
          map_key("close_bracket",[], "["),
          #         map_key('semicolon',[], ';'),
          #         map_key('quote',[], ':'),
          map_key("backslash",[], "]"),
          #         map_key('comma',[], ','),
          #         map_key('period',[], '.'),
          #         map_key('slash',[], '/'),
          map_key("international1",[], "_"),
        ],
      },
      {
        "description" => '新JIS（説明）　shift-spacebarで半角spc　shift-英字で全角大文字　opt-英字で全角小文字　shift-0で"（）"',
        "manipulators" => [
          map_key("b",[], "あ"),  # 害のないダミー設定
        ],
      },
      {
        "description" => "新JIS（opt）　esc ＝＞ esc + eisuu",
        "manipulators" => [
          # シフトありから並べること
          map_key("escape",[], "escape_japanese_eisuu"),
        ],
      },      
      {
        "description" => "新JIS（opt）　数字を全角に　mainより優先度を上げて下さい (rev 0.1)",
        ## 半角数字と新JISで未使用キーの記号
        ## 1234567890-^\[]_ !"#$%&'()0=~|{}_
        "manipulators" => [
          # シフトありから並べること
          virtual_shift_key("1", OYAYUBI_SHIFT_ON, "！"),
          virtual_shift_key("2", OYAYUBI_SHIFT_ON, "double_quote"),
          virtual_shift_key("3", OYAYUBI_SHIFT_ON, "＃"),
          virtual_shift_key("4", OYAYUBI_SHIFT_ON, "＄"),
          virtual_shift_key("5", OYAYUBI_SHIFT_ON, "％"),
          virtual_shift_key("6", OYAYUBI_SHIFT_ON, "＆"),
          virtual_shift_key("7", OYAYUBI_SHIFT_ON, "quote"),
          virtual_shift_key("8", OYAYUBI_SHIFT_ON, "（"),
          virtual_shift_key("9", OYAYUBI_SHIFT_ON, "）"),
          virtual_shift_key("hyphen", OYAYUBI_SHIFT_ON, "＝"),
          virtual_shift_key("equal_sign", OYAYUBI_SHIFT_ON, "〜"),
          virtual_shift_key("international3", OYAYUBI_SHIFT_ON, "｜"),
          #         virtual_shift_key('open_bracket', OYAYUBI_SHIFT_ON, '｀'),
          virtual_shift_key("close_bracket", OYAYUBI_SHIFT_ON, "｛"),
          #         virtual_shift_key('semicolon', OYAYUBI_SHIFT_ON, '＋'),
          #         virtual_shift_key('quote', OYAYUBI_SHIFT_ON, '＊'),
          virtual_shift_key("backslash", OYAYUBI_SHIFT_ON, "｝"),
          #         virtual_shift_key('comma', OYAYUBI_SHIFT_ON, '＜'),
          #         virtual_shift_key('period', OYAYUBI_SHIFT_ON, '＞'),
          #         virtual_shift_key('slash', OYAYUBI_SHIFT_ON, '？'),
          virtual_shift_key("international1", OYAYUBI_SHIFT_ON, "＿"),
          map_key("1",[], "１"),
          map_key("2",[], "２"),
          map_key("3",[], "３"),
          map_key("4",[], "４"),
          map_key("5",[], "５"),
          map_key("6",[], "６"),
          map_key("7",[], "７"),
          map_key("8",[], "８"),
          map_key("9",[], "９"),
          map_key("0",[], "０"),
          map_key("hyphen",[], "ー"),
          map_key("equal_sign",[], "＾"),
          map_key("international3",[], "￥"),
          #         map_key('open_bracket',[], '＠'),
          map_key("close_bracket",[], "［"),
          #         map_key('semicolon',[], '；'),
          #         map_key('quote',[], '：'),
          map_key("backslash",[], "］"),
          #         map_key('comma',[], '，'),
          #         map_key('period',[], '．'),
          #         map_key('slash',[], '／'),
          map_key("international1",[], "＿"),
        ],
      },
    ],
  )
end

main

=begin
---------- メモ１
from:"キーコード名" (+ modifierKeys)
to:"打ちたい文字列"  ==>  KANA_MAP
    ==> [key()  ]
    ==>  ["キーコード名" (+ modifierKeys)]

---------- メモ２
main
    map_key("キーコード名", "打ちたい文字列")
    意味：map_key("b", "あ")        シフト無しで"b"を打って"あ"を出したい。

map_key(キーコード名, 打ちたい文字列)
    from：キーコード名
    to：KANA_MAP[打ちたい文字列]
    意味：KANA_MAP["あ"]　は　[key("3")]
    　　　「”かな入力”で"あ"を打つにはキーコード名"3"を（シフト無しで）１度打てば良い」とKANA_MAPに定義してある

key("3")
    「キーコード名"3"、シフトなし、リピートなし」をJSON表現に変換
=end
