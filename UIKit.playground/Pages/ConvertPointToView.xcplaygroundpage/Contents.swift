//: Playground - noun: a place where people can play

import UIKit

let text = "I note the obvious differences in the human family. \nSome of us are serious, some thrive on comedy. \nI've sailed upon the seven seas and stopped in every land, I've seen the wonders of the world not yet one common man. \nI know ten thousand women called Jane and Mary Jane, but I've not seen any two who really were the same. \nMirror twins are different although their features jibe, and lovers think quite different thoughts while lying side by side. \nI note the obvious differences between each sort and type, but we are more alike, my friends, than we are unalike. \nWe are more alike, my friends, than we are unalike. We are more alike, my friends, than we are unalike."


let newtextFrame = CGRect(x: 0, y: 0, width: 300, height:450)
let newText = UITextView(frame: newtextFrame)
newText.center = self.view.center

newText.text = text
newText.textAlignment = NSTextAlignment.Left
newText.font = UIFont(name:"Helvetica", size: 12.0)
newText.font = UIFont.systemFontOfSize(16.0);
newText.editable = false
//newText.roundCorners(UIRectCorner.AllCorners, radius: 5)
newText.backgroundColor = UIColor.clearColor()
self.view.addSubview(newText)



var str = "Hello, playground"
