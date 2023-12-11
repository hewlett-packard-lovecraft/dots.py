vim.g["vimtex_view_method"] = "general"
vim.g["vimtex_context_pdf_viewer"] = "okular"

-- Error suppression:
-- https://github.com/lervag/vimtex/blob/master/doc/vimtex.txt

vim.g["vimtex_log_ignore"] = {
	"Underfull",
	"Overfull",
	"specifier changed to",
	"Token not allowed in a PDF string",
}
