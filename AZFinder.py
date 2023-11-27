#!/usr/bin/python3

import os
import sys
import re
import getopt

cwd = os.getcwd()
pywd = os.path.dirname(os.path.realpath(__file__))

argList = sys.argv[1:]
if "hg19" in argList and "hg38" in argList:
	print("\n Error: Use only one of the two options 'hg19' or 'hg38'!")
	quit()
if "hg19" in argList:
	argList.remove("hg19")
if "hg38" in argList:
	argList.remove("hg38")

short_options = "hr:b"
long_options = ["help", "bamlist="]

try:
    options, args = getopt.getopt(argList, short_options, long_options)
except:
    print("\nError")
    quit()

hg19Args = []
hg38Args = []
for opt, value in options:
	if opt in ['-h', '--help']:
		print("""
		AZFinder

		Usage: python AZFinder {reference} --bamlist={your_bamlist}

		{reference} should be hg19 or hg38 depending on what reference genome your bam files are aligned to.
		{your_bamlist} is a file with your bam files, one per row
		""")
	elif opt in ['-b', '--bamlist']:
		hg19Args.append("=".join(['--bamlist',value]))
	elif opt in ['-b', '--bamlist']:
		hg38Args.append("=".join(['--bamlist',value]))

hg38Args = []
for opt, value in options:
	if opt in ['-b', '--bamlist']:
		hg38Args.append("=".join(['--bamlist',value]))


if "hg19" not in sys.argv and "hg38" not in sys.argv:
	print("\n		Use at least one of the two options 'hg19' or 'hg38'!\n")
	quit()
if "hg19" in sys.argv:
	os.system("Rscript " + pywd + "/01-scripts/AZFinder_hg19.R " + " ".join(hg19Args) + " " + pywd)
elif "hg38" in sys.argv:
	os.system("Rscript " + pywd + "/01-scripts/AZFinder_hg38.R " + " ".join(hg38Args) + " " + pywd)
