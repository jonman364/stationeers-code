#!/usr/bin/env python3

from datetime import datetime
from glob import glob
from os import walk, listdir, utime
from os.path import expanduser, isdir, join, getmtime
from xml.etree import ElementTree


SCRIPTS_PATH = expanduser("~/Games/Stationeers/scripts")


def to_datetime(n):
    return datetime.fromtimestamp(int(n) / 10000000 - 11644473600)


def from_datetime(n):
    return str(int((n.timestamp() + 11644473600) * 10000000))


def get_scripts():
    if not isdir(SCRIPTS_PATH):
        print(f"Unable to find scripts path {SCRIPTS_PATH}")
        exit(1)

    (_, scripts, _) = next(walk(SCRIPTS_PATH))

    if len(scripts) < 1:
        print(f"Unable to find scripts in {SCRIPTS_PATH}")
        exit(1)

    return scripts


def main():
    scripts = get_scripts()
    game_scripts = {}
    src_scripts = {}

    for script in scripts:
        tree = ElementTree.parse(join(SCRIPTS_PATH, script, "instruction.xml"))
        root = tree.getroot()
        instructions = root.findall("./Instructions")[0].text
        date = to_datetime(root.findall("./DateTime")[0].text)
        game_scripts[script] = (date, instructions)

    for script in glob("*.s"):
        instructions = ""
        with open(script) as fin:
            instructions = fin.read()
        date = datetime.fromtimestamp(getmtime(script))
        src_scripts[script[:-2]] = (date, instructions)

    for script in game_scripts:
        if script not in src_scripts or src_scripts[script][0] < game_scripts[script][0]:
            print(f"Exporting {script}...")
            with open(f"{script}.s", "w") as fout:
                #fout.write("\" vim:syntax=smips\n\n")
                fout.write(game_scripts[script][1])
            date = game_scripts[script][0]
            utime(f"{script}.s", (date.timestamp(), date.timestamp()))

    for script in src_scripts:
        if script not in game_scripts or src_scripts[script][0] > game_scripts[script][0]:
            print(f"Importing {script}...")

            script_path = join(SCRIPTS_PATH, script, "instruction.xml")
            tree = ElementTree.parse(script_path)
            root = tree.getroot()
            root.findall("./Instructions")[0].text = src_scripts[script][1]
            root.findall("./DateTime")[0].text = from_datetime(src_scripts[script][0])
            tree.write(script_path)

if __name__ == "__main__":
    main()
