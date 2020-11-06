"""

Prints the content between bookdown start/end into a json file
(for searching)

"""

import sys
import os.path
import re
import subprocess
import argparse
import json

re_space = re.compile(r"[\t\s\n]+")
def parse_content(text):
    text = re_space.sub(' ', text)
    
    # Fails if content region is not found in file
    try:
        _, text = text.split('<!--bookdown:body:start-->', maxsplit=1)
    except ValueError:
        return ''

    text, _ = text.rsplit('<!--bookdown:body:end-->', maxsplit=1)
    
    # Use pandoc to convert to text
    text = subprocess.check_output(['pandoc', '--to=plain', '--wrap=none'], input=text.encode())
    text = text.decode()

    text = re_space.sub(' ', text)
    return text

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('html_files', nargs='+')
    args = parser.parse_args()

    data = []
    
    for f in args.html_files:
        with open(f, 'r') as fh:
            text = fh.read()

        f = os.path.basename(f)
        text = parse_content(text)

        data.append([f, text])

    print(json.dumps(data))
    return

if __name__ == '__main__':
    main()

