local config = {
	cmd = { "/Users/taahirbhaiyat/.local/share/nvim/mason/packages/jdtls/bin/jdtls" },
	root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
}

local bundles = {
	vim.fn.glob(
		"/Users/taahirbhaiyat/.config/nvim/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
		true
	),
}

vim.list_extend(
	bundles,
	vim.split(vim.fn.glob("/Users/taahirbhaiyat/.config/nvim/vscode-java-test/server/*.jar", true), "\n")
)

config["init_options"] = {
	bundles = bundles,
}

require("jdtls").start_or_attach(config)
