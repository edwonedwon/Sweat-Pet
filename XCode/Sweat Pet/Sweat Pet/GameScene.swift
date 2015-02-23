import Foundation
import SpriteKit

class GameScene : SKScene {
    
    let pet = SKSpriteNode(imageNamed: "pet")
    
    override func didMoveToView(view: SKView) {
        // 2
        backgroundColor = UIColor(red: 0.58, green: 0.84, blue: 0.78, alpha: 1)
        // 3
        pet.position = CGPoint(x: size.width * 0.5, y: size.height * 0.40)
        pet.size = CGSize(width: 387 * 0.6, height: 384 * 0.6)
//        pet.userInteractionEnabled = true; // this is weird, need to research
        pet.name = "pet"
        
        // 4
        addChild(pet)
        
//        self.physicsWorld.gravity = CGVectorMake(0.0, -2)
//        pet.physicsBody = SKPhysicsBody(circleOfRadius: pet.size.height)
//        pet.physicsBody?.dynamic = true
        
//        runAction(SKAction.repeatActionForever(
//            SKAction.sequence([
//                SKAction.runBlock(bounce),
//                SKAction.waitForDuration(2.0)
//                ])
//            ))
        
    }
    
    override func update(currentTime: NSTimeInterval) {
//        println(pet.name)
    }
    
    override func didSimulatePhysics() {
//        pet.position.x += 1;
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = (touch as! UITouch).locationInNode(self)
            // if touched pet
            if (self.nodeAtPoint(location).name == "pet") {
                pet.position.x = location.x
                pet.position.y = location.y
//                bounce()
            }
        }
    }

    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = (touch as! UITouch).locationInNode(self)
            if (self.nodeAtPoint(location).name == "pet") {
                pet.position.x = location.x
                pet.position.y = location.y
            }
        }
    }
    
    func switchImage () {
//        println("switch image")
    }
    
    func bounce() {
        
        let bounceHeight = CGFloat(30.0)
        let bounceDuration = NSTimeInterval(0.1)
        let actionBounce = SKAction.moveBy(CGVector(dx: 0, dy: bounceHeight), duration: bounceDuration)
        actionBounce.timingMode = SKActionTimingMode.EaseOut
        let actionBounceReturn = SKAction.moveBy(CGVector(dx: 0, dy: -bounceHeight), duration: bounceDuration)
        actionBounceReturn.timingMode = SKActionTimingMode.EaseIn

        pet.runAction(SKAction.sequence([
            actionBounce,
            SKAction.waitForDuration(0.1),
            actionBounceReturn
            ]))
    }

}
