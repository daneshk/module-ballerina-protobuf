// Copyright (c) 2021 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

# Represents a stream of structs.
public class StructStream {
    private stream<anydata, error?> anydataStream;

    # Initialize the stream.
    #
    # + anydataStream - anydata stream
    public isolated function init(stream<anydata, error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    # Retrieve the next value of the stream.
    #
    # + return - Returns the next value of the stream or else an error
    public isolated function next() returns record {|map<anydata> value;|}|error? {
        var streamValue = self.anydataStream.next();
        if streamValue is error? {
            return streamValue;
        } else {
            return {value: <map<anydata>>streamValue.value};
        }
    }

    # Close the stream.
    #
    # + return - Returns an error if failed to close the stream
    public isolated function close() returns error? {
        return self.anydataStream.close();
    }
}

# Context representation record of a struct stream.
#
# + content - Stream of structs(gRPC `Struct` is represented using `map<anydata>`)
# + headers - The headers map
public type ContextStructStream record {|
    stream<map<anydata>, error?> content;
    map<string|string[]> headers;
|};

# Context representation record of a struct.
#
# + content - The struct value represented using `map<anydata>`
# + headers - The headers map
public type ContextStruct record {|
    map<anydata> content;
    map<string|string[]> headers;
|};