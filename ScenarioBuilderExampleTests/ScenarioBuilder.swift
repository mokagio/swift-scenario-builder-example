@testable import ScenarioBuilderExample

struct ScenarioBuilder {

    private var patientAge: Int = 30

    func withPatientAge(_ age: Int) -> ScenarioBuilder {
        var newBuilder = self
        newBuilder.patientAge = age
        return newBuilder
    }

    func build(referenceDate: Date = Date()) -> (MedicalBackend, Doctor, Patient) {
        let medicalBackend = MedicalBackend(
            name: "a name",
            registrationID: "ABC123",
            address: .fixture()
        )

        let doctor = Doctor.fixture()

        medicalBackend.employ(doctor: doctor)

        let dob = Calendar.current.date(byAdding: .year, value: patientAge, to: referenceDate)!
        let patient = Patient.fixture(dateOfBirth: dob)

        medicalBackend.onboard(patient: patient)
        medicalBackend.register(patient: patient, with: doctor)

        return (medicalBackend, doctor, patient)
    }
}
