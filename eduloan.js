function checkEligibility() {
  // Get values
  var age = document.getElementById("age").value;
  var location = document.getElementById("location").value;
  var credit = document.getElementById("credit").value;
  var admission = document.getElementById("admission").value;
  var result = document.getElementById("result");

  // Basic validation
  if (age === "" || credit === "") {
    result.style.color = "red";
    result.innerText = "Please fill all required fields.";
    return;
  }

  // Convert to numbers
  age = parseInt(age);
  credit = parseInt(credit);

  // Eligibility logic
  if (age >= 16 && credit >= 650 && admission === "yes") {
    if (location === "india") {
      result.style.color = "green";
      result.innerText =
        "✅ You are eligible for an Educational Loan in India.";
    } else if (location === "abroad") {
      result.style.color = "green";
      result.innerText =
        "✅ You are eligible for an Educational Loan for studies abroad.";
    }
  } else {
    result.style.color = "red";
    result.innerText =
      "❌ You are not eligible currently. Ensure age, CIBIL score, and admission status meet requirements.";
  }
}
