package ast;

class VariableNode extends Node {

    public final name:String;
    public final value:Node;

    public function new(name:String, value:Node) {
        this.name = name;
        this.value = value;
    }

    override function toString():String {
        return 'mut $name = $value;\r\n';
    }
}