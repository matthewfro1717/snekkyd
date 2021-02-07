package ast;

class IfNode extends Node {

    public final condition:Node;
    public final consequence:BlockNode;
    public final alternative:BlockNode;

    public function new(condition:Node, consequence:BlockNode, alternative:BlockNode) {
        this.condition = condition;
        this.consequence = consequence;
        this.alternative = alternative;
    }

    override function toString():String {
        final s = new StringBuf();

        s.add('if $condition ');
        s.add(consequence.toString());
        if (alternative.body.length > 0) {
            s.add(" else ");
            s.add(alternative.toString());
        };

        return s.toString();
    }
}