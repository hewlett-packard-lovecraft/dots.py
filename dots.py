#!/usr/bin/env python3
#
# simple script to sync dotfiles
# usage: python3 dots.py [argument]
#

import sys
from pathlib import Path

# convert to absolute paths
dotfiles_dir = Path(__file__).parent.resolve().joinpath("dotfiles/")
backup_dir = Path(__file__).parent.resolve().joinpath("dotfiles.backup/")
home_dir = Path.home()


def clean():
    """unlink script from path, unlink files"""
    unlink()


def link():
    """Link the contents of ./dotfiles/ to home dir"""

    for file in dotfiles_dir.iterdir():
        dest = home_dir.joinpath(file.name)
        print(f"linking {file.absolute()} to {dest.absolute()}")

        if dest.exists():
            if dest.is_symlink():
                print(f"{dest.absolute()} exists and is already a symlink")
                continue
            else:
                backup_file = Path(backup_dir.as_posix()).joinpath(dest.name)
                print(
                    f"{dest.absolute()} exists and is not a symlink, copying to {backup_file.absolute()}"
                )

                if backup_file.exists():
                    backup_file.unlink()

                dest.rename(backup_file)

        dest.symlink_to(file)


def unlink():
    """Unlink files in ./dotfiles/ linked to $HOME"""

    for file in dotfiles_dir.iterdir():
        dest = home_dir.joinpath(file.name)
        print(f"unlinking {dest.absolute()}")

        if dest.exists() and dest.is_symlink():
            dest.unlink()
        else:
            print(f"{dest.absolute()} not found or isn't a symlink")


def main():
    """main function"""
    arg = sys.argv[1]

    if arg == "link":
        link()
    elif arg == "unlink":
        unlink()
    elif arg == "clean":
        clean()
    elif arg == "help":
        print("Available arguments: link, unlink, clean, help")
    elif arg == "":
        print("No arguments provided")
    else:
        print("Invalid argument")


if __name__ == "__main__":
    main()
