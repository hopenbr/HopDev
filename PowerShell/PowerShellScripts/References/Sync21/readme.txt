 *****************************************************************************
 *                                  Sync 2.1                                 *
 *                                 2007-12-09                                *
 *                        Copyright 2007 Zach Scrivena                       *
 *                           zachscrivena@gmail.com                          *
 *                       http://syncdir.sourceforge.net/                     *
 *                                                                           *
 *                                RELEASE NOTES                              *
 *****************************************************************************

Sync is a simple command-line utility for performing one-way directory or
file synchronization. It synchronizes the specified target to match the
specified source. Only the target is modified.


MAIN FEATURES
-------------
 * FLEXIBLE FILE-MATCHING: Match files by combinations of name, size,
   last-modified time, and CRC-32 checksum; by default, (name,size,time,crc)
   are used.

 * FLEXIBLE FILE TIME COMPARISON: Specify a time-tolerance (in milliseconds)
   when matching files by their last-modified time.

 * FILENAME FILTERS: Use multiple GLOB or REGEX filters to include
   or exclude files based on their names or their relative pathnames.

 * SIMULATION MODE: Sync can be run to simulate file operations, so that
   the target directory is not modified.

 * UNATTENDED USAGE: With an appropriate choice of switches, Sync can be
   executed without user intervention.

 * LOG FILE: Sync can generate log files with automatic timestamps for
   convenient record-keeping.


SYSTEM REQUIREMENTS
-------------------
 A Java Runtime Environment (JRE 6+) is required. The latest version of the
 JRE can be downloaded from <http://java.sun.com/j2se>.


LICENSE
-------
 Sync is released with source code under the GNU General Public License
 (version 3). The license document can be found in license.txt.


INSTALLATION AND EXECUTION
--------------------------
 The Sync utility is downloaded as a single Zip file with the following
 contents:

 Sync.jar              Sync executable JAR archive
 readme.txt            Release notes (this file)
 license.txt           License document (GNU GPLv3)
 unix/Sync             Unix/Linux script for executing Sync
 windows/Sync.bat      Windows batch file for executing Sync
 src/                  Source files

 No installation is necessary --- just unzip the downloaded file and you are
 ready to go. Assuming that the executable JAR archive Sync.jar is in
 the current directory, simply execute the following at the command-line:

   java -jar Sync.jar

 Several pages of documentation (usage syntax, notes, and examples) should
 fill the screen. The use of the Windows batch file (windows/Sync.bat)
 or the Unix/Linux script (unix/Sync) is recommended because it enables
 you to simply execute Sync instead of java -jar Sync.jar.
 Further instructions are given in the respective files.


DOCUMENTATION: USAGE SYNTAX AND EXAMPLES
----------------------------------------
USAGE:  java -jar Sync.jar  <switches>  ["Source"]  ["Target"]

Synchronize ["Target"] to match ["Source"]. Only ["Target"] is modified.
By default, the filename, size, last-modified time, and CRC-32 checksum
are used for file-matching. The synchronization mode depends on ["Source"]:

 ["Source"] is a DIRECTORY: Match source and target directories recursively.
  Matched target files are time-synced and renamed if necessary,
  unmatched source files are copied to the target directory, and
  unmatched target files/directories are deleted.

 ["Source"] is a FILE: Match source and target files, ignoring filename.
  If files match, then the target file is time-synced and renamed if necessary.
  If target file does not exist, then the source file is copied to the target.

<Switches>:

 -s, --simulate        Simulate only; do not modify target
     --ignorewarnings  Ignore warnings; do not pause
 -l, --log:<"x">       Create log file x; if x is not specified,
                        "sync.yyyyMMdd-HHmmss.log" is used
 -r, --norecurse       Do not recurse into subdirectories

 -n, --noname          Do not use filename for file-matching
 -t, --notime          Do not use last-modified time for file-matching
 -c, --nocrc           Do not use CRC-32 checksum for file-matching

     --time:[x]        Use a x-millisecond time-tolerance for file-matching
                        (0-millisecond time-tolerance is used by default;
                         use --time:1000 or more to avoid mismatches across
                         different file systems)

     --rename:[y|n]    Always[y]/never[n] rename matched target files
     --synctime:[y|n]  ... synchronize time of matched target files
     --overwrite:[y|n] ... overwrite existing target files/directories
     --delete:[y|n]    ... delete unmatched target files/directories
     --force           Equivalent to the combination:
                        --rename:y --synctime:y --overwrite:y --delete:y

 A subset of source and/or target files/directories can be selected for
 synchronization using GLOB (or REGEX) filename filters. A file/directory is
 selected if it matches any of the "include" filters and none of the "exclude"
 filters.

 -i,  --include:["x"]   Include source and target files/directories with names
                         matching GLOB expression x
 -x,  --exclude:["x"]   Exclude source and target files/directories with names
                         matching GLOB expression x
 -is, --includesource:["x"]   Include source files/directories ...
 -xs, --excludesource:["x"]   Exclude source files/directories ...
 -it, --includetarget:["x"]   Include target files/directories ...
 -xt, --excludetarget:["x"]   Exclude target files/directories ...
 -p,  --path            Filter relative pathnames instead of filenames
                         (e.g. "work\report\jan.txt" instead of "jan.txt")
 -w,  --lower           Use lower case names for filtering
                         (e.g. "HelloWorld2007.JPG" ---> "helloworld2007.jpg")
      --regex           Use REGEX instead of GLOB filename filters
                         (see Java API for REGEX syntax)

      GLOB syntax:
       *    Match a string of 0 or more characters
       ?    Match exactly 1 character
      [ ]   Match exactly 1 character inside the brackets:
             [abc]       match a, b, or c
             [!abc]      match any character except a, b, or c (negation)
             [a-z0-9]    match any character a through z, or 0 through 9,
                          inclusive (range)
      { }   Match exactly 1 comma-delimited string inside the braces:
             {a,bc,def}  match either a, bc, or def

      To use a construct symbol (e.g. [, {, ?) as a literal character,
      insert a backslash before it, e.g. use \[ for the literal character [.
      Use \\ for the literal backslash character \.
      The file separator in Windows can be specified by \\ or /.

EXAMPLES:

 1. Synchronize target "C:\Backup" to look like source "C:\Original",
     matching files by (name,size,time,crc):
    java -jar Sync.jar "C:\Original" "C:\Backup"

 2. As in example 1, but never delete unmatched target files/directories:
    java -jar Sync.jar --delete:n "C:\Original" "C:\Backup"

 3. As in example 1, but match files by (name,size,time) with a time-tolerance
     of 2 seconds instead:
    java -jar Sync.jar --nocrc --time:2000 "C:\Original" "C:\Backup"

 4. As in example 1, but always rename and synchronize time of matched target
     files, overwrite existing target files, and delete unmatched target
     files/directories:
    java -jar Sync.jar --force "C:\Original" "C:\Backup"

 5. As in example 1, but synchronize only jpg and html files:
    java -jar Sync.jar --include:"*.{jpg,html}" "C:\Original" "C:\Backup"

 6. As in example 5, but skip files that begin with a tilde '~':
    java -jar Sync.jar --include:"*.{jpg,html}" --exclude:"~*"
     "C:\Original" "C:\Backup"


FEEDBACK?
---------
 Comments, suggestions, and bug reports are welcomed! Please send any
 feedback you have about Sync to <zachscrivena@gmail.com>, or visit
 the Sync homepage at <http://syncdir.sourceforge.net/> to post
 a message, bug report, or download the latest version of Sync.
