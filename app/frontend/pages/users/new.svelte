<script>
  import { useForm } from "inertiax-svelte";

  const { email, close, router } = $props();

  const form = useForm({
    email,
  });

  function submit(ev) {
    ev.preventDefault();
    $form.post("/users", {
      onSuccess() {
        close();
        router.visit("/dashboard", { frame: "_top" });
      }
    })
  }
</script>

<header>
  <section>
    <h1>Sign up and get started</h1>
  </section>
</header>

<form onsubmit={submit} class="contents">
  <main>
    <section>

      <div class="form-group">
        <label for="email">Email</label>
        <input
        type="email"
        bind:value={$form.email}
        placeholder="Enter your email"
        class="input"
        class:error={$form.errors?.email}
        required
        />
        {#if $form.errors?.email}
        <span class="error-message">{$form.errors.email}</span>
        {/if}
      </div>
    </section>
  </main>
  <footer>
    <section>
      <button type="submit" class="btn primary" disabled={$form.processing}>
        {#if $form.processing}
        <span class="spinner"></span>
        Verifying...
        {:else}
        Continue
        {/if}
      </button>
      <p class="mt-2">Already have an account? <a href="/session/new">Log in.</a></p>
    </section>
  </footer>
</form>
