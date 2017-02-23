# nim_autorun.nim
# This script checks the passed file for newer versions,
# then compiles and runs them.

import
  os,
  times  # needed to have the `>` operator avail. for the Times type returned by lastWriteTime

proc compileAndRun(fn: string) =
  let cmd = "nim c --cc:tcc --verbosity:0 --hints:off -r " & fn
  discard execShellCmd(cmd)


when isMainModule:
  let num_of_args = paramCount()
  if num_of_args == 1:
    let fn = paramStr(1)

    if existsFile(fn):
      var oldTimeStamp = getFileInfo(fn).lastWriteTime
      while true:
        sleep(2000)
        var newTimeStamp = getFileInfo(fn).lastWriteTime
        if newTimeStamp > oldTimeStamp:
          echo("―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― ", getClockStr())
          oldTimeStamp = newTimeStamp
          compileAndRun(fn)

    else:
      echo("Could not find file ", fn)

  else:
    echo("usage: nim_autorun <nim source file>")
    echo("The file will be watched for changes every second, then compiled and run.")
    echo("Please give the name of the .nim file to watch.")
