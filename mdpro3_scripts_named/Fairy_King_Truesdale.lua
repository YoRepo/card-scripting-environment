--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 妖精王 奥布朗  (ID: 45425051)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Plant
-- Level 6
-- ATK 2200 | DEF 1500
--
-- Effect Text:
-- ①：只要这张卡在怪兽区域守备表示存在，自己场上的植物族怪兽的攻击力·守备力上升500。
--[[ __CARD_HEADER_END__ ]]

--妖精王オベロン
function c45425051.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c45425051.con)
	e1:SetTarget(c45425051.tg)
	e1:SetValue(500)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetValue(500)
	c:RegisterEffect(e2)
end
function c45425051.con(e)
	return e:GetHandler():IsDefensePos()
end
function c45425051.tg(e,c)
	return c:IsRace(RACE_PLANT)
end
