import sys.io.File;
import haxe.io.Bytes;
import decompiler.Decompiler;

class SnekkyDecompiler {

    public static function decompile(byteCode:Bytes):String {
        final decompiler = new Decompiler(byteCode);
        return decompiler.decompile();   
    }

    public static function main() {
        final code = sys.io.File.getBytes(Sys.args()[0]);
        File.saveContent("decompiled.snek", decompile(code));
    }
}