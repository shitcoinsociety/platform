<script>
  const { balance } = $props()
</script>


<main>
  <section>

    Satoshis: { balance }
    
    <a href="/deposits/new?symbol=sat" class="btn">Receive</a>
    
  </section>

</main>

