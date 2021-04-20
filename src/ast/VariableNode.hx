package ast;

class VariableNode extends Node {

    public final name:String;
    public final value:Node;
    public var mutable = false;

    public function new(name:String, value:Node) {
        this.name = name;
        this.value = value;
    }

    override function toString():String {
        return if (mutable) {
            'mut $name = $value;\r\n';
        } else {
            'let $name = $value;\r\n';
        }
    }
}