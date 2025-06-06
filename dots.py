#!/usr/bin/env python3
#
# simple script to sync dotfiles
# usage: python3 dots.py [argument]
#

import sys, shutil, subprocess
from pathlib import Path

# convert to absolute paths
dotfiles_dir = Path(__file__).parent.resolve().joinpath("dotfiles/")
backup_dir = Path(__file__).parent.resolve().joinpath("dotfiles.backup/")
home_dir = Path.home()

# create backup dir if not exists
backup_dir.mkdir(exist_ok=True, parents=True)

def clean():
    """unlink script from path, unlink files"""
    unlink()

def link():
    """Link the contents of ./dotfiles/ to home dir"""
    config_dir = dotfiles_dir.joinpath(".config")

    for file in dotfiles_dir.iterdir():
        dest = home_dir.joinpath(file.name)
        print(f"linking {file.absolute()} to {dest.absolute()}")

        if not file.is_file() and file.name == ".config":
            print("found .config dir, skipping")

        if dest.exists():
            if dest.is_symlink():
                print(f"{dest.absolute()} exists and is already a symlink, skipping")
                continue
            else:
                backup_file = Path(backup_dir.as_posix()).joinpath(dest.name)
                print(
                    f"{dest.absolute()} exists and is not a symlink, copying to {backup_file.absolute()}"
                )

                backup_file.unlink()

            dest.rename(backup_file)

        dest.symlink_to(file)

    directory = config_dir
    dest = home_dir.joinpath(".config")
    backup = home_dir.joinpath("" + directory.name + ".backup")
    
    if home_dir.joinpath(".config").exists():
        # Copy *contents* of dotfiles/.config to ~/.config
        print(f"Copying contents of {directory.absolute} to {dest.absolute}")
        shutil.copytree(src=directory.absolute(), dst=dest.absolute(), symlinks=True, dirs_exist_ok=True)
        
        print(f"Backing up {dotfiles.absolute()} to {backup.absolute()}")
        shutil.copytree(src=backup.absolute(), dst=directory.absolute(), symlinks=True, dirs_exist_ok=True)

        
        print(f"Symlinking {directory.absolute()} to home dir")
        shutil.rmtree(directory.absolute())
        shutil.move(src=dest.absolute(), dst=directory.absolute())
    
    dest.symlink_to(directory)

    print("Linking complete")

def unlink():
    """Unlink files in ./dotfiles/ linked to $HOME"""

    for file in dotfiles_dir.iterdir():
        dest = home_dir.joinpath(file.name)
        print(f"unlinking {dest.absolute()}")

        if dest.exists() and dest.is_symlink():
            dest.unlink()
        else:
            print(f"{dest.absolute()} not found or isn't a symlink")

    print("Unlinking complete")

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
