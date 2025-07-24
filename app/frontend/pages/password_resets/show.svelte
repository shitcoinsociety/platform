<script>
  import { useForm } from 'inertiax-svelte';

  const { id } = $props();
  
  let form = useForm({password: ''})

  function submit(e) {
    e.preventDefault()
    $form.delete(`/password_resets/${id}`)
  }
</script>

<header>
  <h2 class="mb-4">
    Set a new password
  </h2>
</header>
<main>
  <section>
    <div class="form-container">
      <p>
        To continue, please set a password for your account.
      </p>
      <form onsubmit={submit}>
        
        <div class="form-group">
          <label for="password">New password</label>
          <input type="password" id="password" bind:value={$form.password} required autofocus />
        </div>
        {#if $form.errors.password}
          <div class="error">
            {$form.errors.password}
          </div>
        {/if}
        <button class="btn primary" data-loader name="submit">Save password</button>
      </form>
    </div>
  </section>
</main>
