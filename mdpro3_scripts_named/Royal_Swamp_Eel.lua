--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 龙宫的白鳝  (ID: 37953640)
-- Type: Monster / Effect / Tuner
-- Attribute: WATER
-- Race: Fish
-- Level 4
-- ATK 1700 | DEF 1200
--
-- Effect Text:
-- 把这张卡作为同调素材的场合，其他的同调素材怪兽必须全部是鱼族怪兽。
--[[ __CARD_HEADER_END__ ]]

--竜宮の白タウナギ
function c37953640.initial_effect(c)
	--synchro custom
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_TUNER_MATERIAL_LIMIT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetTarget(c37953640.synlimit)
	c:RegisterEffect(e1)
end
function c37953640.synlimit(e,c)
	return c:IsRace(RACE_FISH)
end
