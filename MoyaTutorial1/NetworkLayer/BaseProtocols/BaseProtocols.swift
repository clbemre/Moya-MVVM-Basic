//
//  BaseProtocols.swift
//  MoyaTutorial1
//
//  Created by Yunus Emre Celebi on 12.01.2020.
//  Copyright © 2020 cLB. All rights reserved.
//

import Moya

protocol ViewModelFactory {

    associatedtype Target: TargetType
    associatedtype B: BaseManager
    associatedtype V: BaseViewModel

    func makeProvider() -> MoyaProvider<Target>
    func makeManager() -> B
    func makeViewModel() -> V
}

protocol BaseManager {
    associatedtype Target: TargetType
}

protocol BaseViewModel { }
