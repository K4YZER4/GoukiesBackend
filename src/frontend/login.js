const formLogin = document.getElementById("login-form");
const correoLogin = document.getElementById("correo");
const passwordLogin = document.getElementById("password");
const mensajeLogin = document.getElementById("mensaje");

formLogin.addEventListener("submit", async (e) => {
  e.preventDefault();
  mensajeLogin.textContent = "Enviando...";
  mensajeLogin.style.color = "#e5e7eb";

  try {
    const res = await fetch("http://localhost:3000/auth/login", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        identificador: correoLogin.value, // ← aquí va identificador
        password: passwordLogin.value,
      }),
    });

    const data = await res.json().catch(() => ({}));

    if (!res.ok) {
      mensajeLogin.textContent = data.message || "Credenciales incorrectas";
      mensajeLogin.style.color = "#f97373";
      return;
    }

    // Suponiendo que el backend responde { access_token: '...' }
    localStorage.setItem("token", data.access_token);
    mensajeLogin.textContent = "Login exitoso ✅ (redireccionando...)";
    mensajeLogin.style.color = "#4ade80";
    setTimeout(() => {
      window.location.href = "dashboard.html";
    }, 800);
  } catch (err) {
    console.error(err);
    mensajeLogin.textContent = "Error conectando con el servidor";
    mensajeLogin.style.color = "#f97373";
  }
});
