import SwiftData
import Foundation

@Model
final class User {
    // Simple scalars
    var name: String
    var birthday: Date
    var height: Double
    var weight: Double
    var bmr: Double
    var tdee: Double
    var expectedEndDate: Date

    // Enums persisted as raw strings
    private var genderRaw: String
    var gender: Gender {
        get { Gender(rawValue: genderRaw) ?? .male }
        set { genderRaw = newValue.rawValue }
    }

    private var activityRaw: String
    var activity: ActivityLevel {
        get { ActivityLevel(rawValue: activityRaw) ?? .sedentary }
        set { activityRaw = newValue.rawValue }
    }

    private var goalRaw: String
    var goal: Goal {
        get { Goal(rawValue: goalRaw) ?? .maintain }
        set { goalRaw = newValue.rawValue }
    }

    private var carbFatBalanceRaw: String
    var carbFatBalance: CarbFatBalance {
        get { CarbFatBalance(rawValue: carbFatBalanceRaw) ?? .balanced }
        set { carbFatBalanceRaw = newValue.rawValue }
    }

    private var proteinIntakeRaw: String
    var proteinIntake: ProteinIntake {
        get { ProteinIntake(rawValue: proteinIntakeRaw) ?? .moderate }
        set { proteinIntakeRaw = newValue.rawValue }
    }
    
    var macros: Macros
    var macroSplit: MacroSplit

    // Designated init (take enums, store raws)
    init(
        name: String,
        birthday: Date,
        height: Double,
        weight: Double,
        gender: Gender,
        activity: ActivityLevel,
        goal: Goal,
        bmr: Double,
        tdee: Double,
        macros: Macros,
        macroSplit: MacroSplit,
        expectedEndDate: Date,
        carbFatBalance: CarbFatBalance,
        proteinIntake: ProteinIntake
    ) {
        self.name = name
        self.birthday = birthday
        self.height = height
        self.weight = weight
        self.bmr = bmr
        self.tdee = tdee
        self.macros = macros
        self.macroSplit = macroSplit
        self.expectedEndDate = expectedEndDate

        self.genderRaw = gender.rawValue
        self.activityRaw = activity.rawValue
        self.goalRaw = goal.rawValue
        self.carbFatBalanceRaw = carbFatBalance.rawValue
        self.proteinIntakeRaw = proteinIntake.rawValue
    }
}

enum Gender: String {
    case male = "Male",
         female = "Female"
}

enum Goal: String {
    case lose = "Lose", maintain = "Maintain", gain = "Gain"
}

enum ActivityLevel: String {
    case sedentary = "Sedentary", 
         light = "Light",
         moderate = "Moderate",
         veryActive = "Heavy",
         extremelyActive = "Extreme"
}

enum CarbFatBalance: String {
    case balanced = "Balanced",
         lowCarb = "Low Carb",
         lowFat = "Low Fat",
         keto = "Keto"
}

enum ProteinIntake: String {
    case low = "Low Protein",
         moderate = "Moderate Protein",
         high = "High Protein",
         extraHigh = "Extra High Protein"
}

struct Macros: Codable {
    var calories: Double
    var protein: Double
    var fats: Double
    var carbs: Double
}

struct MacroSplit: Codable {
    let protein: Double
    let fat: Double
    let carbs: Double
}
