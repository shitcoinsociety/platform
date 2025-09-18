<script>
  const { sat_balance, rst_balance, current_user, ref_count } = $props()
</script>

<main>
  <section>
    <h2>Balances</h2>
    Satoshi: { sat_balance }
    <br />
    RST: { rst_balance }
  </section>
  <section>
    <h2>Total referrals: {ref_count}</h2>
    Your referral link: 
    <a class="invite_link" href="{window.location.origin}/users/new?ref={current_user.ref_code}">
      {window.location.origin}/users/new?ref={current_user.ref_code}
    </a>
  </section>
</main>

