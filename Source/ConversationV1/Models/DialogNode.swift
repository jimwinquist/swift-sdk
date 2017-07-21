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

/** DialogNode. */
public struct DialogNode: JSONDecodable, JSONEncodable {

    /// How the dialog node is processed.
    public enum NodeType: String {
        case standard = "standard"
        case eventHandler = "event_handler"
        case frame = "frame"
        case slot = "slot"
        case responseCondition = "response_condition"
    }

    /// How an `event_handler` node is processed.
    public enum EventName: String {
        case focus = "focus"
        case input = "input"
        case filled = "filled"
        case validate = "validate"
        case filledMultiple = "filled_multiple"
        case generic = "generic"
        case nomatch = "nomatch"
        case nomatchResponsesDepleted = "nomatch_responses_depleted"
    }

    /// The dialog node ID.
    public let dialogNode: String

    /// The description of the dialog node.
    public let description: String

    /// The condition that triggers the dialog node.
    public let conditions: String

    /// The ID of the parent dialog node.
    public let parent: String

    /// The ID of the previous sibling dialog node.
    public let previousSibling: String

    /// The output of the dialog node.
    public let output: [String: Any]

    /// The context (if defined) for the dialog node.
    public let context: [String: Any]

    /// The metadata (if any) for the dialog node.
    public let metadata: [String: Any]

    public let nextStep: DialogNodeNextStep

    /// The timestamp for creation of the dialog node.
    public let created: String

    /// The timestamp for the most recent update to the dialog node.
    public let updated: String?

    /// The actions for the dialog node.
    public let actions: [DialogNodeAction]?

    /// The alias used to identify the dialog node.
    public let title: String

    /// How the dialog node is processed.
    public let nodeType: String?

    /// How an `event_handler` node is processed.
    public let eventName: String?

    /// The location in the dialog context where output is stored.
    public let variable: String?

    /**
     Initialize a `DialogNode` with member variables.

     - parameter dialogNode: The dialog node ID.
     - parameter description: The description of the dialog node.
     - parameter conditions: The condition that triggers the dialog node.
     - parameter parent: The ID of the parent dialog node.
     - parameter previousSibling: The ID of the previous sibling dialog node.
     - parameter output: The output of the dialog node.
     - parameter context: The context (if defined) for the dialog node.
     - parameter metadata: The metadata (if any) for the dialog node.
     - parameter nextStep: 
     - parameter created: The timestamp for creation of the dialog node.
     - parameter title: The alias used to identify the dialog node.
     - parameter updated: The timestamp for the most recent update to the dialog node.
     - parameter actions: The actions for the dialog node.
     - parameter nodeType: How the dialog node is processed.
     - parameter eventName: How an `event_handler` node is processed.
     - parameter variable: The location in the dialog context where output is stored.

     - returns: An initialized `DialogNode`.
    */
    public init(dialogNode: String, description: String, conditions: String, parent: String, previousSibling: String, output: [String: Any], context: [String: Any], metadata: [String: Any], nextStep: DialogNodeNextStep, created: String, title: String, updated: String? = nil, actions: [DialogNodeAction]? = nil, nodeType: String? = nil, eventName: String? = nil, variable: String? = nil) {
        self.dialogNode = dialogNode
        self.description = description
        self.conditions = conditions
        self.parent = parent
        self.previousSibling = previousSibling
        self.output = output
        self.context = context
        self.metadata = metadata
        self.nextStep = nextStep
        self.created = created
        self.title = title
        self.updated = updated
        self.actions = actions
        self.nodeType = nodeType
        self.eventName = eventName
        self.variable = variable
    }

    // MARK: JSONDecodable
    /// Used internally to initialize a `DialogNode` model from JSON.
    public init(json: JSON) throws {
        dialogNode = try json.getString(at: "dialog_node")
        description = try json.getString(at: "description")
        conditions = try json.getString(at: "conditions")
        parent = try json.getString(at: "parent")
        previousSibling = try json.getString(at: "previous_sibling")
        output = try json.getDictionaryObject(at: "output")
        context = try json.getDictionaryObject(at: "context")
        metadata = try json.getDictionaryObject(at: "metadata")
        nextStep = try json.decode(at: "next_step", type: DialogNodeNextStep.self)
        created = try json.getString(at: "created")
        updated = try? json.getString(at: "updated")
        actions = try? json.decodedArray(at: "actions", type: DialogNodeAction.self)
        title = try json.getString(at: "title")
        nodeType = try? json.getString(at: "type")
        eventName = try? json.getString(at: "event_name")
        variable = try? json.getString(at: "variable")
    }

    // MARK: JSONEncodable
    /// Used internally to serialize a `DialogNode` model to JSON.
    public func toJSONObject() -> Any {
        var json = [String: Any]()
        json["dialog_node"] = dialogNode
        json["description"] = description
        json["conditions"] = conditions
        json["parent"] = parent
        json["previous_sibling"] = previousSibling
        json["output"] = output
        json["context"] = context
        json["metadata"] = metadata
        json["next_step"] = nextStep.toJSONObject()
        json["created"] = created
        json["title"] = title
        if let updated = updated { json["updated"] = updated }
        if let actions = actions {
            json["actions"] = actions.map { $0.toJSONObject() }
        }
        if let nodeType = nodeType { json["type"] = nodeType }
        if let eventName = eventName { json["event_name"] = eventName }
        if let variable = variable { json["variable"] = variable }
        return json
    }
}
