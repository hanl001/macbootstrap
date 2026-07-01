#!/usr/bin/env bash
# 把 ~/.agents/skills/<name> 幂等软链进各 agent 运行时的 skill 目录，
# 让原本只供 Claude 桌面 App 安装的 skill 同时被 Claude Code CLI 和 Codex 识别。
#
# 背景：~/.agents/skills 是 Claude 桌面 App 的 skill 注册目录；卸载 App 后没有
# 任何运行时再读它，这些 skill 就「失效」。各 CLI 运行时各读各的目录：
#   Claude Code CLI -> ~/.claude/skills
#   Codex           -> ~/.codex/skills
# 本脚本把 ~/.agents/skills 下每个 skill 软链补进上述目录，并清理失效软链。
#
# 安全边界：只创建/清理「指向 ~/.agents/skills 的软链」，绝不触碰各运行时
# 自己指向 devops/config/agents/skills 的那批软链。
set -euo pipefail

SRC="$HOME/.agents/skills"

# 目标运行时的 skill 目录：存在哪个就同步哪个，缺失的跳过（不强建目录）
TARGETS=(
  "$HOME/.claude/skills"   # Claude Code CLI
  "$HOME/.codex/skills"    # Codex
  "$HOME/.hermes/skills"   # Hermes Agent
)

[ -d "$SRC" ] || { echo "源目录不存在: $SRC，跳过"; exit 0; }

total_linked=0 total_pruned=0

for DST in "${TARGETS[@]}"; do
  [ -d "$DST" ] || continue        # 该运行时未安装则跳过
  linked=0 pruned=0

  # 1) 补/修软链
  for d in "$SRC"/*/; do
    [ -f "$d/SKILL.md" ] || continue
    name="$(basename "$d")"
    target="${d%/}"
    link="$DST/$name"
    if [ -L "$link" ] && [ "$(readlink "$link")" = "$target" ]; then
      continue
    fi
    if [ -e "$link" ] || [ -L "$link" ]; then
      cur="$(readlink "$link" 2>/dev/null || true)"
      if [ -L "$link" ] && [ "${cur#$SRC/}" != "$cur" ]; then
        ln -sfn "$target" "$link"        # 旧链也指向 ~/.agents，源换路径了 → 修正
        linked=$((linked+1))
      fi
      # 否则已被别处占用（如 devops 同名 skill）→ 让位，静默跳过
      continue
    fi
    ln -s "$target" "$link"
    linked=$((linked+1))
  done

  # 2) 清理失效软链（仅清指向 ~/.agents/skills 且源已删的悬空链）
  for link in "$DST"/*; do
    [ -L "$link" ] || continue
    tgt="$(readlink "$link")"
    case "$tgt" in
      "$SRC"/*) [ -e "$link" ] || { rm "$link"; pruned=$((pruned+1)); } ;;
    esac
  done

  total_linked=$((total_linked+linked))
  total_pruned=$((total_pruned+pruned))
done

echo "agents skills 同步完成: 新增/修复 ${total_linked}, 清理失效 ${total_pruned}"
