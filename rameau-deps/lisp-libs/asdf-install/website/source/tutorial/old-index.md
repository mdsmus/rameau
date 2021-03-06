{set-property html yes}
{set-property title "ASDF-Install Tutorial"}
{set-property style-sheet style}

## A tutorial for ASDF-INSTALL

> 
> ### Abstract
> 
> This tutorial is intended for people who are relatively new to Common Lisp. It describes an easy way to install third-party libraries into a Lisp implementation. 
  
## Contents

{table-of-contents :start 2 :depth 3}

### Introduction

If you're reading this you're probably already convinced that Common Lisp is a very fine programming language. However, while the [ANSI standard][35] is huge and provides tons of functionality there are a couple of things (like, say, XML parsers, web servers, GUIs, regular expressions) that aren't included and must either be provided by your particular implementation or otherwise by a third-party library. 

   [35]: http://www.lispworks.com/reference/HyperSpec/

Hitherto these libraries had to be installed manually, an often complex process. However, many library authors are now packaging their systems using the ASDF-INSTALL standard, allowing for automatic installation on any Lisp system that supports it.   
   

### What is ASDF?

In order to understand what ASDF-INSTALL does we first have to understand what ASDF is and why we need it. [ASDF][36] ("Another System Definition Facility"), written by [Daniel Barlow][37], is a library that automates the compilation and loading of "systems", i.e. Lisp programs which are usually composed of a couple of files which have to be compiled and loaded in a certain order. ASDF is similar to the Unix `make` program. ASDF works with the majority of CL implementations in use today. 

   [36]: http://www.cliki.net/asdf
   [37]: http://ww.telent.net/

A similar system which precedes ASDF is [MK:DEFSYSTEM][38]. You don't need it for ASDF-INSTALL but it won't hurt to have it available for libraries which aren't aware of ASDF. However, this document makes no effort to explain how MK:DEFSYSTEM is used. See Henrik Motakef's article "[Fight The System][39]." (Unfortunately, the link seems to be dead.) 

   [38]: http://www.cliki.net/mk-defsystem
   [39]: http://www.henrik-motakef.de/defsystem.html

_Update:_ Marco Antoniotti has patched ASDF-INSTALL to make it work with MK:DEFSYSTEM as well. See the [section about MK:DEFSYSTEM][40] below.   
   
   [40]: #defsystem

### What is ASDF-INSTALL?

[ASDF-INSTALL][41], also written by Dan Barlow, is layered atop of ASDF and can automatically download Lisp libraries from the Internet and install them for you. It is also able to detect and [resolve dependencies][42] on other libraries. (These libraries have to be prepared for ASDF-INSTALL by their author. See more [below][43].) 

   [41]: http://www.cliki.net/asdf-install
   [42]: #dependencies
   [43]: #url

ASDF-INSTALL was originally written for the [SBCL][44] Common Lisp implementation. It has been recently ported to [CMUCL][45], [Allegro Common Lisp][46], [Xanalys LispWorks][47], and [CLISP][48] by [Edi Weitz][49]. [Marco Baringer][50] added support for [OpenMCL][51], [James Anderson][52] added support for [Macintosh Common Lisp][53] (MCL).  Douglas Crosher added support for the [Scieneer Common Lisp][56]. 

   [44]: http://sbcl.sf.net/
   [45]: http://www.cons.org/cmucl/
   [46]: http://www.franz.com/products/allegrocl/
   [47]: http://www.lispworks.com/
   [48]: http://clisp.sourceforge.net/
   [49]: http://weitz.de/
   [50]: http://www.cliki.net/Marco%20Baringer
   [51]: http://openmcl.clozure.com/
   [52]: http://setf.de/
   [53]: http://www.digitool.com/
   [56]: http://www.scieneer.com/scl/

It'd be nice if users of other Lisps (like [Corman Lisp][54], or [ECL][55], could provide patches to make ASDF-INSTALL available on more platforms. 

   [54]: http://www.cormanlisp.com/
   [55]: http://ecls.sourceforge.net/

The original ASDF-INSTALL is distributed with SBCL. The latest incarnation of the "portable" version is available from [Common-Lisp.net][57]. 

   [57]: http://common-lisp.net/project/asdf-install/
   [58]: http://cvs.sourceforge.net/viewcvs.py/cclan/asdf-install/

Note that the "portable" version can be considered a fork of the original (SBCL-only) version. Likewise, versions of ASDF-INSTALL distributed with other Lisp implementations like OpenMCL are most likely forks of the "portable" version. This document mostly describes how to use the "portable" version. If you're on a system like SBCL or OpenMCL that comes with its own version of ASDF-INSTALL you are advised to _ignore_ the rest of this tutorial and instead consult the documentation that was supplied by your vendor. (Parts of this tutorial might apply to these implementations as well but they're not guaranteed to be kept up to date.) 

This tutorial and the portable version of ASDF-INSTALL were originally started by [Edi Weitz][59] but they're now maintained by [Gary King][60].   
   
   [59]: http://weitz.de/
   [60]: http://www.cliki.net/Gary%20King

### Prerequisites

This tutorial is aimed at Unix-like systems which include Linux and Mac OS X. If you're on MS Windows make sure to read the _Windows notes_ at the end of each section. 

