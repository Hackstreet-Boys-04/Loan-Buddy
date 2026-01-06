function calculateEMI() {
  const loanType = document.getElementById("loanType").value;
  const amount = parseFloat(document.getElementById("amount").value);
  const tenureYears = parseFloat(document.getElementById("tenure").value);

  let annualRate;

  // Default interest rates
  switch (loanType) {
    case "home":
      annualRate = 8.5;
      break;
    case "personal":
      annualRate = 14;
      break;
    case "education":
      annualRate = 10;
      break;
    case "business":
      annualRate = 12;
      break;
  }

  const rateInput = document.getElementById("rate").value;
  if (rateInput) annualRate = parseFloat(rateInput);

  if (!amount || !annualRate || !tenureYears) {
    document.getElementById("result").innerHTML =
      "⚠️ Please fill all fields correctly";
    return;
  }

  const monthlyRate = annualRate / 12 / 100;
  const months = tenureYears * 12;

  const emi =
    (amount * monthlyRate * Math.pow(1 + monthlyRate, months)) /
    (Math.pow(1 + monthlyRate, months) - 1);

  const totalPayable = emi * months;
  const interest = totalPayable - amount;

  document.getElementById("result").innerHTML = `
    <b>Monthly EMI:</b> ₹${emi.toFixed(2)}<br>
    <b>Total Interest:</b> ₹${interest.toFixed(2)}<br>
    <b>Total Amount:</b> ₹${totalPayable.toFixed(2)}
  `;
}
