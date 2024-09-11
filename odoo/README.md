# Odoo
Template for starting Odoo, an ERP and CRM system, on project IDX.

It's required to run `source .venv/bin/activate` in your terminal.

- `odoo-bin` -- the command to operate with odoo
- `odoo-bin scaffold <the-addon-name> custom_addons --template default` -- generate an addon in custom_addons folder

The debug mode can be enabled or disabled through the query param in the URL:

- `?debug=0` -- disable debug mode
- `?debug=1` -- enable debug mode
- `?debug=assets` -- enable debug mode with assets
- `?debug=tests` -- enable debug mode with tests assets

# Try it out
<a href="https://idx.google.com/new?template=https://github.com/project-idx/community-templates/tree/main/odoo">
  <picture>
    <source
      media="(prefers-color-scheme: dark)"
      srcset="https://cdn.idx.dev/btn/open_dark_32.svg">
    <source
      media="(prefers-color-scheme: light)"
      srcset="https://cdn.idx.dev/btn/open_light_32.svg">
    <img
      height="32"
      alt="Open in IDX"
      src="https://cdn.idx.dev/btn/open_purple_32.svg">
  </picture>
</a>