Apart from one of the [supported Lisps][61] you will need [GnuPG][62] (which is  pre-installed on most Linux distributions but not on OS X). Install it first if you don't have it already. You may also need to install [the GNU version of `tar`][63] if you're not on Linux. 

   [61]: #asdf-install
   [62]: http://www.gnupg.org/
   [63]: http://www.gnu.org/software/tar/tar.html

(GnuPG is not strictly necessary - see [below][64] - but it is recommended
if you want to be somewhat more sure that you're not installing arbitrary malicious code.) 

   [64]: #*verify-gpg-signatures*

_Update:_ Beginning with version 0.14.1 ASDF-INSTALL is already included with the OpenMCL distribution. Also, AllegroCL 7.0 and higher include ASDF (but not ASDF-INSTALL.) See below for details. 

_Note:_ ASDF-Install will not work with MCL unless you start MCL 
from a terminal. 

_Windows note:_ If you want to use ASDF-INSTALL on Windows you must install [Cygwin][65] first. You can also install GnuPG from the Cygwin setup program. If you want to use CLISP you currently [have to use][66] the Cygwin version (which can also be installed from the setup application). The good news is that if you use Cygwin you can pretty much pretend you're on Unix and **skip** all the _Windows notes_ below. 

   [65]: http://www.cygwin.com/
   [66]: http://article.gmane.org/gmane.lisp.clisp.general/7891

(Update: Alex Mizrahi posted [some notes][67] about using the native Win32 version of CLISP to [comp.lang.lisp][68]. I asked him to send patches but he hasn't sent them yet.) 

   [67]: http://www.google.com/groups?selm=2gacj0Fi7moU1%40uni-berlin.de&output=gplain
   [68]: news://comp.lang.lisp

Whenever I use `~/` (the Unix shell notation for the user's home directory) in the following text what is actually meant is the value of ([`USER-HOMEDIR-PATHNAME`][69]). While on Unix/Linux all implementations seem to agree what this value should be, on Windows this is not the case. Read the docs of your Lisp. 

   [69]: http://www.lispworks.com/reference/HyperSpec/Body/f_user_h.htm

#### Installing ASDF

([Skip][70] this section if you use SBCL or OpenMCL or AllegroCL 7.0 or higher.) [Download ASDF][71] and put the file `asdf.lisp` in a place where you want it to stay. Change into this directory and, from your Lisp, issue the command 
    
   [70]: #load-asdf
   [71]: http://www.cliki.net/asdf


    (load (compile-file "asdf.lisp"))
    

You should now have a new file the name of which depends on your implementation - probably something like `asdf.fasl`, `asdf.fas`, `asdf.fsl`, `asdf.ufsl`, `asdf.x86f`, or `asdf.so`. 

_Note:_ LispWorks 4.2 (and probably earlier versions) has a bug that prevents it from loading the compiled ASDF correctly. It is recommended that you upgrade to 4.3 but if for some reason you must use an older version you can skip the compilation step above and later just load the `.lisp` file instead in which case you'll use interpreted code. 

#### Loading ASDF automatically

We want to make sure that ASDF is loaded whenever we start our Lisp. For this we'll use an _initialization file_. Most Lisps will read and execute the contents of a certain file on startup. This file is usually located in your home directory and might be called `.clinit.cl` (for Allegro Common Lisp), `.cmucl-init` (for CMUCL), `.lispworks` (for Xanalys LispWorks), `.clisprc` (for CLISP), `openmcl-init.lisp` (for OpenMCL), or `.scl-init` (for the Scieneer CL).  Consult your Lisp's documentation for details. 

Open this file (create it if it doesn't exist) and add this line 
    
    
    #-:asdf (load "/path/where/asdf/is/located/asdf")
    

where of course you have replaced `/path/where/asdf/is/located/` with the correct path to ASDF - see [last section][72]. We wrote `(load ".../asdf")` and not, say, `(load ".../asdf.x86f")` because this way your Lisp will load the compiled file if it is available and otherwise `asdf.lisp` if for some reason you didn't compile the code. 

   [72]: #install-asdf

Why the `#-:asdf`? After ASDF has been loaded it adds the symbol `:ASDF` to the [features list][73]. Our use of the _read-time conditional_ [Sharpsign Minus][74] thus makes sure that ASDF isn't loaded a second time if it's already there. (So you can safely save and use an image with ASDF pre-loaded without changing your init file.) 

   [73]: http://www.lispworks.com/reference/HyperSpec/Body/v_featur.htm
   [74]: http://www.lispworks.com/reference/HyperSpec/Body/02_dhr.htm

If you're using SBCL or OpenMCL or AllegroCL 7.0 or higher _don't_ add the line from above but use 
    
    
    (require :asdf)
    

instead. 

ASDF maintains a list of places where it will look for _system definitions_ when it is asked to load or compile a system. (System definitions are the files ending with `.asd`.) This list is stored in the [special variable][75] `ASDF:*CENTRAL-REGISTRY*` and you can add new directories to it. Open your initialization file once again and add the following line _after_ the line which loads ASDF: 
    
   [75]: http://www.lispworks.com/reference/HyperSpec/Body/26_glo_s.htm#special_variable


    (pushnew "/path/to/your/registry/" asdf:*central-registry* :test #'equal)
    

You can use a directory of your choice but you should make sure it exists. You can also add several of these lines with different directories so ASDF will look into each directory in turn until it has found a system definition. Use the directory `~/.asdf-install-dir/systems/` if you can't make a decision and make sure to create it. (Replace `~/` with an absolute path to your home directory because not all Lisps support the tilde notation.) We will call the directory you've chosen your _registry_ from now on. 

_Note:_ It is important that you add a _directory_ here, not a file, so make sure the [namestring][76] ends with a slash! 

   [76]: http://www.lispworks.com/reference/HyperSpec/Body/26_glo_n.htm#namestring

_Note:_ If you use ASDF alone the preferred way to deal with system definitions is to create symbolic links from the `.asd` files to your registry. However, you don't have to deal with this as ASDF-INSTALL will do that for you. 

_Note:_ The free "Personal Edition" of LispWorks doesn't read `~/.lispworks` on startup. You can circumvent this by putting something like 
    
    
    alias lispworks="/usr/local/lib/LispWorksPersonal/lispworks-personal-4300 -init ~/.lispworks"
    

into your `~/.bashrc` file. 

_Windows note:_ On Windows we can't use a central registry because Windows doesn't have symbolic links. We will use another mechanism (see [below][77]) to find system definitions, so you don't have to put the `PUSHNEW` line into your initialization file. 

   [77]: #load-asdf-install

#### Installing ASDF-INSTALL

([Skip][78] this section if you use SBCL.) [Download ASDF-INSTALL][79] and put the `.lisp` and `.asd` file into a new directory `asdf-install` which can be located wherever you like. Now create a symlink to your `.asd` file from your [registry][80] folder: 
    
   [78]: #load-asdf-install
   [79]: http://cvs.sourceforge.net/viewcvs.py/cclan/asdf-install/
   [80]: #registry


    cd /path/to/your/registry/
    ln -s /path/where/you/put/asdf-install/asdf-install.asd .
    

For OpenMCL you don't have to download ASDF-INSTALL because it's already there - it's in `/path/to/ccl/tools/asdf-install/` where `/path/to/ccl/` is the directory where you installed OpenMCL. You have to provide the symlink, though. 

Now start your Lisp and issue the following command: 
    
    
    (asdf:operate 'asdf:compile-op :asdf-install)
    (asdf:operate 'asdf:load-op :asdf-install)
    

This will ask ASDF to locate the ASDF-INSTALL library, compile it, and finally load it. 

_Windows note:_ You can leave out the `ln` command. Now, _before_ you compile and load ASDF-INSTALL you have to put this line into your initialization file: 
    
    
    (pushnew "/path/where/you/unpacked/asdf-install/" asdf:*central-registry* :test #'equal)
    

and then either restart your Lisp or evaluate this expression in your current session. Afterwards, proceed with the two `ASDF:OPERATE` forms. 

#### Loading ASDF-INSTALL automatically

Open your [initilization file][81] again and add this line at the end: 
    
   [81]: #load-asdf


    #-:asdf-install (asdf:operate 'asdf:load-op :asdf-install)
    

This will instruct ASDF to load the (compiled) ASDF-INSTALL library whenever your Lisp starts up (unless ASDF-INSTALL is already available in your image). 

If you're using SBCL _don't_ add the line from above but use 
    
    
    (require :asdf-install)
    

instead. (Note: Try this from the REPL and check the messages to see whether SBCL really loads its own bundled version of ASDF-INSTALL. The "portable" version this document talks about is supposed to work with SBCL as well but in case of incompatibilities you're advised to rely on SBCL's version.) 

You're now ready to use ASDF-INSTALL. 

_Windows note:_ For Windows add the following line to end of the initialization file: 
    
    
    (pushnew 'asdf-install:sysdef-source-dir-search
             asdf:*system-definition-search-functions*)
    

As we [can't use][82] the [central registry][83], we're using a customized search function instead. It'll scan all directories below each of the entries in [`*LOCATIONS*`][84] until it finds a suitable system definition. Note that this is a sub-optimal solution because this will not necessarily find the newest one if you've installed several versions of the same library. Make sure to [uninstall][85] older versions.   
   


   [82]: #win-sym
   [83]: #*central-registry*
   [84]: #*locations*
   [85]: #uninstall

### Optional: Using MK:DEFSYSTEM instead of (or in addition to) ASDF

[MK:DEFSYSTEM][86] was written by Mark Kantrovitz in the early days of Common Lisp. It precedes ASDF and also works with almost all CL implementations you'll come across. Thanks to the efforts of Marco Antoniotti, ASDF-INSTALL can now also be used with MK:DEFSYSTEM which means that even if the library you want to use doesn't have an ASDF system definition you might be able to install it via ASDF-INSTALL. 

   [86]: http://www.cliki.net/mk-defsystem

The recommended setup is to use _both_ ASDF _and_ MK:DEFSYSTEM because this will significantly increase the number of libraries you can install with ASDF-INSTALL. 

To set up your Lisp environment for this you have to do the following (after reading the sections above): 

  * Get MK:DEFSYSTEM (version 3.4i or higher) from [CLOCC][87]. (You can grab a nightly snapshot or browse the CVS. You only need the file `defsystem.lisp` from within the `src/defsystem-3.x` directory.) 
  * To install MK:DEFSYSTEM evaluate the form 
    
   [87]: http://clocc.sourceforge.net/


    (load (compile-file "/path/to/defsystem.lisp"))
    

  * To load MK:DEFSYSTEM automatically each time you start your Lisp put the forms 
    
    
        #-:mk-defsystem (load "/path/to/defsystem")
        (mk:add-registry-location "/path/to/your/registry/")
    

into your initialization file. 
  * Finally, replace the line 
    
    
        #-:asdf-install (asdf:operate 'asdf:load-op :asdf-install)
    

from [above][88] with the line 
    
   [88]: #load-asdf-install


        #-:asdf-install (load "/path/to/asdf-install/load-asdf-install")
    

This last step will ensure that ASDF-INSTALL will always be loaded on startup even if you only use MK:DEFSYSTEM and don't have ASDF available. 

The following sections should work for you no matter whether you use ASDF, MK:DEFSYSTEM, or both.   
   


### How to install a library

Here and in the following sections we assume that you have set up your environment as described in [_Prerequisites_][89]. 

   [89]: #pre

_Note:_ Of course, the fact that a library can be installed with ASDF-INSTALL and that ASDF-INSTALL was ported to your Lisp implementation doesn't necessary mean that the library _itself_ will work with your Lisp! Check the library's docs before you try to install it. 

#### Installing a library by name

The webpage [http://www.cliki.net/asdf-install][90] contains a list of libraries which can automatically be downloaded and installed via ASDF-INSTALL. Listed here are libraries which are explicitely prepared to work with ASDF-INSTALL and where the author decided to announce this via [CLiki][91]. This is the preferred way to install a library via ASDF-INSTALL. 

   [90]: http://www.cliki.net/asdf-install
   [91]: http://www.cliki.net/

You can click on the name of each library to get a description. Use the library's name from the list to install it. If, say, you want to install [CL-PPCRE][92] make sure you're connected to the Internet and use this command: 
    
   [92]: http://weitz.de/cl-ppcre/


    (asdf-install:install :cl-ppcre)
    

Then proceed with [_Where to store the library_][93] below. 

   [93]: #where

_Note:_ If you install a library by name, ASDF-INSTALL will connect to the CLiki website and from there it'll be redirected to the actual download location provided by the library's author. 

_Note:_ The argument to the `ASDF-INSTALL:INSTALL` function is a [string designator][94], i.e. instead of `:CL-PPCRE` you can also use `"cl-ppcre"`. CLiki is case-insensitive and therefore case doesn't matter if you install a library by name. 

   [94]: http://www.lispworks.com/reference/HyperSpec/Body/26_glo_s.htm#string_designator

#### Installing a library by URL

The list mentioned [above][95] is not necessary complete, i.e. there might as well exist libraries which aren't listed there but which can be installed via ASDF-INSTALL. 

   [95]: #name

In order to be _ASDF-installable_ a library has to contain a [system definition][96] for ASDF. It also has to be packaged in a certain way: It is assumed to come as a gzipped tar archive (usually ending in `.tar.gz` or `.tgz`) which unpacks into one directory possibly containing sub-directories. The system definition has to have a name corresponding to the name of the library (so if your library is called "foobar" the system definition is supposed to be `foobar.asd`) and has to reside in the top-level directory. 

   [96]: #definition

If this is the case you can download and install the library directly by providing the download URL of the package like so: 
    
    
    (asdf-install:install "http://weitz.de/files/cl-ppcre.tar.gz")
    

Now proceed with [_Where to store the library_][97] below. 

   [97]: #where

_Note:_ Currently, ASDF-INSTALL only understands http. Other protocols like ftp or https aren't supported. 

_Note:_ It's obviously rather easy to make an existing library ASDF-installable if it isn't already. If you come across a library which you'd like to use but which isn't listed on [http://www.cliki.net/asdf-install][98], it might be worthwhile to kindly ask the library's author to change this. 

   [98]: http://www.cliki.net/asdf-install

#### Installing from a local file

The third way to install a library via ASDF-INSTALL is to use a local tar archive (in the format described [in the last section][99]). In this case you use the file's [namestring][100]
    
   [99]: #url
   [100]: http://www.lispworks.com/reference/HyperSpec/Body/26_glo_n.htm#namestring


    (asdf-install:install "/path/to/library/library.tar.gz")
    

and afterwards carry on with the next section. 

_Note:_ For obvious reasons this namestring must not start with `"http://"` although your operating system might otherwise allow this. 

#### Where to store the library

ASDF-INSTALL will now ask you where the library should be stored. (This can be [customized][101].) In the default configuration this'll look more or less like so: 
    
   [101]: #*locations*


    Install where?
    1) System-wide install:
       System in /usr/local/asdf-install/site-systems/
       Files in /usr/local/asdf-install/site/
    2) Personal installation: 
       System in /Users/gwking/.asdf-install-dir/systems/
       Files in /Users/gwking/.asdf-install-dir/site/ 
    0) Abort installation.     
    -->
    

Choose one of these options and enter the corresponding number, then press the `Return` key. (Note that on Unix-like systems you usually don't have write access in `/usr/local/` unless you're `root`.) Choice 0 will always be assigned to canceling the installation.

#### The security check

If you don't install from a local file, ASDF-INSTALL will now check the validity of the library. (This behaviour can be [customized][102].) Library authors are supposed to crypto-sign their libraries and provide a file with the (PGP) signature in the same place where the library can be downloaded, i.e. if the library is at `http://www.example.com/frob.tar.gz` then ASDF-INSTALL will try to download the signature from `http://www.example.com/frob.tar.gz.asc`. 

   [102]: #*verify-gpg-signatures*

ASDF-INSTALL will check 

  * if the signature exists on your computer, 
  * if there is a GPG trust relationship between the package signer and you (i.e. that the package comes from someone whose key you've signed, or someone else you have GPG trust with has signed), and 
  * if the signer is listed in your [personal list of valid suppliers of Lisp code][103]. 

   [103]: #trusted-uids

If all these tests succeed, ASDF-INSTALL will compile and install the library and you can now [use it][104]. (This will also happen instantly if you have installed from a local file.) 

   [104]: #use

If one of the checks fails, you'll most likely be confronted with one of these situations: 
    
    
    Downloading 157777 bytes from http://weitz.de/files//cl-ppcre.tgz ...
    Error: Server responded 404 for GET http://weitz.de/files//cl-ppcre.tgz.asc
      [condition type: DOWNLOAD-ERROR]
    
    Restart actions (select using :continue):
     0: Don't ckeck GPG signature for this package
     1: Return to Top Level (an "abort" restart).
     2: Abort entirely from this process.
    

There was no signature corresponding to this package. 
    
    
    Downloading 6365 bytes from http://files.b9.com//cl-base64-latest.tar.gz ...gpg: WARNING: using insecure memory!
    gpg: please see http://www.gnupg.org/faq.html for more information
    gpg: Signature made Thu 12 Jun 2003 04:06:04 PM CEST using DSA key ID C4A3823E
    gpg: Can't check signature: public key not found
    
    Error: No key found for key id 0x112ECDF2C4A3823E.  Try some command like
      gpg  --recv-keys 0x112ECDF2C4A3823E
      [condition type: KEY-NOT-FOUND]
    
    Restart actions (select using :continue):
     0: Don't ckeck GPG signature for this package
     1: Return to Top Level (an "abort" restart).
     2: Abort entirely from this process.
    

The library was signed but the signer's public key wasn't found in your public keyring. 
    
    
    Downloading 6365 bytes from http://files.b9.com//cl-base64-latest.tar.gz ...gpg: WARNING: using insecure memory!
    gpg: please see http://www.gnupg.org/faq.html for more information
    gpg: Signature made Thu 12 Jun 2003 04:06:04 PM CEST using DSA key ID C4A3823E
    gpg: Good signature from "Kevin M. Rosenberg <kmr@debian.org>"
    gpg:                 aka "Kevin Rosenberg <kevin@rosenberg.net>"
    gpg:                 aka "Kevin M. Rosenberg <kevin@b9.com>"
    gpg:                 aka "Kevin Marcus Rosenberg, M.D. <kevin@b9.com>"
    gpg: WARNING: This key is not certified with a trusted signature!
    gpg:          There is no indication that the signature belongs to the owner.
    Primary key fingerprint: D7A0 55B6 4768 3582 B10D  3F0C 112E CDF2 C4A3 823E
    
    Error: GPG warns that the key id 0x112ECDF2C4A3823E (Kevin M. Rosenberg <kmr@debian.org>) is not fully trusted
      [condition type: KEY-NOT-TRUSTED]
    
    Restart actions (select using :continue):
     0: Don't ckeck GPG signature for this package
     1: Return to Top Level (an "abort" restart).
     2: Abort entirely from this process.
    

The signer's key is in your public keyring but you have no GPG trust relationship with him. 
    
    
    Downloading 157777 bytes from http://weitz.de/files//cl-ppcre.tgz ...gpg: WARNING: using insecure memory!
    gpg: please see http://www.gnupg.org/faq.html for more information
    gpg: Signature made Fri 24 Oct 2003 11:22:11 AM CEST using DSA key ID 057958C6
    gpg: Good signature from "Dr. Edmund Weitz <edi@weitz.de>"
    
    Error: Dr. Edmund Weitz <edi@weitz.de> (key id 595FF045057958C6) is not on your package supplier list
      [condition type: AUTHOR-NOT-TRUSTED]
    
    Restart actions (select using :continue):
     0: Add to package supplier list
     1: Don't ckeck GPG signature for this package
     2: Return to Top Level (an "abort" restart).
     3: Abort entirely from this process.
    

The signer's key is in your public keyring, you have a GPG trust relationship with him but the signer wasn't found in your [list of valid suppliers of Lisp code][105]. 

   [105]: #trusted-uids

As you'll have noticed, in all these cases ASDF-INSTALL offers the [restart][106] not to check the GPG signature in this particular case. How you can select this restart depends on your Lisp implementation but if you select it ASDF-INSTALL will proceed compiling and installing the package without further checks for this library. 

   [106]: http://www.lispworks.com/reference/HyperSpec/Body/09_adb.htm

In the last case (condition type `AUTHOR-NOT-TRUSTED`) you are also offered another restart. If you select this one the signer of the library will be added to your [package supplier list][107] and you won't be asked again if you install another library signed by the same person. 

   [107]: #trusted-uids

_Note:_ You might be asking yourself if all this security stuff is really necessary. Well, [CLiki][108], the website where ASDF-INSTALL looks for the package URL if you install by name, can be edited by _anyone_ so it would be fairly easy for a malicious hacker to redirect you to a library which once it's installed insults your boss by email or withdraws US$ 100,000 from your bank account. You better make sure this doesn't happen... See the [section about customization][109] on how to (partly) disable security checks. 

   [108]: http://www.cliki.net/
   [109]: #customize

_Note:_ If you're unsure about notions like _public keyring_ or _GPG trust relationship_, please read the [GnuPG documentation][110]. It is beyond the scope of this text to explain these terms.   
   


   [110]: http://www.gnupg.org/documentation/index.html

### How to use an installed library

After you've successfully executed `ASDF-INSTALL:INSTALL` you can immediately use the library you've just installed while you're still in the same Lisp session. If you quit your Lisp image and start it anew you have to reload the library. (Of course you _don't_ have to install it again!) This is done like so: 
    
    
    (asdf:operate 'asdf:load-op :library-name)
    

Here `:LIBRARY-NAME` is either the name you've used if you installed [by name][111] or it is the name of the main `.asd` file if you've installed [by URL][112] or [from a local file][113]. If you're not sure about the name you have to use, you can list the contents of your [registry][114] for all libraries which are available to you. So, if your registry looks like this 
    
   [111]: #name
   [112]: #url
   [113]: #local
   [114]: #registry


    edi@bird:~ > ls ~/.asdf-install-dir/systems/
    cl-ppcre.asd  cl-ppcre-test.asd  cl-who.asd  html-template.asd
    

you can substitute `:LIBRARY-NAME` with one of `:CL-PPCRE`, `:CL-PPCRE-TEST`, `:CL-WHO`, or `:HTML-TEMPLATE`. (CL-PPCRE-TEST was most likely automatically installed when you installed [CL-PPCRE][115].) 

   [115]: http://weitz.de/cl-ppcre/

If you use SBCL you can, instead of calling `ASDF:OPERATE`, simply [`REQUIRE`][116] the library: 
    
   [116]: http://www.lispworks.com/reference/HyperSpec/Body/f_provid.htm


    (require :library-name)
    

  
   


### How ASDF-INSTALL resolves dependencies

Sometimes a library depends on one or more other libraries. This can be expressed within an ASDF [system definition][117]. If there's a dependency and the necessary libraries aren't already installed then ASDF-INSTALL will try to download the missing libraries [by name][118] and install them before it proceeds to install the main library. This of course requires that the missing libraries are also listed on [CLiki][119]. 

   [117]: #definition
   [118]: #name
   [119]: http://www.cliki.net/asdf-install

You can for example from CMUCL issue the command 
    
    
    (asdf-install:install :osicat)
    

and watch how ASDF-INSTALL not only downloads and installs [Osicat][120] but also [UFFI][121].   
   


   [120]: http://common-lisp.net/project/osicat/
   [121]: http://uffi.b9.com/

### Customizing ASDF-INSTALL

When ASDF-INSTALL is loaded it [`LOAD`][122]s the file `~/.asdf-install` if it's there. This file (which is obviously supposed to contain Lisp code) can be used to change the values of some [special variables][123] which control ASDF-INSTALL's behaviour. Their names are [exported][124] from the `ASDF-INSTALL` [package][125]. 

   [122]: http://www.lispworks.com/reference/HyperSpec/Body/f_load.htm
   [123]: http://www.lispworks.com/reference/HyperSpec/Body/26_glo_s.htm#special_variable
   [124]: http://www.lispworks.com/reference/HyperSpec/Body/26_glo_e.htm#exported
   [125]: http://www.lispworks.com/reference/HyperSpec/Body/11_.htm

#### Special variable `*GNU-TAR-PROGRAM*`

The path to the GNU `tar` program as a string - the default is `"tar"`. Changing this variable has no effect if Cygwin is used. 

#### Special variable `*PROXY*`

This variable is `NIL` by default but will be set to the value of the environment variable `$http_proxy` (if it's set) prior to loading `~/.asdf-install`. Set this to a non-`NIL` value if you need to go through an http proxy. 

#### Special variable `*PROXY-USER*`

#### Special variable `*PROXY-PASSWD*`

Use these variables if your [proxy][126] requires authentication. 

   [126]: #*proxy*

#### Special variable `*CCLAN-MIRROR*`

This variable is set to `"http://ftp.linux.org.uk/pub/lisp/cclan/"` before `~/.asdf-install` is loaded. A couple of ASDF-installable libraries are available via [CCLAN][127] and with the help of this variable you can choose another CCLAN mirror from the list at [http://ww.telent.net/cclan-choose-mirror][128]. 

   [127]: http://www.cliki.net/cclan
   [128]: http://ww.telent.net/cclan-choose-mirror

{anchor *verify-gpg-signatures*}
#### Special variable `*VERIFY-GPG-SIGNATURES*`

This variable is set to `T` initially which means that there'll be a [security check][129] for each library which is not installed from a local file. You can set it to `NIL` which means no checks at all or to `:UNKNOWN-LOCATIONS` which means that only URLs which are not in [`*SAFE-URL-PREFIXES*`][130] are checked. Every other value behaves like `T`. 

   [129]: #security
   [130]: #*safe-url-prefixes*

_Note:_ This customization option is currently not supported in the SBCL version of ASDF-INSTALL. 

#### Special variable `*SAFE-URL-PREFIXES*`

The value of this variable is `NIL` initially. It is supposed to be a list of strings which are "safe" URL prefixes, i.e. if a download URL begins with one of these strings there's no [security check][131]. The value of `*SAFE-URL-PREFIXES*` only matters if [`*VERIFY-GPG-SIGNATURES*`][132] is set to `:UNKNOWN-LOCATIONS`. 

   [131]: #security
   [132]: #*verify-gpg-signatures*

_Note:_ This customization option is currently not supported in the SBCL version of ASDF-INSTALL. 

#### Special variable `*LOCATIONS*`

The initial value of this variable (prior to loading `~/.asdf-install`) is 
    
    
    ((#p"/usr/local/asdf-install/site/"
      #p"/usr/local/asdf-install/site-systems/"
      "System-wide install")
     (#p"/home/edi/.asdf-install-dir/site/"
      #p"/home/edi/.asdf-install-dir/systems/"
      "Personal installation"))
    

where `/home/edi/` will obviously be replaced with your home directory. You'll notice that this corresponds to the [little menu][133] you see when ASDF-INSTALL starts to install a package. You can add elements to this list or replace it completely to get another menu. Each element is a list with three elements - a [pathname][134] denoting the directory where the (unpacked) libraries will be stored, a pathname denoting a directory where [system definition][135] symlinks will be placed, and a string describing this particular choice. 

   [133]: #where
   [134]: http://www.lispworks.com/reference/HyperSpec/Body/19_b.htm
   [135]: #definition

If you make changes to this value it is important that you also update [`ASDF:*CENTRAL-REGISTRY*`][136] accordingly in your initialization file or ASDF-INSTALL won't find your system definitions (unless you are on Windows). See the [example][137] below. 

   [136]: #*central-registry*
   [137]: #example

_Note:_ On SBCL the initial value of this variable is different - try it out yourself. 

#### Special variable `*PREFERRED-LOCATION*`

This variable is initially `NIL`. If it is not `NIL` it should be a positive integer not greater than the length of [`*LOCATIONS*`][138]. By setting this value you circumvent the [question][139] about where to install a library and ASDF-INSTALL will unconditionally use the corresponding entry from [`*LOCATIONS*`][138]. Note that `1` (not `0`) means the first entry. 

   [138]: #*locations*
   [139]: #where

_Note:_ This customization option is currently not supported in the SBCL version of ASDF-INSTALL. 

#### Environment variable `ASDF_INSTALL_DIR`

The value of this _environment variable_ determines the first element of the initial value of [`*LOCATIONS*`][140], i.e. if it, say, contains the value `/usr/local/foo/`, then the first element of `*LOCATIONS*` is 
    
   [140]: #*locations*


    (#p"/usr/local/foo/site/"
     #p"/usr/local/foo/site-systems/"
     "System-wide install")
    

If this variable is not set, the directory `/usr/local/asdf-install/` is used. Note that this variable affects ASDF-INSTALL's behaviour _before_ `~/.asdf-install` is loaded. 

_Note:_ On SBCL the value of `SBCL_HOME` is used instead. 

#### Environment variable `PRIVATE_ASDF_INSTALL_DIR`

The value of this _environment variable_ determines the second element of the initial value of [`*LOCATIONS*`][141], i.e. if it, say, contains the value `frob/` and your username is `johndoe`, then the second element of `*LOCATIONS*` is 
    
   [141]: #*locations*


    (#p"/home/johndoe/frob/site/"
     #p"/home/johndoe/frob/systems/"
     "Personal installation")
    

If this variable is not set, the value `.asdf-install-dir` (note the dot) is used. Note that this variable affects ASDF-INSTALL's behaviour _before_ `~/.asdf-install` is loaded. 

_Note:_ On SBCL the value `.sbcl` is used instead. 

#### An example `.asdf-install` file

Here's a documented example for how the file `~/.asdf-install` could look like: 
    
    
    ;; use a http proxy
    (setq asdf-install:[*proxy*][142] "http://proxy.foo.com/")
    
    ;; use a CCLAN mirror in France
    (setq asdf-install:[*cclan-mirror*][143] "http://thingamy.com/cclan/")
    
    ;; only partial security checks
    (setq asdf-install:[*verify-gpg-signatures*][144] :unknown-locations)
    
    ;; downloads from Kevin Rosenberg and from my own server don't have to be checked
    (setq asdf-install:[*safe-url-prefixes*][145]
            '("http://files.b9.com/" "http://weitz.de/files/"))
    
    ;; add a repository for unstable libraries
    (pushnew '(#p"/usr/local/lisp/unstable/site/"
               #p"/usr/local/lisp/unstable/systems/"
               "Install as unstable")
             asdf-install:[*locations*][146]
             :test #'equal)
    
    ;; make sure this is also known by ASDF
    (pushnew "/usr/local/lisp/unstable/systems/"
             asdf:[*central-registry*][147]
             :test #'equal)
    

   [142]: #*proxy*
   [143]: #*cclan-mirror*
   [144]: #*verify-gpg-signatures*
   [145]: #*safe-url-prefixes*
   [146]: #*locations*
   [147]: #*central-registry*

  
   


### The list of trusted code suppliers

ASDF-INSTALL maintains a list of library authors you trust. This list is stored in a file `trusted-uids.lisp` and usually resides in the directory `~/.asdf-install-dir/` but this can be customized by changing the environment variable [`PRIVATE_ASDF_INSTALL_DIR`][148]. You are not supposed to edit this file manually - new entries are added automatically whenever you choose the [corresponding restart][149] during the security check.   
   


   [148]: #private-asdf-install-dir
   [149]: #restart

### How to uninstall a library

This is easy: 
    
    
    (asdf-install:uninstall [:library-name][150])
    

   [150]: #library-name

ASDF-INSTALL will ask you to confirm this and then it'll remove the library's source directory as well as the symbolic link to the [system definition][151] (if it exists). 

   [151]: #definition

_Windows note:_ Due to [the way systems are found][152] on Windows ASDF-INSTALL will propose to delete an arbitrary version of your library if you've installed several of them. Make sure to read what it is about to remove before you confirm.   
   
   [152]: #custom-search

### Changelog

    2006-01-08 Tutorial and software now maintained by Gary King, removed weitz.de links
    2005-12-21 Changed GNU tar default for FreeBSD and NetBSD (Richard Kreuter)
    2005-12-16 Fixed bug in load dependencies (Gary King)
    2005-12-16 Fixed file descriptor leak (John Wiseman)
    2005-12-14 Fixed request URI (Zach Beane)
    2005-12-05 Check GPG return values (thanks to Gary King)
    2005-10-18 Changes for compatibility with SBCL's Unicode support (thanks to Christophe Rhodes)
    2005-09-27 Small change for compatibility with future OpenMCL versions (thanks to Bryan O'Connor)
    2005-07-14 Updated note about CLISP (thanks to Henri Lenzi)
    2005-06-01 Added proxy authentication code (thanks to Sean Ross)
    2005-02-16 More OpenMCL details (thanks to Jim Thompson)
    2004-12-29 Added COPYRIGHT file to distribution
    2004-09-13 Added information about AllegroCL 7.0 and OpenMCL 0.14.1
    2004-09-08 Fixed typo in `GET-ENV-VAR` and added special variable `*GNU-TAR-PROGRAM*` (both thanks to Raymond Toy)
    2004-05-20 Changed hyphens to underlines in names of environment variables (thanks to Robert P. Goldman)
    2004-05-19 Mentioned Alex Mizrahi's notes, added version number for MK:DEFSYSTEM in docs and SPLIT-SEQUENCE dependency in ASDF system definition (thanks to Robert P. Goldman and Robert Lehr)
    2004-04-28 Fixed `asdf-install.asd` so that it still works and you're not forced to use `load-asdf-install.lisp`
    2004-04-25 MK:DEFSYSTEM clarification
    2004-04-24 Patches by Marco Antoniotti for MK:DEFSYSTEM compatibility
    2004-03-27 Bugfixes by Kiyoshi Mizumaru
    2004-01-28 Improved MCL support (James Anderson)
    2004-01-21 Support for MCL by James Anderson
    2004-01-16 Minor edits, Cygwin CLISP support, download location for `asdf.fas`
    2004-01-15 Preliminary Windows support, described how to uninstall a library, added `*PREFERRED-LOCATION*`, removed `ln` bug in CLISP code
    2004-01-13 Mentioned OpenMCL support (Marco Baringer), added some SBCL exceptions, added clarification about Windows, minor edits, changes by Dan Barlow
    2004-01-12 Initial version
  
   


### Copyright

Copyright (c) 2006-2006 [Gary King][gwking]. All rights reserved. 
  
Copyright (c) 2004-2006 [Dr. Edmund Weitz][153]. All rights reserved.   

   [gwking]: http://www.metabang.com/
   [153]: http://www.weitz.de/

### License

Redistribution and use of this tutorial in its orginal form (HTML) or in 'derived' forms (PDF, Postscript, RTF and so forth) with or without modification, are permitted provided that the following condition is met: 

  * Redistributions must reproduce the above copyright notice, this condition and the following disclaimer in the document itself and/or other materials provided with the distribution. 

IMPORTANT: This document is provided by the author "as is" and any expressed or implied warranties, including, but not limited to, the implied warranties of merchantability and fitness for a particular purpose are disclaimed. In no event shall the author be liable for any direct, indirect, incidental, special, exemplary, or consequential damages (including, but not limited to, procurement of substitute goods or services; loss of use, data, or profits; or business interruption) however caused and on any theory of liability, whether in contract, strict liability, or tort (including negligence or otherwise) arising in any way out of the use of this documentation, even if advised of the possibility of such damage. 

