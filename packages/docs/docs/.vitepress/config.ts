import { defineConfig } from 'vitepress';

// refer https://vitepress.dev/reference/site-config for details
export default defineConfig({
  lang: 'pl-PL',
  title: 'Lythar',
  description: 'Sprawozdanie z projektu zespołowego Lythar na zawody "Primus Inter Pares 2024"',

  themeConfig: {
    nav: [
      { text: 'Sprawozdanie', link: '/main' },
    ],

    sidebar: [
      {
        items: [
          { text: 'Informacje', link: '/main' },
        ],
      },
    ],
  },
});
