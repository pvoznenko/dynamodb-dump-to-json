# DynamoDB dump to JSON file

Script for formatting AWS DynamoDB dump to proper JSON file.

## How it works:

* Step 1: With a `sed` command, raw dump data from '$inputFile' file will be cleaned up from unicode characters;
* Step 2: With a `sed` command, raw dump data from '$inputFile' file will be formatted to the JSON objects;
* Step 3: JSON objects will be formatted to the proper representation (correct JSON values), stored at intermediate file '$tmpFile';
* Step 4: Array of the JSON objects will be created and written to the '$outputFile' file.

https://github.com/JasonGhent/AWS-DynamoDB-to-MongoDB
http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_AttributeValue.html

# Copyright

Copyright (C) 2016 Pavlo Voznenko.

Distributed under the MIT License.
