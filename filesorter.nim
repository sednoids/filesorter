import std/[os, strutils, tables]

var files: seq[string] = @[]
const 
    HOME_DIRECTORY = getHomeDir()
    ACCEPTED_FORMATS = [".png", 
    ".jpeg", 
    ".jpg", 
    ".webp", 
    ".gif", 
    ".psd", 
    ".doc", 
    ".docx", 
    ".pdf", 
    ".blend", 
    ".pptm", 
    ".mp4", 
    ".mkv", 
    ".mov", 
    ".mp3", 
    ".wav", 
    ".opus"]


for file in walkFiles("/home/emmanuelc/Downloads/*"):
    if ACCEPTED_FORMATS.contains(file):
        files.add(file)

const directoryToDest: OrderedTable[string, string] = {
    ".png", ".jpeg", ".jpg", ".webp", ".gif", ".psd": HOME_DIRECTORY / "Pictures",
    ".doc", ".docx", ".pdf", ".blend", ".pptm": HOME_DIRECTORY / "Documents",
    ".mp4", ".mkv", ".mov": HOME_DIRECTORY / "Videos",
    ".mp3", ".wav", ".opus": HOME_DIRECTORY / "Music"
}.toOrderedTable()

proc getFileFormat(file: string): string =
    var len = file.len
    var idx = file.rfind(".")

    if idx == -1:
        return ""

    return file[^(len - idx)..^1]

proc getFileName(file: string): string =
    var len = file.len
    var idx = file.rfind("/")

    return file[^(len - idx)..^1]


for file in files:
    try:
        var format: string = getFileFormat(file)

        if format == "":
            continue
        moveFile(file, directoryToDest[format] / getFileName(file))

    except KeyError:
        continue