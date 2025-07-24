<script>
  import State from 'activestate';
  const { close } = $props();

</script>

<header>
  <h2 class="mb-4">
    Password changed
  </h2>
</header>
<main>
  <div class="form-container">
    <p>Your new password has been saved.</p>
  </div>
</main>
<footer>
  {#if State.user}
    <a href="/dashboard" data-target="_top" class="btn primary" id="dashboard" onclick={close}>Go to Dashboard</a>
  {:else}
    <a href="/session/new" class="btn primary" id="sign_in">Sign in</a>
  {/if}
</footer>