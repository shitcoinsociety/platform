<script>
  import { useForm } from "@inertiajs/svelte";
  const form = useForm({ email: "", password: "" });

  function submit(event) {
    event.preventDefault();
    $form.post("/session")
  }
</script>

<main>
  <section>
    Log in
    
    <form onsubmit={submit}>
      <input type="email" bind:value={$form.email} placeholder="Email" />
      <input type="password" bind:value={$form.password} placeholder="Password" />
      <button type="submit">Log In</button>
    </form>
  </section>
</main>