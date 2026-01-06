let chatState = "idle";
let userData = {
  loanType: "",
  age: "",
  income: ""
};

function toggleChat() {
  const chat = document.getElementById("chatWidget");
  chat.style.display = chat.style.display === "flex" ? "none" : "flex";
}

function sendMessage() {
  const input = document.getElementById("chatInput");
  const message = input.value.trim();
  if (!message) return;

  addMessage(message, "user");
  input.value = "";

  setTimeout(() => {
    botReply(message);
  }, 500);
}

function addMessage(text, type) {
  const chatBody = document.getElementById("chatBody");
  const div = document.createElement("div");
  div.className = `message ${type}`;
  div.innerText = text;
  chatBody.appendChild(div);
  chatBody.scrollTop = chatBody.scrollHeight;
}

/* ============================
   STATE-BASED BOT LOGIC
============================ */
function botReply(msg) {
  const text = msg.toLowerCase();

  /* ---- IDLE STATE ---- */
  if (chatState === "idle") {
    if (text.includes("hi") || text.includes("hello")) {
      addMessage("Hello 👋 I’m Loan Buddy. Which loan are you looking for?\n• Home\n• Education\n• Business\n• Personal", "bot");
      chatState = "choosing_loan";
    } else {
      addMessage("Hi 👋 Ask me about loans, eligibility, or interest rates.", "bot");
    }
    return;
  }

  /* ---- CHOOSING LOAN ---- */
  if (chatState === "choosing_loan") {
    if (["home", "education", "business", "personal"].some(l => text.includes(l))) {
      userData.loanType = text;
      addMessage(`Great 👍 Let’s check your eligibility for a ${userData.loanType} loan.\nWhat is your age?`, "bot");
      chatState = "eligibility";
    } else {
      addMessage("Please choose one: Home, Education, Business, or Personal loan.", "bot");
    }
    return;
  }

  /* ---- AGE COLLECTION ---- */
  if (chatState === "eligibility") {
    const age = parseInt(text);
    if (age >= 18 && age <= 65) {
      userData.age = age;
      addMessage("Got it 👍 What is your monthly income (in ₹)?", "bot");
      chatState = "income";
    } else {
      addMessage("Please enter a valid age between 18 and 65.", "bot");
    }
    return;
  }

  /* ---- INCOME COLLECTION ---- */
  if (chatState === "income") {
    const income = parseInt(text.replace(/\D/g, ""));
    if (income > 0) {
      userData.income = income;

      let decision = income >= 20000
        ? "You are likely eligible 🎉"
        : "Eligibility may be difficult 😕";

      addMessage(
        `${decision}\n\nSummary:
• Loan Type: ${userData.loanType}
• Age: ${userData.age}
• Income: ₹${userData.income}

Would you like interest rates or document details?`,
        "bot"
      );

      chatState = "done";
    } else {
      addMessage("Please enter a valid income amount.", "bot");
    }
    return;
  }

  /* ---- DONE STATE ---- */
  if (chatState === "done") {
    if (text.includes("interest")) {
      addMessage("Interest rates vary by loan type. Home loans start from 8.5%, personal loans from 11%.", "bot");
    } else if (text.includes("document")) {
      addMessage("Documents required: Aadhaar, PAN, income proof, bank statements.", "bot");
    } else {
      addMessage("You can ask about interest rates, documents, or type 'restart' to check again.", "bot");
    }

    if (text.includes("restart")) {
      chatState = "idle";
      userData = { loanType: "", age: "", income: "" };
      addMessage("Conversation restarted 🔄 How can I help you?", "bot");
    }
  }
}










































