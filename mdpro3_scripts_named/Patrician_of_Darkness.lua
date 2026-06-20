--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 黑暗贵族  (ID: 19153634)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level 5
-- ATK 2000 | DEF 1400
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，对方怪兽的攻击对象由这张卡的控制者选择。
--[[ __CARD_HEADER_END__ ]]

--ノーブル・ド・ノワール
function c19153634.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_PATRICIAN_OF_DARKNESS)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	c:RegisterEffect(e1)
end
