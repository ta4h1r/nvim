require("avante").setup({
	provider = "ollama",
	providers = {
		copilot = {
			endpoint = "https://api.githubcopilot.com",
			model = "gpt-4o-2024-11-20",
			proxy = nil, -- [protocol://]host[:port] Use this proxy
			allow_insecure = true, -- Allow insecure server connections
			timeout = 30000, -- Timeout in milliseconds
			context_window = 128000, -- Number of tokens to send to the model for context
			extra_request_body = {
				temperature = 0.75,
				max_tokens = 20480,
			},
		},
		openai = {
			endpoint = "https://api.openai.com/v1",
			model = "gpt-3.5-turbo",
			api_key_name = "AVANTE_OPENAI_API_KEY",
			timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
			context_window = 128000, -- Number of tokens to send to the model for context
			extra_request_body = {
				temperature = 0.75,
				max_completion_tokens = 16384, -- Increase this to include reasoning tokens (for reasoning models)
				reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
			},
		},
		claude = {
			endpoint = "https://api.anthropic.com",
			model = "claude-sonnet-4-20250514",
			api_key_name = "AVANTE_ANTHROPIC_API_KEY",
			timeout = 30000, -- Timeout in milliseconds
			extra_request_body = {
				temperature = 0.75,
				max_tokens = 20480,
			},
		},
		ollama = {
			model = "deepseek-r1:8b",
			endpoint = "http://127.0.0.1:11434",
			timeout = 30000, -- Timeout in milliseconds
			extra_request_body = {
				options = {
					temperature = 0.75,
					num_ctx = 20480,
					keep_alive = "5m",
				},
			},
		},
	},
})
