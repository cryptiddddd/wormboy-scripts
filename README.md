# wormboy3's utility bash scripts & more!!

![signature](https://img.shields.io/badge/crane%20did%20this-926cd4?style=for-the-badge)
![bash](https://img.shields.io/badge/bash-3.5.9-red?style=for-the-badge&logo=gnubash&logoColor=white&labelColor=firebrick)
![license](https://img.shields.io/badge/license-mit-blue?style=for-the-badge&labelColor=navy)

this repository is a collection of bash script helpers that i use regularly. it also may document my knowledge of the language and evolving understanding of best use practices. 

by no means are these utility scripts complete or even generalized appropriately to more use cases than my own personal play.


### directory
- [installation](#installation)
- repo contents
    - [templates](#templates)
    - [utilities](#utilities)
    - [utility tests](#utility-tests)
- [todos](#todos)


# installation

execute the `install.sh` script with sudo permissions -- this compiles all bash files in the utility folder and throws it into your `/usr/local/lib/` directory. for now.


# what's in the repo

## templates

to start off, i have one simple template for creating new cli scripts. this makes it easier as you get into bash-scripting. at least for me, it contains my preferred method of argument parsing for the time being. 

note that there is no consideration for stdin or stdout.

## utilities

these utility scripts are not meant to be utilized directly by a user, but to provide helper functions for other developers. for instance, `pretty-print.sh` provides colorful, mutable, levelled-logging. this is great use to me everywhere, as it provides consistent output across multiple clis.

utility functions are all in-progress.

## utility tests

these tests exist simply for verifying and developing utilities and their use cases.

note: when installed, all scripts are concatenated together, eliminating the need to import various inter-dependencies in this library. however, when testing, importing all dependencies in the single test script is required. 

> example: when testing `alerts.sh`, you must also source `random.sh`, as i use a randomizing function in the worm-alert function.

---

# TODOS

- pretty-print
    - [x] add logging redirection so as to avoid stdout ?? 
    - [x] add level-based log-muting
