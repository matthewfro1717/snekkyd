package ast.datatypes;

class StringNode extends Node {

    public final value:String;

    public function new(value:String) {
        this.value = escape(value);
    }

    function escape(s):String {
        return StringTools.replace(s, "\"", "\\\"");
    }

    override function toString():String {
        return '"$value"';
    }
}