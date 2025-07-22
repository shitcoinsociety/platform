<script>
  import './default.css';
  import { subscribe } from 'activestate';

  subscribe('GlobalChannel')

  const {
    children
  } = $props();
</script>

{@render children()}