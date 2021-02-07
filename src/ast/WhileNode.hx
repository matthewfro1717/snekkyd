package ast;

class WhileNode extends Node {

    public final condition:Node;
    public final body:BlockNode;

    public function new(condition:Node, body:BlockNode) {
        this.condition = condition;
        this.body = body;
    }

    override function toString():String {
        final s = new StringBuf();
        s.add('while $condition ');
        s.add(body.toString());

        return s.toString();
    }
}