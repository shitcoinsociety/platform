<script>
  const { balance, current_user, ref_count } = $props()
</script>

<main>
  <section>
    Satoshis: { balance }
    <a href="/deposits/new?symbol=sat" class="btn">Receive</a>
  </section>
  <section>
    <h2>Total referrals: {ref_count}</h2>
    Your referral link: 
    <a class="invite_link" href="{window.location.origin}/users/new?ref={current_user.ref_code}">
      {window.location.origin}/users/new?ref={current_user.ref_code}
    </a>
  </section>
</main>

