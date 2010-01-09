{include resources/header.md}
{set-property title "ASDF-Binary-Locations"}

<div class="contents">
<div class="system-links">

  * [User's Guide][ug]
  * [Mailing Lists][3]
  * [Getting it][4]
  * [Documentation][5]
  * [News][6]
  * [Changelog][7]

   [3]: #mailing-lists
   [4]: #downloads
   [5]: documentation/ (documentation link)
   [6]: #news
   [7]: changelog.html

</div>
<div class="system-description">

### What it is

**A**SDF-**B**inary-**L**ocations is an [ASDF-Extension][]
that makes it easy to specify where your Common Lisp binaries
(FASL files) should go. If you don't want to specify, then
not to worry: ABL also provides intelligent defaults.

   [8]: http://cliki.net/asdf-extension

### How to use it

1. Install ASDF-Binary-Locations using your method of choice.
2. Customize it as desired (see below).
3. [ASDF][] load it before loading anything else (perhaps from your Lisp's initialization file)

Voila, your binaries will be sorted as required but never
spindled, folded or mutilated.

### What it does

As you would expect, each Common Lisp implementation has its
own format for binary compiled files. If you use multiple
implementations (or multiple versions of the same
implementation), you'll soon find your source directories
littered with various DFSLs, FASLs, CFSLs and so on. This is
ugly and makes navigating the sources more difficult. Worse
yet, some implementations may share the same file extension
or change formats from version to version. This means that
you'll find yourself constantly recompiling binaries as you
switch from one implementation to the next. That's downright
inefficient.

ASDF-Binary-Locations prevents this nightmare by first
providing reasonable default locations for binaries of each
Lisp and, secondly, by allowing you to customize the
locations as required.

#### Default Locations

ABL's default binary location for each Lisp implementation is
a subdirectory of the source directory. To account for
different Lisps, Operating Systems, implementation versions,
and so on, ABL borrows code from [SLIME][] to create
intelligent directory names as necessary. You can also have
ABL put all compiled files into subdirectories of a single
central location. See the [user's guide][ug] for details.

 [ug]: user-guide.html

{anchor mailing-lists}

### Mailing Lists

* [asdf-binary-locations-devel][devel-list]: A list for
  announcements, questions, patches, bug reports, and so
  on; It's for anything and everything

{anchor downloads}

### Where is it

A [darcs][] repository is available. The darcs command is
listed below:

    darcs get http://common-lisp.net/project/asdf-binary-locations/

ASDF-Binary-Locations is also [ASDF
installable][asdf-install]. Its CLiki home is right
[where][cliki-home] you'd expect.

There's also a handy [gzipped tar file][tarball].

### Notes and Issues

  * SBCL ships with several included ASDF libraries. Unless you tell it not to, ABL will try to place the compiled files for these into new directories which may fail due to directory permissions. You can tell ABL to not mess with the SBCL files by added something like the following to your ~/.sbclrc file
    
        ;; force SBCL things to stay in SBCL
        (defvar asdf::*source-to-target-mappings*
          '(("/usr/local/lib/sbcl/" nil)))

    Note that this is currently the built-in behavior of ABL
    and has been for a while...

{anchor news}

### What is happening

11 Aug 2008 - Marko Kocic contributes some patches to improve ECL support. Thanks!

5 May 2008 - Keeping up with the Jones and the rest of the
Common-Lisp world; Stelian Ionescu rationalizes features
lists. Thanks!

15 April 2007 - Paid taxes and posted the latest changes

13 December 2007 - Exported
`implementation-specific-directory-name`

9 October 2006 Made compatible with SLIME's 64-bit Allegro
locations (Thanks to Matthias Koeppe).

31 July 2006 Added *include-per-user-information* (Thanks to
Erik Enge).

15 June 2006 Happy now on 64-bit OpenMCL. Thanks to Joshua
Moody.

5 June 2006 Thanks to Peter Seibel and Robert Goldman for
helping to push out a bunch of useful improvements.

19 Dec 2005 Created by munging great code together and added
a bit of spice.

</div>
</div>

{include resources/footer.md}

