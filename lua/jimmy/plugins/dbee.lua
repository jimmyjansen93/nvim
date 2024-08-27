return {
  {
    'kndndrj/nvim-dbee',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    build = function()
      require('dbee').install()
    end,
    config = function()
      require('dbee').setup {
        sources = {
          require('dbee.sources').MemorySource:new {
            {
              id = 'EliteTourneyStats',
              name = 'EliteTourneyStats',
              type = 'sqlite',
              url = '~/projects/elitetourneystats/elite.db',
            },
          },
        },
      }
    end,
  },
}
