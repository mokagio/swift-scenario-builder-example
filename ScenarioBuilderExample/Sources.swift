class MedicalBackend {

    private var doctors: [Doctor]
    private var patients: [Patient]

    let name: String
    let registrationID: String
    let address: Address

    init(name: String, registrationID: String, address: Address) {
        doctors = []
        patients = []
        self.name = name
        self.registrationID = registrationID
        self.address = address
    }

    func employ(doctor: Doctor) {
        doctors.append(doctor)
    }

    func onboard(patient: Patient) {
        patients.append(patient)
    }

    func register(patient: Patient, with doctor: Doctor) {
        doctor.registerPatient(patient)
    }

    func issueScript(
        forDrug drug: Drug,
        quantity: Quantity,
        repetition: Int,
        to patiente: Patient,
        from doctor: Doctor
    ) -> Result<Script, MedicalBackendError> {
        // FIXME: imagine real logic
        return .failure(MedicalBackendError.illegalDrug)
    }
}

enum MedicalBackendError: Equatable, Error {
    case patientUnderAgeForDrug
    case illegalDrug
    case notAPatient
}

class Doctor {

    enum Specialty {
        case generalPractitioner
    }

    private(set) var patients: [Patient]
    let name: String
    let license: String
    let specialty: Specialty

    init(name: String, license: String, specialty: Specialty) {
        self.name = name
        patients = []
        self.license = license
        self.specialty = specialty
    }

    func registerPatient(_ patient: Patient) {
        patients.append(patient)
    }
}

struct Patient {
    let name: String
    let dateOfBirth: Date
    let address: Address
}

struct Drug {
    let name: String
    let activeIngredients: [Ingredient]
    let minimumAge: Int
    let usageRecommendation: String
}

enum Ingredient {
    case someName
    case someOtherName
}

struct Script {
    let drug: Drug
    let quantity: Quantity
    let repetition: Int
    let patient: Patient
}

enum Quantity {
    case grams(Double)
    case pills(Int)
    case milliliters(Double)
}

struct Address {
    let streetNumber: String
    let street: String
    let city: String
    let state: String
    let postCode: String
}
