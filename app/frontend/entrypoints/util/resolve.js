const pages = import.meta.glob('~/pages/**/*.svelte')
const layouts = import.meta.glob('~/layouts/**/*.svelte')

export default async (name) => {
  if (!pages[`/pages/${name}.svelte`]) {
    throw new Error(`Page not found: ${name}`)
  }
  const page = await pages[`/pages/${name}.svelte`]()
  const layout = await layouts['/layouts/default.svelte']()
  return Object.assign({layout: layout.default}, page)
}