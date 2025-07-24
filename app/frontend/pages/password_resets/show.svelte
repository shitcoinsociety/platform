<script>
  import { useForm } from "inertiax-svelte";

  const { id } = $props();

  let form = useForm({ password: "" });

  function submit(e) {
    e.preventDefault();
    $form.delete(`/password_resets/${id}`);
  }
</script>

<header>
  <section>
    <h2 class="mb-4">Set a new password</h2>
  </section>
</header>
<form onsubmit={submit} class="contents">
  <main>
    <section>
      <p>To continue, please set a password for your account.</p>

      <div class="form-group">
        <label for="password">New password</label>
        <input
          type="password"
          id="password"
          bind:value={$form.password}
          required
          autofocus
        />
      </div>
      {#if $form.errors.password}
        <div class="error">
          {$form.errors.password}
        </div>
      {/if}
    </section>
  </main>
  <footer>
    <section>
      <button class="btn primary" data-loader name="submit"
        >Save password</button
      >
    </section>
  </footer>
</form>
