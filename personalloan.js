function checkEligibility() {
  let age = document.getElementById("age").value;
  let income = document.getElementById("income").value;
  let credit = document.getElementById("credit").value;
  let emi = document.getElementById("emi").value;
  let result = document.getElementById("result");

  if (!age || !income || !credit || !emi) {
    result.style.color = "red";
    result.innerText = "Please fill all fields";
    return;
  }

  let emiRatio = (emi / income) * 100;

  if (age >= 21 && age <= 60 && income >= 15000 && credit >= 700 && emiRatio <= 40) {
    result.style.color = "green";
    result.innerText = "🎉 You are eligible for a Personal Loan!";
  } else {
    result.style.color = "red";
    result.innerText = "❌ You are not eligible for a Personal Loan.";
  }
}
