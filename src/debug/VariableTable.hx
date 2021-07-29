package debug;

import haxe.io.BytesInput;
import haxe.io.Bytes;
import haxe.io.BytesOutput;

private typedef VariableEntry = {index:Int, start:Int, end:Int, name:String};

class VariableTable {

    final table:Array<VariableEntry> = [];

    public function new() {}
    
    public function resolveVariableName(index:Int):String {
        for (entry in table) {
            if (entry.index == index) {
                return entry.name;
            }
        }

        return "$" + 'var$index';
    }

    public function toByteCode():Bytes {
        final tableBytes = new BytesOutput();

        for (entry in table) {
            tableBytes.writeInt32(entry.index);
            tableBytes.writeInt32(entry.start);
            tableBytes.writeInt32(entry.end);
            tableBytes.writeInt32(Bytes.ofString(entry.name).length);
            tableBytes.writeString(entry.name);
        }

        final output = new BytesOutput();
        output.writeInt32(tableBytes.length);
        output.write(tableBytes.getBytes());

        return output.getBytes();
    }

    public function fromByteCode(byteCode:BytesInput):VariableTable {
        final tableSize = byteCode.readInt32();
        final startPosition = byteCode.position;

        while (byteCode.position < startPosition + tableSize) {
            final index = byteCode.readInt32();
            final start = byteCode.readInt32();
            final end = byteCode.readInt32();
            final nameLength = byteCode.readInt32();
            final name = byteCode.readString(nameLength);

            table.push({index: index, start: start, end: end, name: name});
        }

        return this;
    }
} 
