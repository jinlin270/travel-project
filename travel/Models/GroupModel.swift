//
//  GroupModel.swift
//  travel
//
//  Created by Lin Jin on 1/22/25.
//

import SwiftUI
import MapKit

struct GroupModel: Identifiable, Equatable, Decodable{
    var id: Int
    var groupName: String
    var profilePicture: String
    var isPublic: Bool
    var members: [User] = []
    var numMembers: Int
    var filterTags: Set<String>
    var latitude: Double
    var longitude : Double
    var location: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func ==(lhs: GroupModel, rhs: GroupModel) -> Bool {
            return lhs.id == rhs.id
        }
}

 
