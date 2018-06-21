//
//  TanuGotchi.swift
//  TanuGotchiSimple
//
//  Created by Kalcsevszki Regina on 2018. 06. 19..
//  Copyright © 2018. Kalcsevszki Regina. All rights reserved.
//

import Foundation
import SpriteKit

class TanuGotchi : SKScene {
    
    private var bunny = SKSpriteNode()
    private var bunnyFrames: [SKTexture] = []
    private var timeFrame = 0.5
    
    let user : User = AppModel.getUser()

    override func didMove(to view: SKView) {
        backgroundColor = .white
        
        refresh()
    }
    
    func refresh() {
        removeAllChildren()
        let points = user.getPoints()
        if points > 10 {
            buildHappyBunny()
        } else {
            if points > -10 {
                buildSleepyBunny()
            } else {
                buildSadBunny()
            }
        }
        animateBunny()
    }
    
    
    func buildHappyBunny() {
        let bunnyAnimatedAtlas = SKTextureAtlas(named: "happybunny")
        var walkFrames: [SKTexture] = []
        
        let numImages = bunnyAnimatedAtlas.textureNames.count
        for i in 0...numImages-1 {
            let bunnyTextureName = "happybunny_\(i)"
            walkFrames.append(bunnyAnimatedAtlas.textureNamed(bunnyTextureName))
        }
        bunnyFrames = walkFrames
        
        let firstFrameTexture = bunnyFrames[0]
        bunny = SKSpriteNode(texture: firstFrameTexture)
        bunny.position = CGPoint(x: frame.midX, y: frame.midY)
        bunny.setScale(0.75)
        addChild(bunny)
        timeFrame = 0.2
        
    }
    
    func buildSleepyBunny() {
        let bunnyAnimatedAtlas = SKTextureAtlas(named: "sleepybunny")
        var walkFrames: [SKTexture] = []
        
        let numImages = bunnyAnimatedAtlas.textureNames.count
        for i in 1...numImages {
            let bunnyTextureName = "sleepy\(i)"
            walkFrames.append(bunnyAnimatedAtlas.textureNamed(bunnyTextureName))
        }
        bunnyFrames = walkFrames
        
        let firstFrameTexture = bunnyFrames[0]
        bunny = SKSpriteNode(texture: firstFrameTexture)
        bunny.position = CGPoint(x: frame.size.width/3*2.5, y: frame.size.height/4*3.5)
        bunny.setScale(0.25)
        addChild(bunny)
        timeFrame = 1
    }
    
    func buildSadBunny() {
        let bunnyAnimatedAtlas = SKTextureAtlas(named: "sadbunny")
        var walkFrames: [SKTexture] = []
        
        let numImages = bunnyAnimatedAtlas.textureNames.count
        for i in 1...numImages {
            let bunnyTextureName = "sad\(i)"
            walkFrames.append(bunnyAnimatedAtlas.textureNamed(bunnyTextureName))
        }
        bunnyFrames = walkFrames
        
        let firstFrameTexture = bunnyFrames[0]
        bunny = SKSpriteNode(texture: firstFrameTexture)
        bunny.position = CGPoint(x: frame.midX, y: frame.midY)
        bunny.setScale(0.4)
        addChild(bunny)
        timeFrame = 0.5
        
    }
    
    func animateBunny() {
        bunny.run(SKAction.repeatForever(
            SKAction.animate(with: bunnyFrames,
                             timePerFrame: timeFrame,
                             resize: false,
                             restore: true)),
                 withKey:"walkingInPlaceBunny")
    }
}
