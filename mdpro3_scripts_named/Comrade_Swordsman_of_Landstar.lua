--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 共同战斗的地星剑士  (ID: 83602069)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Warrior
-- Level 3
-- ATK 500 | DEF 1200
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，自己场上表侧表示存在的战士族怪兽的攻击力上升400。
--[[ __CARD_HEADER_END__ ]]

--共闘するランドスターの剣士
function c83602069.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_WARRIOR))
	e1:SetValue(400)
	c:RegisterEffect(e1)
end
