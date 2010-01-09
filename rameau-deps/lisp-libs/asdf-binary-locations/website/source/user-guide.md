{include resources/ug-header.md}
{set-property title "ASDF-Binary-Locations User's Guide"}
{set-property style-sheet user-guide}
{set-property docs-package asdf}

# ASDF-Binary-Locations

{table-of-contents :start 2 :depth 3}

### What it is

**A**SDF-**B**inary-**L**ocations (ABL) is an [ASDF-Extension][] that makes it easy to specify where your Common Lisp binaries (FASL files) should go. 

### How to use it - the short version

1. Install ASDF-Binary-Locations using your method of choice.
2. Customize it as desired (see below).
3. [ASDF][] load it before loading anything else (perhaps from your Lisp's initialization file)

### What it does

Each Common Lisp implementation has its own format for  compiled files (fasls for short). If you use multiple implementations (or even just multiple versions of the same implementation), you'll soon find your source directories littered with various DFSLs, FASLs, CFSLs and so on. This is ugly and makes finding what you want more difficult. Worse yet, some implementations share the same file extension or change formats from version to version. This means that you'll have to recompile binaries as you switch from one implementation to the next. That's downright inefficient.

ASDF-Binary-Locations prevents this nightmare by:

1. Providing reasonable default locations for binaries of each Lisp and, 
2. by allowing you to customize the locations as required.

#### Default Locations

ABL's default binary location for each Lisp implementation is a subdirectory of each source directory. To account for different Lisps, Operating Systems, Implementation versions, and so on, ABL borrows code from [SLIME][] to create reasonable custom directory names. Here are some examples:

 * SBCL, version 1.0 on Mac OS X for intel: sbcl-1.0-darwin-x86
 * Franz Allegro, version 8.0, ANSI Common Lisp:  allegro-8.0a-macosx-x86
 * Franz Allegro, version 8.1, Modern (case sensitive) Common Lisp: allegro-8.1m-macosx-x86
 
It may be more convenient to keep FASL files out of sources entirely and  have ABL put all compiled files into subdirectories of a single central location (see \*centralize-lisp-binaries\* below).

 [cbl]: #centralize-lisp-binaries
 
Here is a summary of the variables that control ABL's source to binary mappings: 

  * \*centralize-lisp-binaries\* - If true, compiled lisp files without an explicit mapping (see \*source-to-target-mappings\*) will be placed in subdirectories of \*default-toplevel-directory\*. If false, then compiled lisp files without an explicitly mapping will be placed in subdirectories of their sources.
  
  * \*default-toplevel-directory\* - If \*centralize-lisp-binaries\* is true, then compiled lisp files without an explicit mapping (see \*source-to-target-mappings\*) will be placed in subdirectories of \*default-toplevel-directory\*.

  * \*include-per-user-information\* - specifies whether or not to include user information in the directory. Only used when \*centralize-lisp-binaries\* is true.

  * \*map-all-source-files\* - If true, then all source files will be mapped by **ABL**. If `nil` (the default), then only Common Lisp Source Files (i.e., instances of cl-source-file or its subclasses) will be.
    
  * \*source-to-target-mappings\* - This specifies mappings from source to target. If the target is nil, then it means to not map the source to anything. I.e., to leave it as is. This has the effect of turning off ASDF-Binary-Locations for the given source directory.
 
These variables are used by `output-files-for-system-and-operation` to determine where to place a source file's binary.
You can further customize ABL by writing additional methods on the generic function `output-files-for-system-and-operation`. 

#### Customization

{anchor centralize-lisp-binaries}

{docs *centralize-lisp-binaries*}

{docs *default-toplevel-directory*}

{docs *include-per-user-information*}

{docs *map-all-source-files*}

{docs *source-to-target-mappings*}

{docs implementation-specific-directory-name}

{docs output-files-for-system-and-operation}

### Notes and Issues

  * SBCL ships with several included ASDF libraries which used to confuse ABL because it would try to recompile the FASLs and then run into directory permission problems. ABL now knows about these and uses a mapping like `/usr/local/lib/sbcl` to `nil` so that the FASLs are not relocated. 
  
{include resources/ug-footer.md}
