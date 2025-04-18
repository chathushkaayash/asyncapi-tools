//  Copyright (c) 2025, WSO2 LLC. (http://www.wso2.org).
//
//  WSO2 LLC. licenses this file to you under the Apache License,
//  Version 2.0 (the "License"); you may not use this file except
//  in compliance with the License.
//  You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the License is distributed on an
//  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//  KIND, either express or implied. See the License for the
//  specific language governing permissions and limitations
//  under the License.

import ballerina/websocket;

listener websocket:Listener l5 = check new (9092);

@websocket:ServiceConfig {dispatcherKey: "event"}
service / on l5 {

    resource function get .() returns websocket:Service|websocket:UpgradeError {
        return new onErrorService();
    }
}

service class onErrorService {
    *websocket:Service;

    isolated remote function onHello(Hello message) returns Response|websocket:CloseFrame {
        return {message: "You sent: " + message.message};
    }

    isolated remote function onHelloError(error message) returns websocket:MessageTooBig {
        return websocket:MESSAGE_TOO_BIG;
    }

    isolated remote function onSubscribe(Subscribe message) returns SubscribeResponse {
        return {id: message.subscribeId};
    }

    isolated remote function onError(Hello message) returns websocket:NormalClosure {
        return websocket:NORMAL_CLOSURE;
    }
}
