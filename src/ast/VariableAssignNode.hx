package ast;

class VariableAssignNode extends Node {

    public final name:String;
    public final value:Node;

    public function new(name:String, value:Node) {
        this.name = name;
        this.value = value;
    }

    override function toString():String {
        return '$name = $value;\r\n';
    }
}