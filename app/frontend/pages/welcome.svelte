<script>
  import { modal } from '~/lib/ui/Modal.svelte'

  let email = $state('');
</script>

<div class="container">
  <h1>
    Welcome to the Era of Financial Freedom!
  </h1>

  <p class="subtitle">
    Join the world's largest open-source crypto MLM platform and earn passive income simply by holding our Revenue Share Token ($RST).
  </p>

  <p class="description">
    Enter your email address to get started.
  </p>

  <form onsubmit={submit} class="email-form">
    <div class="form-group">
      <input
        type="email"
        bind:value={email}
        placeholder="Enter your email address"
        class="email-input"
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
  .container {
    max-width: 600px;
    margin: 0 auto;
    padding: 2rem;
    text-align: center;
  }

  h1 {
    font-size: 2.5rem;
    font-weight: bold;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    background-clip: text;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    margin-bottom: 1.5rem;
  }

  .subtitle {
    font-size: 1.2rem;
    color: #666;
    margin-bottom: 1rem;
    line-height: 1.6;
  }

  .description {
    font-size: 1rem;
    color: #888;
    margin-bottom: 2rem;
  }

  .email-form {

    box-shadow: 0 2px 40px rgba(0, 0, 0, 0.1);
    padding: 1.5rem;
    border-radius: 8px;
    background: rgba(255, 255, 255, 0.95);
  }



  @media (max-width: 768px) {
    .container {
      padding: 1rem;
    }

    h1 {
      font-size: 2rem;
    }
  }
</style>