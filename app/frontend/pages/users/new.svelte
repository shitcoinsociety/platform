<script>
  import { useForm } from "inertiax-svelte";

  const { email } = $props();

  const form = useForm({
    email,
  });

  function submit(ev) {
    ev.preventDefault();
    $form.post("/users");
  }
</script>

<header>
  <h1>Create a New Account</h1>
</header>

<main>
  <form onsubmit={submit}>
    <div class="form-group">
      <input
        type="email"
        bind:value={$form.email}
        placeholder="Enter your email address"
        class="email-input"
        class:error={$form.errors?.email}
        required
      />
      {#if $form.errors?.email}
        <span class="error-message">{$form.errors.email}</span>
      {/if}
    </div>

    <button type="submit" class="btn primary" disabled={$form.processing}>
      {#if $form.processing}
        <span class="spinner"></span>
        Creating Account...
      {:else}
        Create Account
      {/if}
    </button>
  </form>
</main>
