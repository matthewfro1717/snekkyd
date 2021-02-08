package code;

class Keyword {

    static final keywords = [
        "func",
        "let",
        "mut",
        "true",
        "false",
        "if",
        "else", 
        "while",
        "return", 
        "import",
        "break",
        "continue",
        "null",
        "for",
        "in",
        "when"
    ];

    public static function isKeyword(s:String) {
        return keywords.contains(s);
    }
}