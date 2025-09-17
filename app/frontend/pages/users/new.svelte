<script>
  import { useForm } from "@inertiajs/svelte";
  const form = useForm({ email: "", password: "" });

  function submit(event) {
    event.preventDefault();
    $form.post("/users")
  }
</script>

<main>
  <section>
    <h1>Sign Up</h1>
    <form onsubmit={submit}>
      {#if $form.errors.email}
      <div style="color: red">{$form.errors.email}</div>
      {/if}
      {#if $form.errors.password}
      <div style="color: red">{$form.errors.password}</div>
      {/if}
      <input type="email" bind:value={$form.email} placeholder="Email" />
      <input type="password" bind:value={$form.password} placeholder="Password" />
      <button type="submit">Sign Up</button>
    </form>
  </section>
</main>