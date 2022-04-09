#!/usr/bin/env python3
#
# simple script to sync dotfiles
#

import shutil
import sys
from pathlib import Path

# convert to absolute paths
dotfiles_dir = Path(__file__).parent.absolute().joinpath("dotfiles/")
home_dir = Path.home()
path = Path("~/.local/bin/").absolute()


def init():
    """ install script into path, link files """
    Path(__file__).symlink_to(path)
    link()


def clean():
    """ unlink script from path, unlink files """
    path.joinpath("dots.py").unlink()
    unlink()


def link():
    """ Link the contents of ./dotfiles/ to home dir """
    for file in dotfiles_dir.iterdir():
        dest = home_dir.joinpath(file.name)
        print(f"linking {file.absolute()} to {dest.absolute()}")

        if dest.exists():
            if dest.is_symlink():
                print(f"{dest.absolute()} exists")
                break
            else:
                print(f"{dest.absolute()} exists, making backup")
                dest.rename(dest.name + ".backup")

        try:
            dest.symlink_to(file)
        except:
            print("Failed to symlink {file.absolute} to {dest.absolute}")


def unlink():
    """ Unlink files in ./dotfiles/ linked to $HOME """
    for file in dotfiles_dir.iterdir():
        dest = home_dir.joinpath(file.name)
        print(f"unlinking ${dest.absolute()}")

        if dest.exists():
            if dest.is_symlink() and dest.resolve() == file.absolute():
                dest.unlink()
            else:
                print(f"{dest.absolute()} exists, making backup")
                dest.rename(dest.name + ".backup")

        try:
            shutil.copy2(file, dest)
        except shutil.SameFileError:
            print("Failed to copy {file} to {dest}: files are identical")
        except:
            print("Failed to copy {file.absolute} to {dest.absolute}")


def main():
    """ main function """
    try:
        arg = sys.argv[1]
        if arg == "link":
            link()
        elif arg == "unlink":
            unlink()
        elif arg == "init":
            init()

        elif(arg == "clean"):
            clean()
        elif(arg == "help"):
            print("Available arguments: link, unlink, init, clean, help")
        else:
            print("Invalid argument")

    except:
        print("No arguments provided")


if __name__ == "__main__":
    main()
