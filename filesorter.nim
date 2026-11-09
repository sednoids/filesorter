import std/[os, strutils, tables, strformat]

const
  HOMEDIR = getHomeDir()
  IMAGE_FORMATS = @[
   ".png",
   ".jpeg",
   ".jpg",
   ".webp",
   ".gif",
   ".psd"
  ]
  DOC_FORMATS = @[
   ".doc",
   ".docx",
   ".pdf",
   ".blend",
   ".pptm"
  ]
  VIDEO_FORMATS = @[
   ".mp4",
   ".mkv",
   ".mov"
  ]
  AUDIO_FORMATS = @[
   ".mp3",
   ".wav",
   ".opus"    
  ]
  ALL_FORMATS = IMAGE_FORMATS & DOC_FORMATS & VIDEO_FORMATS & AUDIO_FORMATS

proc getFileExtension(file: string): string =
  var fileLength: int = file.len
  var dotExtensionIndex: int = file.rfind(".")

  if dotExtensionIndex == -1:
    return "" # if there is no dot followed by the file extension
  
  return file[^(fileLength - dotExtensionIndex)..^1]

proc getFileName(file: string): string =
  var fileLength: int = file.len
  var dotExtensionIndex: int  = file.rfind("/")

  if dotExtensionIndex == -1:
    return ""
  return file[^(fileLength - dotExtensionIndex)..^1]

proc fileExtensionType(format: string): seq[string]  =
  if format in IMAGE_FORMATS:
     return IMAGE_FORMATS
  elif format in DOC_FORMATS:
    return DOC_FORMATS
  elif format in VIDEO_FORMATS:
    return VIDEO_FORMATS
  elif format in AUDIO_FORMATS:
    return AUDIO_FORMATS

proc moveFromDirToDest() =
  var DIRECTORY_TO_DEST = {
    IMAGE_FORMATS: HOMEDIR / "Pictures",
    DOC_FORMATS: HOMEDIR / "Documents",
    VIDEO_FORMATS: HOMEDIR / "Videos",
    AUDIO_FORMATS: HOMEDIR / "Music"
  }.toOrderedTable()

  for file in walkFiles(HOMEDIR / "Downloads/*"):
     var fileExtension: string = getFileExtension(file)
     var fileExtensionType: seq[string] = fileExtensionType(fileExtension)
  
     if fileExtension in ALL_FORMATS:
       moveFile(file, DIRECTORY_TO_DEST.getOrDefault(fileExtensionType) / getFileName(file))

moveFromDirToDest()
