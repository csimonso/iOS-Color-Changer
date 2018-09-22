//
//  ViewController.swift
//  Assignment2
//
//  Created by Christopher Simonson on 9/14/18.
//  Copyright © 2018 SimonsonProductions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var colorView: UIView!
    @IBOutlet var redTextField, greenTextField, blueTextField: UITextField!
    @IBOutlet var redSlider, greenSlider, blueSlider: UISlider!
    
    /*State Restoration Encoding*/
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        //Encode text fields and color for restore
        coder.encode(redTextField.text, forKey: "Red")
        coder.encode(greenTextField.text, forKey: "Green")
        coder.encode(blueTextField.text, forKey: "Blue")
        coder.encode(colorView.backgroundColor, forKey: "Color")
    }
    
    /*State Restoration Decoding*/
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        //Decode text fields and color and restore the state
        if let redRestore = coder.decodeObject(forKey: "Red") as? String{
            self.redTextField.text = redRestore
        }
        if let greenRestore = coder.decodeObject(forKey: "Green") as? String{
            self.greenTextField.text = greenRestore
        }
        if let blueRestore = coder.decodeObject(forKey: "Blue") as? String{
            self.blueTextField.text = blueRestore
        }
        if let colorRestore = coder.decodeObject(forKey: "Color") as? UIColor {
            self.colorView.backgroundColor = colorRestore
        }
    }
    
    /*ACTION: Allows for Dragging of the UIView*/
    @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
        let move = recognizer.translation(in: self.view)
        
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + move.x, y:view.center.y
                + move.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    /*ACTION: Red Slider Changed*/
    @IBAction func redSliderChange(_ sender: UISlider) {
        moveSlider()
    }
    
    /*ACTION: Green Slider Changed*/
    @IBAction func greenSliderChange(_ sender: UISlider) {
        moveSlider()
    }
    
    /*ACTION: Blue Slider Changed*/
    @IBAction func blueSliderChange(_ sender: UISlider) {
        moveSlider()
    }
    
    /*ACTION: Color Button is Pressed*/
    @IBAction func changeColor(_ sender: UIButton) {
        var redColor: Float = 0.0
        var greenColor: Float = 0.0
        var blueColor: Float = 0.0
        
        //Hide the keyboard after button has been pressed
        hideKeyboard()
        
        //Get the text field values for each of the colors
        redColor = getTextFieldValue(textField: redTextField)
        greenColor = getTextFieldValue(textField: greenTextField)
        blueColor = getTextFieldValue(textField: blueTextField)
        
        //Set the slider values to match the colors
        setRedSlider(value: redColor)
        setGreenSlider(value: greenColor)
        setBlueSlider(value: blueColor)
        
        //Display the color in the UIView
        displayColor(red: redColor, green: greenColor, blue: blueColor)
    }
    
    /*Handles Slider Movement*/
    func moveSlider() {
        let redSliderColor: Float = redSlider.value
        let greenSliderColor: Float = greenSlider.value
        let blueSliderColor: Float = blueSlider.value
        
        //Set the text fields to match the sliders values
        setRedTextField(value: String(redSliderColor * 100))
        setGreenTextField(value: String(greenSliderColor * 100))
        setBlueTextField(value: String(blueSliderColor * 100))
        
        //Display the color in the UIView
        displayColor(red: redSliderColor, green: greenSliderColor, blue:
            blueSliderColor)
    }
    
    /*Display RGB Colors in UIView Object*/
    func displayColor(red: Float, green: Float, blue: Float) {
        colorView.backgroundColor = UIColor(red: CGFloat(red), green:
            CGFloat(green), blue: CGFloat(blue), alpha: 1)
    }
    
    /*Hide Keyboard*/
    func hideKeyboard() {
        redTextField.resignFirstResponder()
        greenTextField.resignFirstResponder()
        blueTextField.resignFirstResponder()
    }
    
    /*Get Text Field Value (0-100)*/
    func getTextFieldValue(textField: UITextField) -> Float {
        //Return Value between 0.0-1.0
        return (Float(textField.text!)! / 100)
    }
    
    /*Set Red Text Field*/
    func setRedTextField(value: String) {
        redTextField.text = value
    }
    
    /*Set Green Text Field*/
    func setGreenTextField(value: String) {
        greenTextField.text = value
    }
    
    /*Set Blue Text Field*/
    func setBlueTextField(value: String) {
        blueTextField.text = value
    }
    
    /*Set Red Slider Value*/
    func setRedSlider(value: Float) {
        redSlider.value = value
    }
    
    /*Set Green Slider Value*/
    func setGreenSlider(value: Float) {
        greenSlider.value = value
    }
    
    /*Set Blue Slider Value*/
    func setBlueSlider(value: Float) {
        blueSlider.value = value
    }
}

