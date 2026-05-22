const form = document.getElementById("register-form");
const nombreInput = document.getElementById("nombre");
const correoInput = document.getElementById("correo");
const passwordInput = document.getElementById("password");
const monedaInput = document.getElementById("moneda");
const mensajeEl = document.getElementById("mensaje");

form.addEventListener("submit", async (e) => {
  e.preventDefault();
  mensajeEl.textContent = "Enviando...";
  mensajeEl.style.color = "#e5e7eb";

  try {
    const res = await fetch("http://localhost:3000/users/create", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        nombre: nombreInput.value,
        correo_electronico: correoInput.value,
        password: passwordInput.value,
        codigo_moneda: monedaInput.value,
      }),
    });

    const data = await res.json().catch(() => ({}));

    if (!res.ok) {
      mensajeEl.textContent = data.message || "Error al crear usuario";
      mensajeEl.style.color = "#f97373";
      return;
    }

    mensajeEl.textContent = "Usuario creado correctamente ✅";
    mensajeEl.style.color = "#4ade80";
  } catch (err) {
    console.error(err);
    mensajeEl.textContent = "Error conectando con el servidor";
    mensajeEl.style.color = "#f97373";
  }
});
