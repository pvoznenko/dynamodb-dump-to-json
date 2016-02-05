# DynamoDB dump to JSON

Script for formatting `AWS DynamoDB` dump to proper `JSON` file.

## Setup

You should have [NodeJS](https://nodejs.org/en/) and [Sed](https://en.wikipedia.org/wiki/Sed) to be installed.

## Usage

Use `run.sh` script to perform trasnformation of raw `DynamoDB` dump file to `JSON` file:

```
$ ./run.sh <dump_file_name> <output_file_name>
```

You also can run script without parameters, then it will use default values of the parameters, like:

```
$ ./run.sh raw-data output-data.json
```

Where file `raw-data` you can find in this repositories with some examples of `DynamoDB` dump data.

## How to get AWS DynamoDB dump?

To get `DynamoDB` dump from `AWS` you need to setup data pipeline. 

How to do it, you can read about it in `AWS` documentation:
[Export Data from DynamoDB](http://docs.aws.amazon.com/datapipeline/latest/DeveloperGuide/dp-importexport-ddb-part2.html)

## How the script works

First with a `sed` command line tool, dump data file will be cleaned up from the unicode characters and formatted to the `JSON` objects. Example of the command:

```
sed -e 's/$/}/' -e $'s/\x02/,"/g' -e $'s/\x03/":/g' -e 's/^/{"/' <dump_file_name> > <output_file_name>
```

Then with small `javascript` script data will be formatted to the proper `JSON` objects representation with correct `JSON` values (instead of `{"key": "string value"}` dump stores `{"key": {"s": "string value"}}`). 

Later `JSON` objects will be wrapped in array and put to the output file.

Beaware that currently `javascript` script knows how to work with `numbers` and `strings` values at dump. 
To make it handle another types, please tweek the script.

Full list of `DynamoDB` values types you can find in `AWS` documentation: 
[http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_AttributeValue.html](http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_AttributeValue.html)

## Inspiration and reference

For the inspiration I took the repository [https://github.com/JasonGhent/AWS-DynamoDB-to-MongoDB](https://github.com/JasonGhent/AWS-DynamoDB-to-MongoDB). Thank you [Jason Ghent](https://github.com/JasonGhent) for your help!

# Copyright

Copyright (C) 2016 Pavlo Voznenko.

Distributed under the MIT License.
