# 
# Description: This script renames all mp3 files in the directory by adding an index at the beginning of the filename.
# Owner: Iurii Vlasenko
# License: MIT License
#
# MIT License
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.


# Get a list of all mp3 files in the directory
$files = Get-ChildItem -Path . -Filter *.mp3

# Shuffle the files in a random order
$files = $files | Get-Random -Count ($files.Count)

# Function to check and add index
function Rename-File {
    param (
        [string]$file,
        [int]$index
    )

    # Check if the first part is a number
    if ($file -match '^\d+_(.+)$') {
        # Replace the number with the index
        $newName = "${index}_$($matches[1])"
    } else {
        # Add the index to the beginning of the name
        $newName = "${index}_$file"
    }

    return $newName
}

# Rename the files
for ($i = 0; $i -lt $files.Count; $i++) {
    $file = $files[$i].Name
    $newName = Rename-File -file $file -index $i
    $fullNewName = Join-Path -Path $files[$i].DirectoryName -ChildPath $newName
    Rename-Item -LiteralPath $files[$i].FullName -NewName $fullNewName -Force
}

Write-Output "Files have been successfully renamed!"
