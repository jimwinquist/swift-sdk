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

/** WorkspaceCollection. */
public struct WorkspaceCollection: JSONDecodable, JSONEncodable {

    /// An array of workspaces.
    public let workspaces: [Workspace]

    /// An object defining the pagination data for the returned objects.
    public let pagination: Pagination

    /**
     Initialize a `WorkspaceCollection` with member variables.

     - parameter workspaces: An array of workspaces.
     - parameter pagination: An object defining the pagination data for the returned objects.

     - returns: An initialized `WorkspaceCollection`.
    */
    public init(workspaces: [Workspace], pagination: Pagination) {
        self.workspaces = workspaces
        self.pagination = pagination
    }

    // MARK: JSONDecodable
    /// Used internally to initialize a `WorkspaceCollection` model from JSON.
    public init(json: JSON) throws {
        workspaces = try json.decodedArray(at: "workspaces", type: Workspace.self)
        pagination = try json.decode(at: "pagination", type: Pagination.self)
    }

    // MARK: JSONEncodable
    /// Used internally to serialize a `WorkspaceCollection` model to JSON.
    public func toJSONObject() -> Any {
        var json = [String: Any]()
        json["workspaces"] = workspaces.map { $0.toJSONObject() }
        json["pagination"] = pagination.toJSONObject()
        return json
    }
}
