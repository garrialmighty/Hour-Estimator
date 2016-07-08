//
//  TasksViewModel.swift
//  Hours Estimator
//
//  Created by Garri Adrian Nablo on 7/8/16.
//  Copyright © 2016 Knack Studios. All rights reserved.
//

import Foundation

typealias TaskDictionary = [String: [Task]]

final class TasksViewModel {
    
    var tasks: [TaskDictionary]!
    
    init() {
        // create planning section
        let inceptionDeck = Task()
        inceptionDeck.name = "Inception Deck"
        let marketResearch = Task()
        marketResearch.name = "Market Research"
        let stakeholderInterview = Task()
        stakeholderInterview.name = "Stakeholder Interview"
        let planningSection = ["Planning": [inceptionDeck, marketResearch, stakeholderInterview]]
        
        // create design section
        let wireframing = Task()
        wireframing.name = "Wireframing"
        let mockups = Task()
        mockups.name = "Mockups"
        let flowUserTesting = Task()
        flowUserTesting.name = "Flow User Testing"
        let styleGuide = Task()
        styleGuide.name = "Style Guide"
        let brandAnalysis = Task()
        brandAnalysis.name = "Brand Analysis"
        let designSection = ["Design": [wireframing, mockups, flowUserTesting, styleGuide, brandAnalysis]]
        
        // create development section
        let setupAndScaffolding = Task()
        setupAndScaffolding.name = "Setup and Scaffolding"
        let developmentSection = ["Development": [setupAndScaffolding]]
        
        tasks = [planningSection, designSection, developmentSection]
        
        let customTasks = RealmUtility.sharedUtility.fetchAllTasks()
        if customTasks.count > 0 {
            let userDefinedSection = ["User Defined": customTasks]
            tasks.append(userDefinedSection)
        }
    }
    
    func keyForSection(section: Int) -> String {
        return {
            switch section {
            case 0:
                return "Planning"
            case 1:
                return "Design"
            case 2:
                return "Development"
            case 3:
                return "User Defined"
            default:
                return ""
            }
        }()
    }
}
