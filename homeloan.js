function checkEligibility() {
  let age = document.getElementById("age").value;
  let income = document.getElementById("income").value;
  let credit = document.getElementById("credit").value;
  let tenure = document.getElementById("tenure").value;
  let result = document.getElementById("result");

  if (!age || !income || !credit || !tenure) {
    result.style.color = "red";
    result.innerText = "Please fill all fields";
    return;
  }

  if (age >= 21 && age <= 65 && income >= 25000 && credit >= 700) {
    result.style.color = "green";
    result.innerText = "🎉 You are eligible for a Home Loan!";
  } else {
    result.style.color = "red";
    result.innerText = "❌ You are not eligible for a Home Loan.";
  }
}
