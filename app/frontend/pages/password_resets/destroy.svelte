<script>
  import State from 'activestate';
  const { close } = $props();

</script>

<header>
  <section>
    <h2 class="mb-4">Password changed</h2>
  </section>
</header>
<main>
  <section>
    <p>Your new password has been saved.</p>
  </section>
</main>
<footer>
  <section>
    {#if State.user}
      <a href="/dashboard" data-target="_top" class="btn primary" id="dashboard" onclick={close}>Go to Dashboard</a>
    {:else}
      <a href="/session/new" class="btn primary" id="sign_in">Sign in</a>
    {/if}
  </section>
</footer>