#!/usr/bin/env ruby

# You can generate json by executing the following command on Terminal.
#
# $ ruby ./japanese_JIS_X_6004.json.rb
#
## todo
## ANSIモード
## JISキーボードを条件に入れる？


require "json"
require_relative "../lib/karabiner.rb"

########################################
# 左シフトのキーコード
LEFT_SHIFT_KEY_CODE = "left_shift".freeze
# 右シフトのキーコード
RIGHT_SHIFT_KEY_CODE = "right_shift".freeze
# 親指シフトのキーコード
OYAYUBI_SHIFT_KEY_CODE = "spacebar".freeze
OYAYUBI_SHIFT_ON = "spacebar_on".freeze
########################################
# 有効になる条件

CONDITIONS = [
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
# ローマ字入力の定義

def key(key_code)
  {
    "key_code" => key_code,
    "repeat" => false,
  }
end

def key_with_shift(key_code)
  {
    "key_code" => key_code,
    "modifiers" => [
      "left_shift",
    ],
    "repeat" => false,
  }
end

def key_with_option(key_code)
  {
    "key_code" => key_code,
    "modifiers" => [
      "option",
    ],
    "repeat" => false,
  }
end

def key_with_option_shift(key_code)
  {
    "key_code" => key_code,
    "modifiers" => [
      "option", "left_shift",
    ],
    "repeat" => false,
  }
end

def zenkaku_eiji()
  {
    "key_code" => "l",
    "modifiers" => [
      "left_control", "left_shift",
    ],
    "repeat" => false,
  }
end

def hiragana()
  {
    "key_code" => "j",
    "modifiers" => [
      "left_control", "left_shift",
    ],
    "repeat" => false,
  }
end

def key_array_hankaku(key_code)
  [key("japanese_eisuu"), key(key_code), key("japanese_kana")]
end

def key_array_with_shift_hankaku(key_code)
  [key("japanese_eisuu"), key_with_shift(key_code), key("japanese_kana")]
end


def key_array_with_shift_zenkaku(key_code)
  [zenkaku_eiji(), key_with_shift(key_code), hiragana()]
end


KANA_MAP = {
## 全角 ######################################
  "あ" => [key("3")],
  "い" => [key("e")],
  "う" => [key("4")],
  "え" => [key("5")],
  "お" => [key("6")],
  "ぁ" => [key_with_shift("3")],
  "ぃ" => [key_with_shift("e")],
  "ぅ" => [key_with_shift("4")],
  "ぇ" => [key_with_shift("5")],
  "ぉ" => [key_with_shift("6")],
  "か" => [key("t")],
  "き" => [key("g")],
  "く" => [key("h")],
  "け" => [key("quote")],
  "こ" => [key("b")],
  "さ" => [key("x")],
  "し" => [key("d")],
  "す" => [key("r")],
  "せ" => [key("p")],
  "そ" => [key("c")],
  "た" => [key("q")],
  "ち" => [key("a")],
  "つ" => [key("z")],
  "っ" => [key_with_shift("z")],
  "て" => [key("w")],
  "と" => [key("s")],
  "な" => [key("u")],
  "に" => [key("i")],
  "ぬ" => [key("1")],
  "ね" => [key("comma")],
  "の" => [key("k")],
  "は" => [key("f")],
  "ひ" => [key_with_shift("v")],
  "ふ" => [key_with_shift("2")],
  "へ" => [key_with_shift("equal_sign")],
  "ほ" => [key_with_shift("hyphen")],
  "ま" => [key_with_shift("j")],
  "み" => [key_with_shift("n")],
  "む" => [key("backslash")],
  "め" => [key("slash")],
  "も" => [key_with_shift("m")],
  "や" => [key("7")],
  "ゆ" => [key("8")],
  "よ" => [key("9")],
  "ゃ" => [key_with_shift("7")],
  "ゅ" => [key_with_shift("8")],
  "ょ" => [key_with_shift("9")],
  "ら" => [key("o")],
  "り" => [key("l")],
  "る" => [key("period")],
  "れ" => [key("semicolon")],
  "ろ" => [key("international1")],
  "わ" => [key("0")],
  "を" => [key_with_shift("0")],
  "ん" => [key("y")],
  "゛" => [key("open_bracket")],
  "゜" => [key("close_bracket")],
  "、" => [key_with_shift("comma")],
  "。" => [key_with_shift("period")],
  "ー" => [key_with_shift("international3")],
  "「" => [key_with_shift("close_bracket")],
  "」" => [key_with_shift("backslash")],
  "・" => [key_with_shift("slash")],
  "１" => [key_with_option("1")],
  "２" => [key_with_option("2")],
  "３" => [key_with_option("3")],
  "４" => [key_with_option("4")],
  "５" => [key_with_option("5")],
  "６" => [key_with_option("6")],
  "７" => [key_with_option("7")],
  "８" => [key_with_option("8")],
  "９" => [key_with_option("9")],
  "０" => [key_with_option("0")],
  "＾" => [key_with_option("equal_sign")],
  "￥" => [key_with_option("international3")],
  "＠" => [key_with_option("open_bracket")],
  "［" => [key_with_option("close_bracket")],
  "；" => [key_with_option("semicolon")],
  "：" => [key_with_option("quote")],
  "］" => [key_with_option("backslash")],
  "，" => [key_with_option("comma")],
  "．" => [key_with_option("period")],
  "／" => [key_with_option("slash")],
  "＿" => [key_with_option("international1")],
  "！" => [key_with_option_shift("1")],
  "”" => [key_with_option_shift("2")],
  "＃" => [key_with_option_shift("3")],
  "＄" => [key_with_option_shift("4")],
  "％" => [key_with_option_shift("5")],
  "＆" => [key_with_option_shift("6")],
  "＇" => [key_with_option_shift("7")],
  "（" => [key_with_option_shift("8")],
  "）" => [key_with_option_shift("9")],
  "＝" => [key_with_option_shift("hyphen")],
  "〜" => [key_with_option_shift("equal_sign")],
  "｜" => [key_with_option_shift("international3")],
  "｀" => [key_with_option_shift("open_bracket")],
  "｛" => [key_with_option_shift("close_bracket")],
  "＋" => [key_with_option_shift("semicolon")],
  "＊" => [key_with_option_shift("quote")],
  "｝" => [key_with_option_shift("backslash")],
  "＜" => [key_with_option_shift("comma")],
  "＞" => [key_with_option_shift("period")],
  "？" => [key_with_option_shift("slash")],
  "Ａ" => key_array_with_shift_zenkaku("a"),
  "Ｂ" => key_array_with_shift_zenkaku("b"),
  "Ｃ" => key_array_with_shift_zenkaku("c"),
  "Ｄ" => key_array_with_shift_zenkaku("d"),
  "Ｅ" => key_array_with_shift_zenkaku("e"),
  "Ｆ" => key_array_with_shift_zenkaku("f"),
  "Ｇ" => key_array_with_shift_zenkaku("g"),
  "Ｈ" => key_array_with_shift_zenkaku("h"),
  "Ｉ" => key_array_with_shift_zenkaku("i"),
  "Ｊ" => key_array_with_shift_zenkaku("j"),
  "Ｋ" => key_array_with_shift_zenkaku("k"),
  "Ｌ" => key_array_with_shift_zenkaku("l"),
  "Ｍ" => key_array_with_shift_zenkaku("m"),
  "Ｎ" => key_array_with_shift_zenkaku("n"),
  "Ｏ" => key_array_with_shift_zenkaku("o"),
  "Ｐ" => key_array_with_shift_zenkaku("p"),
  "Ｑ" => key_array_with_shift_zenkaku("q"),
  "Ｒ" => key_array_with_shift_zenkaku("r"),
  "Ｓ" => key_array_with_shift_zenkaku("s"),
  "Ｔ" => key_array_with_shift_zenkaku("t"),
  "Ｕ" => key_array_with_shift_zenkaku("u"),
  "Ｖ" => key_array_with_shift_zenkaku("v"),
  "Ｗ" => key_array_with_shift_zenkaku("w"),
  "Ｘ" => key_array_with_shift_zenkaku("x"),
  "Ｙ" => key_array_with_shift_zenkaku("y"),
  "Ｚ" => key_array_with_shift_zenkaku("z"),

## 半角 ######################################
  "1" => key_array_hankaku("1"),
  "2" => key_array_hankaku("2"),
  "3" => key_array_hankaku("3"),
  "4" => key_array_hankaku("4"),
  "5" => key_array_hankaku("5"),
  "6" => key_array_hankaku("6"),
  "7" => key_array_hankaku("7"),
  "8" => key_array_hankaku("8"),
  "9" => key_array_hankaku("9"),
  "0" => key_array_hankaku("0"),
  "-" => key_array_hankaku("hyphen"),
  "^" => key_array_hankaku("equal_sign"),
  "¥" => key_array_hankaku("international3"),
  "@" => key_array_hankaku("open_bracket"),
  "[" => key_array_hankaku("close_bracket"),
  ";" => key_array_hankaku("semicolon"),
  ":" => key_array_hankaku("quote"),
  "]" => key_array_hankaku("backslash"),
  "," => key_array_hankaku("comma"),
  "." => key_array_hankaku("period"),
  "/" => key_array_hankaku("slash"),
  "_" => key_array_hankaku("international1"),
  "!" => key_array_with_shift_hankaku("1"),
  '"' => key_array_with_shift_hankaku("2"),
  "#" => key_array_with_shift_hankaku("3"),
  "$" => key_array_with_shift_hankaku("4"),
  "%" => key_array_with_shift_hankaku("5"),
  "&" => key_array_with_shift_hankaku("6"),
  '\'' => key_array_with_shift_hankaku("7"),
  "(" => key_array_with_shift_hankaku("8"),
  ")" => key_array_with_shift_hankaku("9"),
  "=" => key_array_with_shift_hankaku("hyphen"),
  "~" => key_array_with_shift_hankaku("equal_sign"),
  "|" => key_array_with_shift_hankaku("international3"),
  "`" => key_array_with_shift_hankaku("open_bracket"),
  "{" => key_array_with_shift_hankaku("close_bracket"),
  "+" => key_array_with_shift_hankaku("semicolon"),
  "*" => key_array_with_shift_hankaku("quote"),
  "}" => key_array_with_shift_hankaku("backslash"),
  "<" => key_array_with_shift_hankaku("comma"),
  ">" => key_array_with_shift_hankaku("period"),
  "?" => key_array_with_shift_hankaku("slash"),
  " " => key_array_with_shift_hankaku("spacebar"),
## 特殊 ######################################
  "escape_japanese_eisuu" => [key("escape"), key("japanese_eisuu")],
  "escape" => [key("escape")],
  "（）" => [key_with_option_shift("8"), key_with_option_shift("9"), key("left_arrow")],
  "()" => [key("japanese_eisuu"), key_with_shift("8"), key_with_shift("9"), key("left_arrow"), key("japanese_kana")],
  "`+*<>?" => [key("japanese_eisuu"), key_with_shift("open_bracket"), key_with_shift("semicolon"), key_with_shift("quote"), key_with_shift("comma"), key_with_shift("period"), key_with_shift("slash"), key("japanese_kana")],
# カナ入力ではoption-,option-shift-は全角の英字を出す。
#  '？' => [key_with_option('slash)],
}.freeze

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
        ## ！”＃＄％＆’（）０＝〜｜｀｛＋＊｝＜＞？＿
        "manipulators" => [
          virtualModifier(OYAYUBI_SHIFT_KEY_CODE, OYAYUBI_SHIFT_ON),
          # シフトありから並べること
          # ------------------------------
          # 親指シフト
          oyayubi_shift_key("u", "え"),
          oyayubi_shift_key("j", "お"),
          oyayubi_shift_key("p", "ぬ"),
          oyayubi_shift_key("v", "ね"),
          oyayubi_shift_key("y", "ひ"),
          oyayubi_shift_key("r", "ふ"),
          oyayubi_shift_key("s", "へ"),
          oyayubi_shift_key("e", "ほ"),
          oyayubi_shift_key("h", "ま"),
          oyayubi_shift_key("i", "み"),
          oyayubi_shift_key("n", "む"),
          oyayubi_shift_key("t", "め"),
          oyayubi_shift_key("k", "も"),
          oyayubi_shift_key("o", "や"),
          oyayubi_shift_key("semicolon", "ゆ"),
          oyayubi_shift_key("g", "よ"),
          oyayubi_shift_key("d", "ら"),
          oyayubi_shift_key("m", "ろ"),
          oyayubi_shift_key("l", "わ"),
          oyayubi_shift_key("q", "ぁ"),
          oyayubi_shift_key("a", "ぃ"),
          oyayubi_shift_key("z", "ぅ"),
          oyayubi_shift_key("x", "ぇ"),
          oyayubi_shift_key("c", "ぉ"),
          oyayubi_shift_key("b", "ゃ"),
          oyayubi_shift_key("f", "ゅ"),
          oyayubi_shift_key("w", "゜"),
          oyayubi_shift_key("comma", "・"),
          oyayubi_shift_key("period", "ー"),
          oyayubi_shift_key("open_bracket", "「"),
          oyayubi_shift_key("quote", "」"),
          oyayubi_shift_key("1", "!"),
          oyayubi_shift_key("2", '"'),
          oyayubi_shift_key("3", "#"),
          oyayubi_shift_key("4", "$"),
          oyayubi_shift_key("5", "%"),
          oyayubi_shift_key("6", "&"),
          oyayubi_shift_key("7", '\''),
          oyayubi_shift_key("8", "("),
          oyayubi_shift_key("9", ")"),
          oyayubi_shift_key("0", "()"),
          oyayubi_shift_key("hyphen", "="),
          oyayubi_shift_key("equal_sign", "~"),
          oyayubi_shift_key("international3", "|"),
          #         oyayubi_shift_key('open_bracket', '`'),
          oyayubi_shift_key("close_bracket", "{"),
          #         oyayubi_shift_key('semicolon', '+'),
          #         oyayubi_shift_key('quote', '*'),
          oyayubi_shift_key("backslash", "}"),
          #         oyayubi_shift_key('comma', '<'),
          #         oyayubi_shift_key('period', '>'),
          #         oyayubi_shift_key('slash', '?'),
          # ------------------------------
          # 左シフト
          left_shift_key("a", "Ａ"),
          left_shift_key("b", "Ｂ"),
          left_shift_key("c", "Ｃ"),
          left_shift_key("d", "Ｄ"),
          left_shift_key("e", "Ｅ"),
          left_shift_key("f", "Ｆ"),
          left_shift_key("g", "Ｇ"),
          left_shift_key("h", "Ｈ"),
          left_shift_key("i", "Ｉ"),
          left_shift_key("j", "Ｊ"),
          left_shift_key("k", "Ｋ"),
          left_shift_key("l", "Ｌ"),
          left_shift_key("m", "Ｍ"),
          left_shift_key("n", "Ｎ"),
          left_shift_key("o", "Ｏ"),
          left_shift_key("p", "Ｐ"),
          left_shift_key("q", "Ｑ"),
          left_shift_key("r", "Ｒ"),
          left_shift_key("s", "Ｓ"),
          left_shift_key("t", "Ｔ"),
          left_shift_key("u", "Ｕ"),
          left_shift_key("v", "Ｖ"),
          left_shift_key("w", "Ｗ"),
          left_shift_key("x", "Ｘ"),
          left_shift_key("y", "Ｙ"),
          left_shift_key("z", "Ｚ"),
          left_shift_key("1", "！"),
          left_shift_key("2", "＂"),
          left_shift_key("3", "＃"),
          left_shift_key("4", "＄"),
          left_shift_key("5", "％"),
          left_shift_key("6", "＆"),
          left_shift_key("7", "＇"),
          left_shift_key("8", "（"),
          left_shift_key("9", "）"),
          left_shift_key("0", "（）"),
          left_shift_key("hyphen", "＝"),
          left_shift_key("equal_sign", "～"),
          left_shift_key("international3", "｜"),
          left_shift_key("open_bracket", "｀"),
          left_shift_key("close_bracket", "｛"),
          left_shift_key("semicolon", "＋"),
          left_shift_key("quote", "＊"),
          left_shift_key("backslash", "｝"),
          left_shift_key("comma", "＜"),
          left_shift_key("period", "＞"),
          left_shift_key("slash", "？"),
          # ------------------------------
          # 右シフト
          right_shift_key("a", "Ａ"),
          right_shift_key("b", "Ｂ"),
          right_shift_key("c", "Ｃ"),
          right_shift_key("d", "Ｄ"),
          right_shift_key("e", "Ｅ"),
          right_shift_key("f", "Ｆ"),
          right_shift_key("g", "Ｇ"),
          right_shift_key("h", "Ｈ"),
          right_shift_key("i", "Ｉ"),
          right_shift_key("j", "Ｊ"),
          right_shift_key("k", "Ｋ"),
          right_shift_key("l", "Ｌ"),
          right_shift_key("m", "Ｍ"),
          right_shift_key("n", "Ｎ"),
          right_shift_key("o", "Ｏ"),
          right_shift_key("p", "Ｐ"),
          right_shift_key("q", "Ｑ"),
          right_shift_key("r", "Ｒ"),
          right_shift_key("s", "Ｓ"),
          right_shift_key("t", "Ｔ"),
          right_shift_key("u", "Ｕ"),
          right_shift_key("v", "Ｖ"),
          right_shift_key("w", "Ｗ"),
          right_shift_key("x", "Ｘ"),
          right_shift_key("y", "Ｙ"),
          right_shift_key("z", "Ｚ"),
          right_shift_key("1", "！"),
          right_shift_key("2", "＂"),
          right_shift_key("3", "＃"),
          right_shift_key("4", "＄"),
          right_shift_key("5", "％"),
          right_shift_key("6", "＆"),
          right_shift_key("7", "＇"),
          right_shift_key("8", "（"),
          right_shift_key("9", "）"),
          right_shift_key("0", "（）"),
          right_shift_key("hyphen", "＝"),
          right_shift_key("equal_sign", "～"),
          right_shift_key("international3", "｜"),
          right_shift_key("open_bracket", "｀"),
          right_shift_key("close_bracket", "｛"),
          right_shift_key("semicolon", "＋"),
          right_shift_key("quote", "＊"),
          right_shift_key("backslash", "｝"),
          right_shift_key("comma", "＜"),
          right_shift_key("period", "＞"),
          right_shift_key("slash", "？"),
          # ------------------------------
          # シフトなし
          normal_key("b", "あ"),
          normal_key("k", "い"),
          normal_key("j", "う"),
          normal_key("s", "か"),
          normal_key("semicolon", "き"),
          normal_key("h", "く"),
          normal_key("w", "け"),
          normal_key("x", "こ"),
          normal_key("v", "さ"),
          normal_key("d", "し"),
          normal_key("z", "す"),
          normal_key("e", "せ"),
          normal_key("q", "そ"),
          normal_key("g", "た"),
          normal_key("open_bracket", "ち"),
          normal_key("y", "つ"),
          normal_key("r", "て"),
          normal_key("f", "と"),
          normal_key("quote", "な"),
          normal_key("c", "に"),
          normal_key("i", "の"),
          normal_key("a", "は"),
          normal_key("p", "り"),
          normal_key("m", "る"),
          normal_key("slash", "れ"),
          normal_key("o", "を"),
          normal_key("u", "ん"),
          normal_key("t", "ょ"),
          normal_key("n", "っ"),
          normal_key("l", "゛"),
          normal_key("comma", "、"),
          normal_key("period", "。"),
          normal_key("delete_or_backspace", "delete"),
          normal_key("1", "1"),
          normal_key("2", "2"),
          normal_key("3", "3"),
          normal_key("4", "4"),
          normal_key("5", "5"),
          normal_key("6", "6"),
          normal_key("7", "7"),
          normal_key("8", "8"),
          normal_key("9", "9"),
          normal_key("0", "0"),
          normal_key("hyphen", "-"),
          normal_key("equal_sign", "^"),
          normal_key("international3", "¥"),
          #         normal_key('open_bracket', '@'),
          normal_key("close_bracket", "["),
          #         normal_key('semicolon', ';'),
          #         normal_key('quote', ':'),
          normal_key("backslash", "]"),
          #         normal_key('comma', ','),
          #         normal_key('period', '.'),
          #         normal_key('slash', '/'),
          normal_key("international1", "_"),
        ],
      },
      {
        "description" => '新JIS（説明）　shift-spacebarで半角spc　shift-英字で全角大文字　opt-英字で全角小文字　shift-0で"（）"',
        "manipulators" => [
          normal_key("b", "あ"),  # 害のないダミー設定
        ],
      },
      {
        "description" => "新JIS（opt）　esc ＝＞ esc + eisuu",
        "manipulators" => [
          # シフトありから並べること
          normal_key("escape", "escape_japanese_eisuu"),
        ],
      },      
      {
        "description" => "新JIS（opt）　数字を全角に　mainより優先度を上げて下さい (rev 0.1)",
        ## 半角数字と新JISで未使用キーの記号
        ## 1234567890-^\[]_ !"#$%&'()0=~|{}_
        "manipulators" => [
          # シフトありから並べること
          oyayubi_shift_key("1", "！"),
          oyayubi_shift_key("2", "”"),
          oyayubi_shift_key("3", "＃"),
          oyayubi_shift_key("4", "＄"),
          oyayubi_shift_key("5", "％"),
          oyayubi_shift_key("6", "＆"),
          oyayubi_shift_key("7", "’"),
          oyayubi_shift_key("8", "（"),
          oyayubi_shift_key("9", "）"),
          oyayubi_shift_key("hyphen", "＝"),
          oyayubi_shift_key("equal_sign", "〜"),
          oyayubi_shift_key("international3", "｜"),
          #         oyayubi_shift_key('open_bracket', '｀'),
          oyayubi_shift_key("close_bracket", "｛"),
          #         oyayubi_shift_key('semicolon', '＋'),
          #         oyayubi_shift_key('quote', '＊'),
          oyayubi_shift_key("backslash", "｝"),
          #         oyayubi_shift_key('comma', '＜'),
          #         oyayubi_shift_key('period', '＞'),
          #         oyayubi_shift_key('slash', '？'),
          oyayubi_shift_key("international1", "＿"),
          normal_key("1", "１"),
          normal_key("2", "２"),
          normal_key("3", "３"),
          normal_key("4", "４"),
          normal_key("5", "５"),
          normal_key("6", "６"),
          normal_key("7", "７"),
          normal_key("8", "８"),
          normal_key("9", "９"),
          normal_key("0", "０"),
          normal_key("hyphen", "ー"),
          normal_key("equal_sign", "＾"),
          normal_key("international3", "￥"),
          #         normal_key('open_bracket', '＠'),
          normal_key("close_bracket", "［"),
          #         normal_key('semicolon', '；'),
          #         normal_key('quote', '：'),
          normal_key("backslash", "］"),
          #         normal_key('comma', '，'),
          #         normal_key('period', '．'),
          #         normal_key('slash', '／'),
          normal_key("international1", "＿"),
        ],
      },
      {
        "description" => '新JIS（opt）　shift-international1で  `+*<>?  を打ちます。（どうしても半角で打ちたいなら）(rev 0.1)',
        "manipulators" => [
          # シフトありから並べること
          oyayubi_shift_key("international1", "`+*<>?"),
          left_shift_key("international1", "`+*<>?"),
          right_shift_key("international1", "`+*<>?"),
        ],
      },      

    ],
  )
