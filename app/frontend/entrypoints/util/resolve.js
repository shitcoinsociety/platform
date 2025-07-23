const pages = import.meta.glob('~/pages/**/*.svelte')
const layouts = import.meta.glob('~/layouts/**/*.svelte')

export default async (name) => {
  if (!pages[`/pages/${name}.svelte`]) {
    throw new Error(`Page not found: ${name}`)
  }
  const page = await pages[`/pages/${name}.svelte`]()
  const layout = name.startsWith('dashboard/')
    ? await layouts['/layouts/dashboard.svelte']()
    : await layouts['/layouts/landing.svelte']()
  return Object.assign({layout: layout.default}, page)
}