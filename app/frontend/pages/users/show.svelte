<script>
  const { sat_position, rst_position, current_user, ref_count } = $props()
</script>

<main>
  <section>
    <h2>Positions</h2>
    Satoshi: { sat_position }
    <br />
    RST: { rst_position }
  </section>
  <section>
    <h2>Total referrals: {ref_count}</h2>
    Your referral link: 
    <a class="invite_link" href="{window.location.origin}/users/new?ref={current_user.ref_code}">
      {window.location.origin}/users/new?ref={current_user.ref_code}
    </a>
  </section>
</main>

