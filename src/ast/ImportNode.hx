package ast;

class ImportNode extends Node {

    public final path:String;

    public function new(path:String) {
        this.path = path;
    }

    override function toString():String {
        return 'import "$path";\r\n';
    }
}