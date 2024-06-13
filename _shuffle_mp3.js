//
// Description: This script renames all mp3 files in the directory by adding an index at the beginning of the filename.
// Owner: Iurii Vlasenko
// License: MIT License
//
// MIT License
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

var fso = new ActiveXObject("Scripting.FileSystemObject");
var folder = fso.GetFolder(".");
var files = new Enumerator(folder.files);

var mp3Files = [];
for (; !files.atEnd(); files.moveNext()) {
    var file = files.item();
    if (file.Name.match(/\.mp3$/i)) {
        mp3Files.push(file);
    }
}

// Shuffle files in random order
mp3Files.sort(function () { return 0.5 - Math.random(); });

function renameFile(file, index) {
    var fileName = file.Name;
    var newFileName;

    var match = fileName.match(/^[0-9]+_(.*)$/);
    if (match) {
        newFileName = index + "_" + match[1];
    } else {
        newFileName = index + "_" + fileName;
    }

    // Print old and new file names
    WScript.Echo("Renaming file: '" + fileName + "' -> '" + newFileName + "'");

    // Check if the file name is different from the new name before renaming
    if (fileName !== newFileName) {
        var newPath = fso.BuildPath(file.ParentFolder, newFileName);
        file.Move(newPath);
    }
}

// Rename files
for (var i = 0; i < mp3Files.length; i++) {
    renameFile(mp3Files[i], i);
}

WScript.Echo("Files successfully renamed!");
