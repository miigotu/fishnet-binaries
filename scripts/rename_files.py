#!/usr/bin/env python3
import argparse
import os
from pathlib import Path


def check_arguments():
    parser = argparse.ArgumentParser(description="Rename binaries for multiple different architectures to include arh in the filename")
    parser.add_argument("--binary_directory", dest="binary_directory", metavar="Input directory", type=Path, help="Location of the files to be renamed")
    parser.add_argument("--output_directory", dest="output_directory", metavar="Output directory", type=Path, help="Location to move the renamed files to")
    parser.add_argument("--get_names", dest="get_names", type=bool, metavar="Get list of final file names", help="Names of all files that were renamed")

    args = parser.parse_args()

    if not (args.output_directory and args.binary_directory) and not args.get_names:
        parser.print_help()
        parser.exit()

    if not args.binary_directory.is_dir():
        # noinspection PyProtectedMember
        parser._print_message("Source directory must exist!\n")
        parser.print_help()
        parser.exit()

    return args


def main():
    args: argparse.Namespace = check_arguments()
    os.chdir(args.output_directory)

    final_file_names = []
    for binary in args.binary_directory.rglob("**/fishnet"):
        relative = binary.relative_to(args.binary_directory)
        parts = str(relative).split(os.sep)
        new_location = args.output_directory / "-".join(parts[-1:] + parts[:-1])

        if args.get_names:
            final_file_names.append(new_location)
        else:
            os.rename(binary, new_location)

    if args.get_names:
        return " ".join(f"\"{item}\"" for item in final_file_names)


if __name__ == "__main__":
    main()
