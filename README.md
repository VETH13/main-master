# Ritual-Game Demo — 本地运行说明

概览
- 这是一个 Godot 4 的 2D 平台原型骨架 + 网页包装器示例，用于在浏览器中连接钱包（MetaMask）并与导出的 HTML5 游戏通信（只读：显示地址与余额）。默认使用 Ritual 测试网（需要你从 Ritual 官方文档填入 RPC/chainId/Explorer 等参数）。

所需软件
- Godot 4.x（用于编辑与导出 HTML5；如果使用 Godot 3.5 请改写脚本）
- 若要在本地打开 index.html（含 iframe 加载导出文件），**请使用本地静态服务器**（浏览器对 file:// 有跨域/WASM 限制）。
  - Python 3: `python -m http.server 8000`
  - 或者使用 VSCode Live Server 插件

快速运行步骤（本地）
1. 在 Godot 中新建项目（建议项目目录为 `ritual-game/`）。
2. 在项目里创建场景：
   - 根节点 Node2D（命名 Main）
   - 新增 CharacterBody2D 节点命名 Player，附加 `player.gd` 脚本（把 player.gd 放到项目根目录）
   - 添加一个 StaticBody2D 作为地面，并配置 CollisionShape2D（矩形）
   - 在 Project Settings -> Input Map 中添加动作：
     - ui_left: A, Left
     - ui_right: D, Right
     - ui_up: W, Space, Up
3. 本地测试：在编辑器中运行场景检查控制与碰撞是否正常。
4. 导出为 HTML5：
   - 在 Godot 中设置 Export -> Add -> HTML5（你需要安装 Godot 的 HTML5 export templates）
   - 导出会生成 `game.html`, `game.pck`, 以及 `engine.*` 等文件（具体文件名依据你的导出配置）
5. 把导出的文件（`game.html` 等）放在与 `index.html` 同一目录（上面提供的 index.html 假设 iframe src="game.html"）。
6. 启动本地静态服务器：在该目录运行 `python -m http.server 8000`，然后打开 `http://localhost:8000/index.html`。
7. 点击页面右上角的 “Connect Wallet”，用 MetaMask 连接钱包（请先在 MetaMask 中添加 Ritual 测试网参数，见下面说明）。

如何把 Ritual 测试网加入 MetaMask（示例）
- Ritual 的 RPC / chainId 请以官方文档为准，下面是示例结构（占位）：
{
  chainId: '0xXXXX', // 十六进制 chainId，例如 '0x1' 是 Ethereum 主网
  chainName: 'Ritual Testnet',
  rpcUrls: ['https://<RITUAL_TESTNET_RPC>'],
  nativeCurrency: { name: 'Ritual', symbol: 'RIT', decimals: 18 },
  blockExplorerUrls: ['https://explorer.ritual.test/']
}
- 将上面的参数替换为 Ritual 官方提供的值后，index.html 中的 RITUAL_TESTNET_PARAMS 可自动调用 `wallet_addEthereumChain` 来添加/切换网络。

关于链上写入（安全提示）
- 当前演示默认不自动发送任何交易。读取余额（provider.getBalance）是只读调用，不花费 gas。
- 若你想在通关时“写入链上”（如 mint NFT / 写分数），我会把示例合约 ABI + JS 调用代码放入 repo，并在 README 中标注如何在测试网运行与估算 gas。任何写入都需你在钱包中确认。

下一步（请告诉我）
- 你是否需要我把这些文件直接打包并推到 GitHub 仓库？（如果是，请给我仓库名 owner/repo 或允许我在你的账户下创建仓库）
- 或者你现在先在本地试运行，有问题我再调整或直接生成可玩 HTML5 导出包并发给你？

如果你希望我继续，我会按你选择：
- 把文件推到 GitHub（需要仓库信息）
- 或者我接着在 3–7 天内完成完整 HTML5 导出（含更完善关卡与钱包交互示例）
