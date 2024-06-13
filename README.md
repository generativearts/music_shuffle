# MP3 File Shuffle Renamer

This PowerShell and Bash and JScript scripts Renames and Shuffle all MP3 files in a directory by adding an index to the beginning of the filename. If a filename already starts with a number followed by an underscore, the number is replaced with the new index. The files are also shuffled in a random order before renaming.

Ideal for those using an SD card in the car where the car's system sorts files alphabetically. This script allows you to create a randomized playlist for your car.


## Features

- Renames MP3 files by adding an index.
- Replaces the number at the beginning if the filename already starts with one.
- Shuffles the files in a random order before renaming.
- Handles filenames with special characters, such as `[ ]`.

## Requirements

- Windows PowerShell

## Usage

1. Clone this repository or download the `shuffle_mp3.ps1` or `_shuffle_mp3.sh` script.

2. Open PowerShell with administrator privileges.

3. Navigate to the directory where your MP3 files and the `shuffle_mp3.ps1` or `_shuffle_mp3.sh` or `_shuffle_mp3.js` script are located:
    ```powershell
    cd "Path\To\Your\Directory"
    ```

4. Run the script:
    ```powershell
    .\_shuffle_mp3.ps1
    ```

    ```bash
    .\_shuffle_mp3.sh
    ```

    ```cs
    cscript .\_shuffle_mp3.js
    ```

### Example

Assume you have the following MP3 files in your directory:
SongA.mp3
SongB.mp3
SongC.mp3
SongD.mp3

After running the script, the files might be renamed to:

1_SongA.mp3
2_SongB.mp3
3_SongC.mp3

After running the script nex one, the files might be renamed to:

1_SongB.mp3
2_SongC.mp3
3_SongA.mp3

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
Additional Notes:
Ensure the shuffle_mp3.ps1 script is in the same directory as the MP3 files you want to rename.
Running the script with administrator privileges may be necessary to avoid permission issues.

