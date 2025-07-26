<script>
  import { modal } from '~/lib/ui/Modal.svelte'

  let email = $state('');
</script>

<div class="container">
  <h1>
    Welcome to the Era of Financial Freedom
  </h1>

  <p class="subtitle">
    Join the world's largest open-source crypto MLM platform and earn dividends simply by holding our Revenue Share Token ($RST).
  </p>

  <form onsubmit={modal("/users/new?email=" + email)} class="email-form">
    <p class="mb-2">
      Enter your email address to get started.
    </p>

    <div class="form-group">
      <input
        name="email"
        type="email"
        bind:value={email}
        placeholder="Email address"
        class="input"
        required
      />
    </div>
    
    <button
      type="submit" 
      class="btn primary big">
      Start Your Journey
    </button>
  </form>
</div>

<style>
h1 {
  font-size: 2.5rem;
  font-weight: bold;
  margin-top: 6rem;
  line-height: 1.2;
  color: white;
}

@media (min-width: 768px) { 
  h1 {
    font-size: 4rem;
  }
}

.subtitle {
  font-size: 1.2rem;
  margin-bottom: 3rem;
  line-height: 1.6;
  color: white;
}

.email-form {
  border: 1px solid var(--color-border);
  box-shadow: 0 2px 40px rgba(0, 0, 0, 0.1);
  padding: 1.5rem;
  border-radius: 8px;
  background: rgba(200,200,200,0.1);
}

</style>