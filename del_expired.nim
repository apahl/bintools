## Read <homedir>/expire.tsv and delete all files
## that have reached expiration date
## format is: Date\tFile\n
import os,       # existsFile, removeFile
       ospaths,  # getHomeDir, getTempDir, `/`
       times,    # getDateStr
       strutils  # replace
import csvtable

const
  expFn = getHomeDir() / "expire.tsv"
  tmpFn = getTempDir() / "expire.tsv"

when isMainModule:
  var
    csvIn: CSVTblReader
    csvOut: CSVTblWriter
  let
    curDate = getDateStr()  # 2017-10-11
    headers = csvIn.open(expFn, sep='\t')
  csvOut.open(tmpFn, headers, sep='\t')
  echo "Checking for expired files..."
  for dIn in csvIn:
    var fn = dIn["File"]
    fn = fn.replace("file://", by="")
    if cmp(curDate, dIn["Date"]) == 1:
      if existsFile(fn):
        removeFile(fn)
        echo "  - File ", fn, " removed (expired ", dIn["Date"], ")."
      else:
        echo "  * File ", fn, " should be removed but was not found."
    else:
      csvOut.writeRow(dIn)
  csvOut.close
  moveFile(tmpFn, expFn)
  echo "done."