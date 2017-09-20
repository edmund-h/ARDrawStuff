/*
See LICENSE folder for this sample’s licensing information.

Abstract:
File info
*/

import UIKit
import SceneKit

extension ViewController {
    
    enum SegueIdentifier: String {
        case showSettings
    }
    
    // MARK: - Interface Actions
    
    @IBAction func restartExperience(_ sender: Any) {
        
        guard restartExperienceButtonIsEnabled else { return }
        
        DispatchQueue.main.async {
            self.restartExperienceButtonIsEnabled = false
            
            self.textManager.cancelAllScheduledMessages()
            self.textManager.dismissPresentedAlert()
            self.textManager.showMessage("STARTING A NEW SESSION")
            
            self.virtualObjectManager.removeAllVirtualObjects()
            self.focusSquare?.isHidden = true
            
            self.resetTracking()
            
            //flush drawing data out of memory
            SavedObjectManager.clearCurrent()
            
            self.restartExperienceButton.setImage(#imageLiteral(resourceName: "restart"), for: [])
            
            // Show the focus square after a short delay to ensure all plane anchors have been deleted.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.setupFocusSquare()
            })
            
            // Disable Restart button for a while in order to give the session enough time to restart.
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
                self.restartExperienceButtonIsEnabled = true
            })
        }
    }
    
    //ed- disables the other two buttons and gets location to place the saved obj
    @IBAction func placeAction(_ button: UIButton!) {
        if self.mode == .place {
            print("select pressed: \(virtualObjectManager.pointNodes.count) nodes")
            let places = SavedObjectManager.positions()
            //ed- get focus square's center
            guard let center = focusSquare?.lastPositionOnPlane, places.count > 0 else {
                changeMode(to: nil)
                return
            }
            //ed- get delta needed to translate object locations
            let delta = center - places[0]
            places.forEach{ point in
                //ed- translate each object position near center of focus square
                let location = point + delta
                guard !virtualObjectManager.pointNodeExistAt(pos: location) else {return}
                //ed- draw a box at the location suggested
                let newPoint = PointNode()
                self.sceneView.scene.rootNode.addChildNode(newPoint)
                self.virtualObjectManager.loadVirtualObject(newPoint, to: location)
            }
            focusSquare?.hide()
            //ed- setting mode to nil deselects all buttons
            changeMode(to: nil)
            print("objects loaded: \(virtualObjectManager.pointNodes.count) nodes")
        } else {
            //ed- sets other buttons to deselected state and enables focus square
            changeMode(to: .place)
            if SavedObjectManager.load() {
                focusSquare?.unhide()
                textManager.showMessage("Choose a location to display the saved object, then press Place again")
            }else {
                textManager.showMessage("Could not load object data!")
            }
        }
    }
    
    @IBAction func saveAction(_ button: UIButton!) {
        //ed- tellsSavedObjectManager to save the data
        textManager.showMessage("Saved Object Data!")
        SavedObjectManager.save()
    }
    
    func changeMode(to mode: Mode?) {
        let btnArray = [drawButton, threeDMagicButton, placeButton]
        //ed- if mode is nil, toggles all buttons to unselected
        //if mode has a value, sets corresponding button to selected
        for index in btnArray.indices {
            if index == mode?.rawValue {
                btnArray[index]?.isSelected = true
            } 
            else {
                btnArray[index]?.isSelected = false
            }
        }
        print("mode \(String(describing: mode?.rawValue))")
        self.mode = mode
    }   //ed- this fixes an issue where multiple modes could be active and the button could unalign with the mode it was supposed to represend
    
    enum Mode: Int {
        //ed- correspond to locations of buttons in the changeMode array
        case draw = 0, threeD, place
    }
}


