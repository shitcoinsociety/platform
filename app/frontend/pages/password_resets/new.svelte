<script>
  import { useForm } from 'inertiax-svelte'
  import { State } from 'activestate'

  const { email } = $props()

  let form = useForm({email})
  
  function autofocus(node) {
    node.focus({
      preventScroll: true
    })
  }
</script>

<header>
  <h2 class="mb-4">
    Reset password
  </h2>
</header>

<main>
  <section>
    <div class="form-container">
      
      {#if State.user?.email}
      <p class="mb-4">
        Click the button below to send a password reset email to <strong>{State.user.email}</strong>.
      </p>
      <form on:submit|preventDefault={() => $form.post(`/password_resets`)} class="">
        
        <button class="btn primary" name="login" data-loader>Send link</button>
        
      </form>
      {:else}
      <p class="mb-4">
        To request a password reset, enter your email address below. We will send you an email with instructions to reset your password.
      </p>
      
      <form on:submit|preventDefault={() => $form.post(`/password_resets`)} class="">
        <div class="form-group">
          <label for="email">Email</label>
          <input type="email" id="email" bind:value={$form.email} required />
        </div>
        
        <button class="btn primary" name="login" data-loader>Send email</button>
        
      </form>
      {/if}
    </div>
  </section>
</main>