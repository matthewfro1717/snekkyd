import sys.io.File;
import decompiler.Decompiler;

class SnekkyDecompiler {

    public static function main() {
        final code = File.getBytes(Sys.args()[0]);
        final outDir = Sys.args()[1];
        final decompiler = new Decompiler(code);
        decompiler.decompile(outDir);   
    }
}