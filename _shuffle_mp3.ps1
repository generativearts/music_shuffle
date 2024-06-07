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
