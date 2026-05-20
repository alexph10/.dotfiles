" Simple health check script
echo "Running Neovim health checks..."
checkhealth mason
checkhealth nvim-treesitter  
checkhealth telescope
checkhealth provider
quit