end

# You cannot specify multiple items(set_variable & key_code) into one to entry.
def virtualModifier(key, var)
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
        "name" => var,
        "value" => 1,
        },
        "lazy" => true
      },
    ],
    "to_after_key_up" => [
      {
              "set_variable" => {
                "name" => var,
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

def normal_key(key, char)
  {
    "type" => "basic",
    "from" => {
      "key_code" => key,
    },
    "to" => KANA_MAP[char],
    "conditions" => CONDITIONS,
  }
end

def shift_key(shiftKey, key, char)
  {
    "type" => "basic",
    "from" => {
      "key_code" => key,
      "modifiers" => {
        "mandatory" => [shiftKey],
        "optional" => ["any"],
      },
    },
    "to" => KANA_MAP[char],
    "conditions" => CONDITIONS,
  }
end

def virtual_shift_key(shiftVar, key, char)
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
    "conditions" => CONDITIONS + [{
                                                            "type" => "variable_if",
                                                            "name" => shiftVar,
                                                            "value" => 1,
                                                        }]
  }
end

def simultaneous_shift_key(shiftKey, key, char)
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
    "conditions" => CONDITIONS,
  }
end

## 古いキーボードでは使えないので左と一緒にしておく
def right_shift_key(key, char)
  shift_key(RIGHT_SHIFT_KEY_CODE, key, char)
end

def left_shift_key(key, char)
  shift_key(LEFT_SHIFT_KEY_CODE, key, char)
end

def oyayubi_shift_key(key, char)
  virtual_shift_key(OYAYUBI_SHIFT_ON, key, char)
## 同時押しが好きな人はこちら
## simultaneous_shift_key(LEFT_SHIFT_KEY_CODE, key, char)
end

main
