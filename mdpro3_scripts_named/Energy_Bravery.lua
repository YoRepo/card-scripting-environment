--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 能量勇士  (ID: 72631243)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level 4
-- ATK 1700 | DEF 1200
--
-- Effect Text:
-- 只要这张卡在自己场上表侧表示存在，自己场上存在的再度召唤状态的二重怪兽不会被卡的效果破坏。
--[[ __CARD_HEADER_END__ ]]

--エナジー・ブレイブ
function c72631243.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c72631243.indtg)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
function c72631243.indtg(e,c)
	return c:IsDualState()
end
