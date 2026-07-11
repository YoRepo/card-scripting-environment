--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Genex Furnace  (ID: 53944920)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level: 5
-- ATK 2000 | DEF 1300
-- Setcode: 0x2
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a face-up "Genex Controller", you can Normal Summon this card without Tributing.
--[[ __CARD_HEADER_END__ ]]

--ジェネクス・ヒート
function c53944920.initial_effect(c)
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(53944920,0))
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c53944920.ntcon)
	c:RegisterEffect(e1)
end
function c53944920.ntfilter(c)
	return c:IsFaceup() and c:IsCode(68505803)
end
function c53944920.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c53944920.ntfilter,c:GetControler(),LOCATION_ONFIELD,0,1,nil)
end
