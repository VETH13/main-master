extends CharacterBody2D

# Godot 4 角色控制脚本（简单版）
@export var speed: float = 300.0
@export var jump_velocity: float = -520.0
const GRAVITY: float = 1400.0

func _physics_process(delta):
    var dir_x := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
    velocity.x = dir_x * speed

    if not is_on_floor():
        velocity.y += GRAVITY * delta
    else:
        if Input.is_action_just_pressed("ui_up"):
            velocity.y = jump_velocity

    velocity = move_and_slide(velocity, Vector2.UP)

# 简单通关检测示例（可放在终点区域的 Area2D 信号里）
func on_reached_goal():
    # 这个函数由主场景调用或信号触发
    # 向外层页面发送 postMessage（在 HTML 导出中可用）
    if Engine.is_editor_hint():
        return
    var js := "window.parent.postMessage({type:'GAME_EVENT', event:'level_complete'}, '*');"
    JavaScript.eval(js, false)
