//
//  CustomSwitch.swift
//  Сustomizable UISwitch
//
//  Created by Vlad on 30.5.24..
//

import UIKit

// MARK: - Initial state (on or off)
public enum CustomSwitchState {
    case on, off
}

class CustomSwitch: UIControl {
    
    // MARK: - Properties
    var isOn: Bool = true
    
    var thumbOnTintColor: UIColor!
    var thumbOffTintColor: UIColor!
    
    var trackOnTintColor: UIColor!
    var trackOffTintColor: UIColor!
    
    var thumbDisabledTintColor: UIColor!
    var trackDisabledTintColor: UIColor!
    
    var tumbOnTitleColor: UIColor!
    var tumbOffTitleColor: UIColor!
    
    //var trackHeight: Int!
    
    var isBounceEnabled: Bool = false {
        didSet {
            self.bounceOffset = self.isBounceEnabled ? 3.0 : 0.0
        }
    }
    
    var switchThumb: UIButton!
    var track: UIView!
    
    var tarckEdgeInset: UIEdgeInsets = UIEdgeInsets(top: 18, left: 0, bottom: 18, right: 0)
    private var trackHeight = 54
    private var trackWidth = 100
    fileprivate var bounceOffset: CGFloat!
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialize()
    }
    
    // MARK: - Initialization
    func initialize() {
        self.backgroundColor = .clear
        
        // Initialize parameters
        thumbOnTintColor = .red
        thumbOffTintColor = .green
        
        trackOnTintColor = .green
        trackOffTintColor = .red
        
        tumbOnTitleColor = .blue
        tumbOffTitleColor = .yellow
        
        track = UIView(frame: getTrackFrame())
        track.layer.cornerRadius = min(track.frame.size.height, track.frame.size.width) / 2
        addSubview(track)
        
        switchThumb = UIButton(frame: getThumbFrame())
        switchThumb.setTitle("ON", for: .normal)
        switchThumb.titleLabel?.font = UIFont.systemFont(ofSize: 19)
        switchThumb.setTitleColor(tumbOnTitleColor, for: .normal)
        switchThumb.backgroundColor = thumbOffTintColor
        switchThumb.layer.cornerRadius = switchThumb.frame.size.height / 2
        switchThumb.layer.shadowOpacity = 0.5
        switchThumb.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        switchThumb.layer.shadowColor = UIColor.black.cgColor
        switchThumb.layer.shadowRadius = 2.0
        addSubview(switchThumb)
        
        // Add events for user action
        switchThumb.addTarget(self, action: #selector(self.onTouchDown(btn:withEvent:)), for: .touchDown)
        switchThumb.addTarget(self, action: #selector(self.onTouchUpOutsideOrCanceled(btn:withEvent:)), for: [.touchUpOutside, .touchCancel])
        switchThumb.addTarget(self, action: #selector(self.switchAreaTapped), for: .touchUpInside)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.switchAreaTapped))
        addGestureRecognizer(singleTap)
        
        setOn(on: isOn, animated: false)
    }
    
    // MARK: - UI Updates
    func updateUI() {
        layoutSubviews()
        
        track.frame = getTrackFrame()
        track.layer.cornerRadius = min(track.frame.size.height, track.frame.size.width) / 2
        
        switchThumb.frame = getThumbFrame()
        switchThumb.layer.cornerRadius = switchThumb.frame.size.height / 2
        
        self.setOn(on: self.isOn, animated: false)
    }
    
    fileprivate func getTrackFrame() -> CGRect {
        var trackFrame = bounds
        trackFrame.size.height = CGFloat(trackHeight)
        trackFrame.size.width = CGFloat(trackWidth)
        
        trackFrame.origin.x = tarckEdgeInset.left
        trackFrame.origin.y = (frame.size.height / 2) - (trackFrame.size.height / 2)
        return trackFrame
    }
    
    fileprivate func getThumbFrame() -> CGRect {
        var thumbFrame = CGRect.zero
        thumbFrame.size.height = track.frame.size.height + 8
        thumbFrame.size.width = thumbFrame.size.height
        
        if isOn {
            thumbFrame.origin.x = track.frame.maxX - (thumbFrame.size.width)
        } else {
            thumbFrame.origin.x = track.frame.minX
        }
        thumbFrame.origin.y = (frame.size.height / 2) - (thumbFrame.size.height / 2)
        return thumbFrame
    }
    
    // MARK: - State Management
    func setOn(on: Bool, animated: Bool) {
        if on {
            if animated {
                changeThumbStateONwithAnimation()
            } else {
                changeThumbStateONwithoutAnimation()
            }
        } else {
            if animated {
                changeThumbStateOFFwithAnimation()
            } else {
                changeThumbStateOFFwithoutAnimation()
            }
        }
    }
    
    func setEnabled(enabled: Bool) {
        super.isEnabled = enabled
        UIView.animate(withDuration: 0.5) { [self] in
            if enabled {
                track.backgroundColor = isOn ? trackOnTintColor : trackOffTintColor
                isEnabled = true
            } else {
                track.backgroundColor = trackDisabledTintColor
                isEnabled = false
            }
        }
    }
    
    @objc func switchAreaTapped() {
        self.changeThumbState()
    }
    
    func changeThumbState() {
        if isOn {
            changeThumbStateOFFwithAnimation()
        } else {
            changeThumbStateONwithAnimation()
        }
    }
    
    func changeThumbStateONwithAnimation() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: { [self] in
            switchThumb.frame = getThumbFrame()
        }) { [self] finished in
            if !isOn {
                isOn = true
                sendActions(for: .valueChanged)
            }
            switchThumb.backgroundColor = isEnabled ? trackOnTintColor : thumbDisabledTintColor
            track.backgroundColor = isEnabled ? trackOnTintColor : trackDisabledTintColor
            switchThumb.setTitleColor(tumbOnTitleColor, for: .normal)
            switchThumb.setTitle("ON", for: .normal)
            UIView.animate(withDuration: 0.15, animations: { [self] in
                switchThumb.frame = getThumbFrame()
            })
        }
    }
    
    func changeThumbStateOFFwithAnimation() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: { [self] in
            switchThumb.frame = getThumbFrame()
            isUserInteractionEnabled = false
        }) { [self] finished in
            if isOn {
                isOn = false
                sendActions(for: .valueChanged)
            }
            UIView.animate(withDuration: 0.15, animations: { [self] in
                switchThumb.frame = getThumbFrame()
            }) { [self] finished in
                switchThumb.backgroundColor = isEnabled ? trackOffTintColor : thumbDisabledTintColor
                track.backgroundColor = isEnabled ? trackOffTintColor : trackDisabledTintColor
                switchThumb.setTitleColor(tumbOffTitleColor, for: .normal)
                switchThumb.setTitle("OFF", for: .normal)
                isUserInteractionEnabled = true
            }
        }
    }
    
    func changeThumbStateONwithoutAnimation() {
        switchThumb.frame = getThumbFrame()
        track.backgroundColor = isEnabled ? trackOnTintColor : trackDisabledTintColor
        if !isOn {
            isOn = true
            sendActions(for: .valueChanged)
        }
    }
    
    func changeThumbStateOFFwithoutAnimation() {
        switchThumb.frame = getThumbFrame()
        track.backgroundColor = isEnabled ? trackOffTintColor : trackDisabledTintColor
        
        if isOn {
            isOn = false
            sendActions(for: .valueChanged)
        }
    }
    
    // MARK: - Event Actions
    @objc func onTouchDown(btn: UIButton, withEvent event: UIEvent) {
        // Этот метод остается пустым
    }
    
    @objc func onTouchUpOutsideOrCanceled(btn: UIButton, withEvent event: UIEvent) {
        if let touch = event.touches(for: btn)?.first {
            let prevPos = touch.previousLocation(in: btn)
            let pos = touch.location(in: btn)
            let dX = pos.x - prevPos.x
            let newXOrigin = btn.frame.origin.x + dX
            
            if newXOrigin > (frame.size.width - switchThumb.frame.size.width) / 2 {
                changeThumbStateONwithAnimation()
            } else {
                changeThumbStateOFFwithAnimation()
            }
        }
    }
}
