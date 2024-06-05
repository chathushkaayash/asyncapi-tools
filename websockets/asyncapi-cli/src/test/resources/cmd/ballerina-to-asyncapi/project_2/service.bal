// Copyright (c) 2023 WSO2 LLC. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 LLC. licenses this file to you under the Apache License,
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

import ballerina/websocket;

listener websocket:Listener ep0 = new(80 );


@websocket:ServiceConfig {dispatcherKey: "type1"}
service /payloadV on ep0{
    resource function get v1/[int id]/v2/[string name](int tag) returns websocket:Service|websocket:UpgradeError {
        return new ChatServer();
    }

}

service class ChatServer{
    *websocket:Service;
     remote function onSubscribe(websocket:Caller caller, Subscribe message) returns int {
        return 5;
    }
}

public type Subscribe record{
    int id;
    string type1;
};
