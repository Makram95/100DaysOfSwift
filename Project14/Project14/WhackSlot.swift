//
//  WhackSlot.swift
//  Project14
//
//  Created by Marc on 10.02.21.
//

import UIKit
import SpriteKit

class WhackSlot: SKNode {

    var charNode: SKSpriteNode!
    
    var isVisible = false
    var isHit = false
    
    func configure(at position: CGPoint){
        self.position = position
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
        
        let cropNope = SKCropNode()
        cropNope.position = CGPoint(x: 0, y: 15)
        cropNope.zPosition = 1
        cropNope.maskNode = SKSpriteNode(imageNamed: "whackMask")
        
        charNode = SKSpriteNode(imageNamed: "penguinGood")
        charNode.position = CGPoint(x: 0, y: -90)
        charNode.name = "character"
        cropNope.addChild(charNode)
        
        addChild(cropNope)
    }
    
    func show(hideTime: Double){
        
        if isVisible{ return }
        
        charNode.xScale = 1
        charNode.yScale = 1
        
        charNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.05))
        isVisible = true
        isHit = false
        
        if Int.random(in: 0...2) == 0 {
            charNode.texture = SKTexture(imageNamed: "penguinGood")
            charNode.name = "charFriend"
        } else {
            charNode.texture = SKTexture(imageNamed: "penguinEvil")
            charNode.name = "charEnemy"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (3.5 * hideTime)) {
            [weak self] in
            self?.hide()
        }
    }
    
    func hide(){
        if !isVisible{ return }
    
        charNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.05))
        isVisible=false
    }
    
    func hit(){
        isHit = true
        let delay = SKAction.wait(forDuration: 0.25)
        let hide = SKAction.moveBy(x: 0, y: -80, duration: 0.5)
        let notVisible = SKAction.run { [weak self] in self?.isVisible = false}
        
        let sequence = SKAction.sequence([delay, hide, notVisible])
        charNode.run(sequence)
    }
    
}
