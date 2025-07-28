<script>
  import { convert } from '~/lib/util.svelte';

  const {
    referrals_count,
    total_earnings = 10,
    from_dividends = 0,
    from_commissions = 0
  } = $props();

  function formatNumber(num) {
    return new Intl.NumberFormat('en-US', {
      style: 'decimal',
      minimumFractionDigits: 0,
      maximumFractionDigits: 3
    }).format(num);
  }
</script>

<main>
  <section aria-labelledby="total-earnings">
    <div class="card">
      <h1 id="total-earnings">Total Earnings</h1>
      <p class="amount">{formatNumber(total_earnings)} Satoshi</p>
      <p class="reference">~{formatNumber(convert(total_earnings, 'sat', 'eur'))} EUR</p>
      <div class="flex">
        <div class="btn secondary">
          <div class="i-bitcoin-icons:receive-outline"></div>
          Receive
        </div>
        <div class="btn secondary">
          <div class="i-bitcoin-icons:send-outline"></div>
          Send
        </div>
        <div class="btn secondary">
          <div class="i-bitcoin-icons:plus-outline"></div>
          Earn
        </div>
      </div>
    </div>

    <div class="flex">
      <div class="grow">
        From Dividends
      </div>
      <div>
        {from_dividends} Satoshi
      </div>
    </div>
    <div class="flex">
      <div class="grow">
        From Commissions
      </div>
      <div>
        {from_commissions} Satoshi
      </div>
    </div>
  </section>
</main>

<style>
  .card {
    padding: 1rem;
    background: conic-gradient(from 160deg at 50% 80%, #cfd8dc 0%, #e3f2fd 40%, #90a4ae 80%, #e3f2fd 100%);
    box-shadow: 0 2px 8px rgba(80, 120, 180, 0.08);
    border-radius: 1rem;
    border: 1px solid #b0bec5;
    position: relative;
    color: black;
    line-height: 1.2;
    
  }

  h1 {
    font-size: 1.2rem;
    font-weight: normal;
    margin-bottom: 1rem;
  }

  .amount {
    font-size: 2rem;
  }
  .reference {
    font-size: 0.8rem;
    color: #546e7a;
    margin-bottom: 1rem;
  }
</style>