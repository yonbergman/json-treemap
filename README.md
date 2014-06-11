# JSON Treemap visualizer

A small tool to help you debug your JSON files, find out where the mass of your node are.

![](https://raw.githubusercontent.com/yonbergman/json-treemap/master/screenshot.png)

## Installation

Clone this repo, and run `bundle install`

## Usage

To see an example convert the provided `example.json` from Rotten Tomatoes run the following commands

```sh
./treemap.rb convert -i example.json
./treemap.rb show
```

This should open a web page with a tree map for the example json

### Converting JSON files

```
Usage:
  treemap.rb convert -i, --input=INPUT

Options:
  -i, --input=INPUT
  -o, [--output=OUTPUT]
                         # Default: treemap.json
  -d, [--max-depth=N]
                         # Default: 4

convert json file to treemap format
```

## Thanks
The code for displaying the treemap is based on d3 and derived from [Mike Bostock](https://github.com/mbostock)'s [treemap](http://bl.ocks.org/mbostock/4063582) example
