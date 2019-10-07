extends CanvasLayer

func _ready():
	update_stats()
	update_lives()
	
func _process(delta):
	update_money()
	update_lives()
	
func update_lives():
	$Rect/Top/TopContainer/LifeDamage/LivesBox/Lives.set_text(str(GLOBAL.PLAYER_LIFE))
	
func update_stats():
	$Rect/Bot/BotContainer/PlayerLevelBox/PlayerLevel.set_text(str(GLOBAL.PLAYER_LEVEL))
	$Rect/Top/TopContainer/LifeDamage/DamageBox/Damage.set_text(str(GLOBAL.PLAYER_DAMAGE))
	$Rect/Bot/BotContainer/EnemyLevelBox/EnemyLevel.set_text(str(GLOBAL.ENEMY_LEVEL))
	if GLOBAL.ENEMY_MAX_LEVEL < 3:
		$Rect/Top/TopContainer/Money/EnemyNextLevelBox/EnemyNextLevel.set_text(str(GLOBAL.ENEMY_LEVEL_COST))
	else:
		$Rect/Top/TopContainer/Money/EnemyNextLevelBox/EnemyNextLevel.set_text("max level")
func update_money():
	$Rect/Top/TopContainer/Money/PlayerMoneyBox/PlayerMoney.set_text(str(GLOBAL.PLAYER_MONEY))
	$Rect/Top/TopContainer/Money/EnemyMoneyBox/EnemyMoney.set_text(str(GLOBAL.ENEMY_MONEY))

func _on_EnemySpawner_update_hud():
	update_stats()
	


func _on_Shop_player_level_up():
	update_stats()
