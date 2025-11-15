<script>
  import State from 'activestate'

  const { 
    sat_balance,
    rst_balance,
    current_user,
    ref_count
  } = $props()
</script>

<main>
  <section>
    <h2>My Balances</h2>
    Satoshi: { sat_balance }
    <br />
    RST: { rst_balance }
  </section>
  <section>
    <h2>Transaction History</h2>
    {#each State.transactions || [] as tx (tx.id)}
      <div class="transaction">
        <div>{tx.type}</div>
        <div>{tx.created_at}</div>
        <div>{tx.description}</div>
        <div>{tx.amount} {tx.symbol}</div>
      </div>
    {/each}
  </section>
  <section>
    <h2>Total referrals: {ref_count}</h2>
    Your referral link: 
    <a class="invite_link" href="{window.location.origin}/users/new?ref={current_user.ref_code}">
      {window.location.origin}/users/new?ref={current_user.ref_code}
    </a>
  </section>
</main>

