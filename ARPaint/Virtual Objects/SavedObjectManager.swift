//
//  SavedObjectManager.swift
//  ARPaint
//
//  Created by Edmund Holderbaum on 9/18/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import ARKit

class SavedObjectManager {
    static var current: [float3] = []
    static var height: Float = 0.00001
    
    class func save() {
        //ed- current object vectors are saved in user defaults
        var currentDict: [String:[String:Float]] = [:]
        for index in current.indices {
            let indexString = String(index)
            //ed- parameters are saved by string key
            let float3Data: [String:Float] = [
                "x" : current[index].x,
                "y" : current[index].y,
                "z" : current[index].z,
                "height" : height
            ]
            currentDict[indexString] = float3Data
        }
        UserDefaults.standard.setValue(currentDict, forKeyPath: "SavedObject")
    }
    
    class func load()-> Bool {
        //ed- objects and their height are loaded from user defaults.
        var temp: [float3] = []
        var tempHeight: Float = 0.00001
        if let objectDict = UserDefaults.standard.object(forKey: "SavedObject") as? [String:Any]{
            for index in Array(objectDict.keys).indices {
                if let value = objectDict["\(index)"] as? [String:Float],
                    let valueX = value["x"],
                    let valueY = value["y"],
                    let valueZ = value["z"],
                    let valueHeight = value["height"]{
                    let position = float3(valueX, valueY, valueZ)
                    print("loaded \(position.debugDescription)")
                    tempHeight = valueHeight
                    temp.append(position)
                }else{
                    print("corrupt object data")
                    return false
                }
            }
            print("successfully loaded object data into SavedObjectManager")
            current = temp
            height = tempHeight
            return true
        }
        print("could not get object data")
        return false
    }
    
    // MARK: Helper functions
    class func positions()-> [float3] {
        let toReturn: [float3]  = current
        clearCurrent()
        return toReturn
    }
    
    class func add(_ position: float3) {
        current.append(position)
    }
    
    class func set(toHeight: Float) {
        height = toHeight
    }
    
    class func clearCurrent() {
        current = []
        height = 0.00001
    }
}
