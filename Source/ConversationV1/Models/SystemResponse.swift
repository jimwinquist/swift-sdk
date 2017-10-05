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

/** For internal use only. */
public struct SystemResponse {

    /// Additional properties associated with this model.
    public let additionalProperties: [String: JSONValue]?

    /**
     Initialize a `SystemResponse`.

     - returns: An initialized `SystemResponse`.
    */
    public init(additionalProperties: [String: JSONValue]? = nil) {
        self.additionalProperties = additionalProperties
    }
}

extension SystemResponse: Codable {
    
    public init(from decoder: Decoder) throws {
        let dynamic = try decoder.container(keyedBy: DynamicKeys.self)
        additionalProperties = try dynamic.decodeIfPresent([String: JSONValue].self, excluding: [CodingKey]())
    }

    public func encode(to encoder: Encoder) throws {
        var dynamic = encoder.container(keyedBy: DynamicKeys.self)
        try dynamic.encodeIfPresent(additionalProperties)
    }

}
