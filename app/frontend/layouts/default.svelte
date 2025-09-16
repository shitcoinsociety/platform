<script>
  import "@unocss/reset/tailwind.css"
  import { router } from "@inertiajs/svelte"
  import "./default.css"

  const {
    children, current_user
   } = $props()

  function logout() {
    router.delete("/session")
  }
</script>

<header>
  {#if current_user}
    Logged in as {current_user.email}
    <button onclick={logout}>Log out</button>
  {:else}
    Not logged in
  {/if}
</header>

<nav>

</nav>

{@render children()}