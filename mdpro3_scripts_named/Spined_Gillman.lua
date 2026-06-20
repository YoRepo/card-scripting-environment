--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 刺鱼人  (ID: 42463414)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Sea Serpent
-- Level 3
-- ATK 1300 | DEF 0
--
-- Effect Text:
-- ①：只要这张卡在怪兽区域存在，自己场上的鱼族·海龙族·水族怪兽的攻击力上升400。
--[[ __CARD_HEADER_END__ ]]

--ニードル・ギルマン
function c42463414.initial_effect(c)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c42463414.atktg)
	e1:SetValue(400)
	c:RegisterEffect(e1)
end
function c42463414.atktg(e,c)
	return c:IsRace(0x60040)
end
