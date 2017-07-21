/**
 * Copyright IBM Corporation 2017
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import Foundation
import RestKit

/** DialogNodeAction. */
public struct DialogNodeAction: JSONDecodable, JSONEncodable {

    /// The type of action to invoke.
    public enum ActionType: String {
        case client = "client"
        case server = "server"
    }

    /// The name of the action.
    public let name: String

    /// The type of action to invoke.
    public let actionType: String?

    /// A map of key/value pairs to be provided to the action.
    public let parameters: [String: Any]?

    /// The location in the dialog context where the result of the action is stored.
    public let resultVariable: String

    /**
     Initialize a `DialogNodeAction` with member variables.

     - parameter name: The name of the action.
     - parameter resultVariable: The location in the dialog context where the result of the action is stored.
     - parameter actionType: The type of action to invoke.
     - parameter parameters: A map of key/value pairs to be provided to the action.

     - returns: An initialized `DialogNodeAction`.
    */
    public init(name: String, resultVariable: String, actionType: String? = nil, parameters: [String: Any]? = nil) {
        self.name = name
        self.resultVariable = resultVariable
        self.actionType = actionType
        self.parameters = parameters
    }

    // MARK: JSONDecodable
    /// Used internally to initialize a `DialogNodeAction` model from JSON.
    public init(json: JSON) throws {
        name = try json.getString(at: "name")
        actionType = try? json.getString(at: "type")
        parameters = try? json.getDictionaryObject(at: "parameters")
        resultVariable = try json.getString(at: "result_variable")
    }

    // MARK: JSONEncodable
    /// Used internally to serialize a `DialogNodeAction` model to JSON.
    public func toJSONObject() -> Any {
        var json = [String: Any]()
        json["name"] = name
        json["result_variable"] = resultVariable
        if let actionType = actionType { json["type"] = actionType }
        if let parameters = parameters { json["parameters"] = parameters }
        return json
    }
}
