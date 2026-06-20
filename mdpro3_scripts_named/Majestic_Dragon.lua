--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 救世龙  (ID: 21159309)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Dragon
-- Level 1
-- ATK 0 | DEF 0
-- Setcode: 63
--
-- Effect Text:
-- 把这张卡作为同调素材的场合，不是「救世」怪兽的同调召唤不能使用。
--[[ __CARD_HEADER_END__ ]]

--救世竜 セイヴァー・ドラゴン
function c21159309.initial_effect(c)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetValue(c21159309.synlimit)
	c:RegisterEffect(e2)
end
function c21159309.synlimit(e,c)
	if not c then return false end
	return not c:IsSetCard(0x3f)
end
