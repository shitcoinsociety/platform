<script>
  import { useForm } from 'inertiax-svelte';

  const form = useForm({
    password: ''
  });

  function submit(ev) {
    ev.preventDefault();
    $form.post('/session?email=' + encodeURIComponent($form.email));
  }
</script>

<header>
  <h1>Welcome back!</h1>
</header>

<form onsubmit={submit} class="contents">
  <main>
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
    </div>
    <div class="form-group">
      <label for="password">Password</label>
      <input
        type="password"
        bind:value={$form.password}
        placeholder="Enter your password"
        class="input"
        class:error={$form.errors?.password}
        required
      />
    </div>
  </main>
  <footer>
    <button type="submit" class="btn primary" disabled={$form.processing}>
      {#if $form.processing}
        <span class="spinner"></span>
        Logging in...
      {:else}
        Log In
      {/if}
    </button>
  </footer>
</form>

