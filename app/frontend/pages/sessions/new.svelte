<script>
  import { useForm } from 'inertiax-svelte';
  import { getContext } from 'svelte';

  const { router } = getContext("inertia")
  const { close } = $props();

  const form = useForm({
    password: ''
  });

  function submit(ev) {
    ev.preventDefault();
    $form.post('/session?email=' + encodeURIComponent($form.email), {
      onSuccess() {
        close();
        router.visit('/dashboard', {frame: '_top'});
      }
    });
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
    <p>
       <a href="/password_resets/new">Forgot your password?</a>
    </p>
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
    <p class="mt-2">Don't have an account? <a href="/users/new">Sign up.</a></p>
  </footer>
</form>

