<script>
  import State from 'activestate'
</script>

<h1>
  Welcome to Shitcoin Swap!
</h1>

<p>
  {#if State.connected}
    Connected.
  {:else}
    Connecting...
  {/if}
</p>