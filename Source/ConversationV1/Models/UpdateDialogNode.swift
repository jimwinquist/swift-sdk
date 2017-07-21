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

/** UpdateDialogNode. */
public struct UpdateDialogNode: JSONDecodable, JSONEncodable {

    /// How the node is processed.
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
    public let description: String?

    /// The condition that will trigger the dialog node.
    public let conditions: String?

    /// The ID of the parent dialog node (if any).
    public let parent: String?

    /// The previous dialog node.
    public let previousSibling: String?

    /// The output of the dialog node.
    public let output: [String: Any]?

    /// The context for the dialog node.
    public let context: [String: Any]?

    /// The metadata for the dialog node.
    public let metadata: [String: Any]?

    public let nextStep: DialogNodeNextStep?

    /// The alias used to identify the dialog node.
    public let title: String?

    /// How the node is processed.
    public let nodeType: String?

    /// How an `event_handler` node is processed.
    public let eventName: String?

    /// The location in the dialog context where output is stored.
    public let variable: String?

    /// The actions for the dialog node.
    public let actions: [DialogNodeAction]?

    /**
     Initialize a `UpdateDialogNode` with member variables.

     - parameter dialogNode: The dialog node ID.
     - parameter description: The description of the dialog node.
     - parameter conditions: The condition that will trigger the dialog node.
     - parameter parent: The ID of the parent dialog node (if any).
     - parameter previousSibling: The previous dialog node.
     - parameter output: The output of the dialog node.
     - parameter context: The context for the dialog node.
     - parameter metadata: The metadata for the dialog node.
     - parameter nextStep: 
     - parameter title: The alias used to identify the dialog node.
     - parameter nodeType: How the node is processed.
     - parameter eventName: How an `event_handler` node is processed.
     - parameter variable: The location in the dialog context where output is stored.
     - parameter actions: The actions for the dialog node.

     - returns: An initialized `UpdateDialogNode`.
    */
    public init(dialogNode: String, description: String? = nil, conditions: String? = nil, parent: String? = nil, previousSibling: String? = nil, output: [String: Any]? = nil, context: [String: Any]? = nil, metadata: [String: Any]? = nil, nextStep: DialogNodeNextStep? = nil, title: String? = nil, nodeType: String? = nil, eventName: String? = nil, variable: String? = nil, actions: [DialogNodeAction]? = nil) {
        self.dialogNode = dialogNode
        self.description = description
        self.conditions = conditions
        self.parent = parent
        self.previousSibling = previousSibling
        self.output = output
        self.context = context
        self.metadata = metadata
        self.nextStep = nextStep
        self.title = title
        self.nodeType = nodeType
        self.eventName = eventName
        self.variable = variable
        self.actions = actions
    }

    // MARK: JSONDecodable
    /// Used internally to initialize a `UpdateDialogNode` model from JSON.
    public init(json: JSON) throws {
        dialogNode = try json.getString(at: "dialog_node")
        description = try? json.getString(at: "description")
        conditions = try? json.getString(at: "conditions")
        parent = try? json.getString(at: "parent")
        previousSibling = try? json.getString(at: "previous_sibling")
        output = try? json.getDictionaryObject(at: "output")
        context = try? json.getDictionaryObject(at: "context")
        metadata = try? json.getDictionaryObject(at: "metadata")
        nextStep = try? json.decode(at: "next_step", type: DialogNodeNextStep.self)
        title = try? json.getString(at: "title")
        nodeType = try? json.getString(at: "type")
        eventName = try? json.getString(at: "event_name")
        variable = try? json.getString(at: "variable")
        actions = try? json.decodedArray(at: "actions", type: DialogNodeAction.self)
    }

    // MARK: JSONEncodable
    /// Used internally to serialize a `UpdateDialogNode` model to JSON.
    public func toJSONObject() -> Any {
        var json = [String: Any]()
        json["dialog_node"] = dialogNode
        if let description = description { json["description"] = description }
        if let conditions = conditions { json["conditions"] = conditions }
        if let parent = parent { json["parent"] = parent }
        if let previousSibling = previousSibling { json["previous_sibling"] = previousSibling }
        if let output = output { json["output"] = output }
        if let context = context { json["context"] = context }
        if let metadata = metadata { json["metadata"] = metadata }
        if let nextStep = nextStep { json["next_step"] = nextStep.toJSONObject() }
        if let title = title { json["title"] = title }
        if let nodeType = nodeType { json["type"] = nodeType }
        if let eventName = eventName { json["event_name"] = eventName }
        if let variable = variable { json["variable"] = variable }
        if let actions = actions {
            json["actions"] = actions.map { $0.toJSONObject() }
        }
        return json
    }
}
