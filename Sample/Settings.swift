//
//  Settings.swift
//  Sample
//
//  Copyright © 2020 Web Geo Services. All rights reserved.
//

import Foundation
import WoosmapGeofencing

// delay for obsolote notification
let outOfTimeDelay = 300

// Woosmap
let WoosmapKey = "ca9007c3-dc71-41e5-9327-70cdd765d679"
let WoosmapURL = "https://api.woosmap.com"

// Woosmap SearchAPI Key
let searchWoosmapAPI = "\(WoosmapURL)/stores/search/?private_key=\(WoosmapKey)&lat=%@&lng=%@&stores_by_page=1"

// Woosmap DistanceAPI

public var modeDistance = DistanceMode.driving
let distanceWoosmapAPI = "\(WoosmapURL)/distance/distancematrix/json?mode=\(modeDistance)&units=metric&origins=%@,%@&destinations=%@&private_key=\(WoosmapKey)&elements=duration_distance"

//Delay of Duration data
public var dataDurationDelay = 30// number of day
