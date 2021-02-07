package ast;

class ReturnNode extends Node {

    public final returnValue:Node;

    public function new(returnValue:Node) {
        this.returnValue = returnValue;
    }

    override function toString():String {
        final s = new StringBuf();
        s.add("return");
        if (returnValue != null) {
            s.add(' $returnValue;');
        } else {
            s.add(";");
        }

        return s.toString();
    }
}