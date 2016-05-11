#!/usr/bin/env python3

import datetime
import os
import subprocess
import sys

def debug():
  with open(notes_file, "r") as fp:
    for line in fp:
      print(line.strip())

tmp_file = "/tmp/noteit.tmp"
notes_file = os.path.expanduser("~/notes.txt")
notes_file_bak = notes_file + ".noteit_bak"

if os.path.exists(notes_file):
  os.rename(notes_file, notes_file_bak)

hash_line = "=" * 70
date = datetime.datetime.now().strftime("%c")
name = "Joe Talbott <joetalbott@gmail.com>"

header = "{}\n# {} {}\n{}\n\n".format(hash_line, date, name, hash_line)

if os.path.exists(tmp_file):
  print("Temporary file '%s' already exists, exiting" % tmp_file)
  sys.exit(1)


subprocess.call('vim %s' % tmp_file, shell=True)

if os.path.exists(tmp_file):
  with open(notes_file, "w") as fp_out:
    fp_out.write(header)
    with open(tmp_file, "r") as fp_in:
      for line in fp_in:
        fp_out.write(line)
    fp_in.close()

    # blank line to separate entries
    fp_out.write("\n")

    # if there's existing data copy it over.
    if os.path.exists(notes_file_bak):
      with open(notes_file_bak, "r") as fp_old:
        for line in fp_old:
          fp_out.write(line)
      fp_old.close()

      os.remove(notes_file_bak)

  fp_out.close()

  os.remove(tmp_file)
  debug()
