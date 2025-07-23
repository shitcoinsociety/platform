<script>
  import { modal } from '~/lib/ui/Modal.svelte'

  let email = $state('');
</script>

<div class="container">
  <h1>
    Welcome to the Era of Financial Freedom
  </h1>

  <p class="subtitle">
    Join the world's largest open-source MLM platform and earn passive income simply by holding our Revenue Share Token ($RST).
  </p>

  <form onsubmit={submit} class="email-form">
    <p class="mb-2">
      Enter your email address to get started.
    </p>

    <div class="form-group">
      <input
        type="email"
        bind:value={email}
        placeholder="Email address"
        class="input"
        required
      />
    </div>
    
    <button onclick={modal("/users/new?email=" + email)}
      type="submit" 
      class="btn primary">
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
  color: #333;
  box-shadow: 0 2px 40px rgba(0, 0, 0, 0.1);
  padding: 1.5rem;
  border-radius: 8px;
  background: rgba(255, 255, 255, 0.95);
}



</style>