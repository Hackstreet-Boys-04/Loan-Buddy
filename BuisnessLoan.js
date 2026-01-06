function checkEligibility() {
    const age = parseInt(document.getElementById("age").value);
    const vintage = parseInt(document.getElementById("vintage").value);
    const income = parseInt(document.getElementById("income").value);
    const credit = parseInt(document.getElementById("credit").value);

    const result = document.getElementById("result");

    
    if (
        isNaN(age) ||
        isNaN(vintage) ||
        isNaN(income) ||
        isNaN(credit)
    ) {
        result.innerText = "Please enter valid values in all fields.";
        result.style.color = "orange";
        return;
    }

    
    if (
        age >= 21 && age <= 60 &&
        vintage >= 1 &&
        income >= 20000 &&
        credit >= 700
    ) {
        result.innerText = "Congratulations! You are eligible for a Business Loan.";
        result.style.color = "green";
    } else {
        result.innerText = "Sorry, you are not eligible for a Business Loan.";
        result.style.color = "red";
    }
}




