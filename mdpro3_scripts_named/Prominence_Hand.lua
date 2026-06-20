--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 日珥手  (ID: 21414674)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level 4
-- ATK 600 | DEF 2000
--
-- Effect Text:
-- ①：自己场上有「魔术手」「火焰手」「寒冰手」的其中任意种存在的场合，这张卡可以从手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--プロミネンス・ハンド
function c21414674.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c21414674.spcon)
	c:RegisterEffect(e1)
end
function c21414674.filter(c)
	return c:IsFaceup() and c:IsCode(22530212,68535320,95929069)
end
function c21414674.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c21414674.filter,c:GetControler(),LOCATION_ONFIELD,0,1,nil)
end
