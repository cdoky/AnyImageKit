//
//  CaptureTipsView.swift
//  AnyImageKit
//
//  Created by 刘栋 on 2020/1/9.
//  Copyright © 2020 AnyImageProject.org. All rights reserved.
//

import UIKit

final class CaptureTipsView: UIView {
    
    private lazy var tipsLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.textColor = UIColor.white
        view.textAlignment = .center
        view.text = options.mediaOptions.localizedTips
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = 1
        return view
    }()
    
    private let options: CaptureParsedOptionsInfo
    
    init(frame: CGRect, options: CaptureParsedOptionsInfo) {
        self.options = options
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(tipsLabel)
        tipsLabel.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
}

// MARK: - Animation
extension CaptureTipsView {
    
    func showTips(hideAfter second: TimeInterval, animated: Bool) {
        guard isHidden else { return }
        self.alpha = 0
        self.isHidden = false
        let duration = animated ? 0.25 : 0
        let timingParameters = UICubicTimingParameters(animationCurve: .easeInOut)
        let animator = UIViewPropertyAnimator(duration: duration, timingParameters: timingParameters)
        animator.addAnimations {
            self.alpha = 1
        }
        animator.addCompletion { [weak self ]_ in
            guard let self = self else { return }
            self.hideTips(afterDelay: second, animated: animated)
        }
        animator.startAnimation()
    }
    
    func hideTips(afterDelay second: TimeInterval, animated: Bool) {
        guard !isHidden else { return }
        let duration = animated ? 0.25 : 0
        let timingParameters = UICubicTimingParameters(animationCurve: .easeInOut)
        let animator = UIViewPropertyAnimator(duration: duration, timingParameters: timingParameters)
        animator.addAnimations {
            self.alpha = 0
        }
        animator.addCompletion { _ in
            self.isHidden = true
        }
        animator.startAnimation(afterDelay: second)
    }
}
