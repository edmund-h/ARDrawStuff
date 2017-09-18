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
        if SavedObjectManager.load() {
            textManager.showMessage("Choose a location to display the saved object, then press Place again")
            placeButton.isSelected = !placeButton.isSelected
            in3DMode = false
            threeDMagicButton.isSelected = in3DMode
            inDrawMode = false
            drawButton.isSelected = inDrawMode
            
        } else {
            textManager.showMessage("Could not load object data!")
        }
    }
    
    @IBAction func saveAction(_ button: UIButton!) {
        textManager.showMessage("Saved Object Data!")
        SavedObjectManager.save()
    }
    
}
