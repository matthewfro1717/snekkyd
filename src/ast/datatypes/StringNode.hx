package ast.datatypes;

class StringNode extends Node {

    public final value:String;

    public function new(value:String) {
        this.value = escape(value);
    }

    function escape(s):String {
        var t = StringTools.replace(s, "\\", "\\\\");
        t = StringTools.replace(t, "\"", "\\\"");
        t = StringTools.replace(t, "\t", "\\t");
        t = StringTools.replace(t, "\n", "\\n");
        t = StringTools.replace(t, "\r", "\\r");
        t = StringTools.replace(t, "\u0008", "\\b");
        t = StringTools.replace(t, "\u000C", "\\f");
        return t;
    }

    override function toString():String {
        return '"$value"';
    }
}