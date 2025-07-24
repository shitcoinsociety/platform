<script>
  const {
    referrals_count,
    total_earnings = 0,
    from_dividends = 0,
    from_commissions = 0
  } = $props();
</script>

<main>
  <section aria-labelledby="total-earnings">
    <div class="text-center">
      <h1 id="total-earnings">Total earnings</h1>
      <p>{total_earnings} Satoshi</p>
    </div>
  </section>
  <section aria-labelledby="breakdown">
    <h2 id="breakdown">Breakdown</h2>
    <div class="flex">
      <div class="grow">
        From dividends
      </div>
      <div>
        {from_dividends} Satoshi
      </div>
    </div>
    <div class="flex">
      <div class="grow">
        From commissions
      </div>
      <div>
        {from_commissions} Satoshi
      </div>
    </div>
  </section>
</main>

<style>
  .row {
    display: flex;
    justify-content: space-between;
    margin-bottom: 0.5rem;
  }
  .col {
    flex: 1;
    text-align: left;
  }
</style>