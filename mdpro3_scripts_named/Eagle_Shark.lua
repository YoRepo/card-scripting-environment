--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Eagle Shark  (ID: 7500772)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level: 5
-- ATK 1000 | DEF 1800
-- Setcode: 0x1b8
-- Scope: OCG / TCG
--
-- Effect Text:
-- If your opponent controls 2 or more monsters, you can Normal Summon this card without Tributing.
-- If you control "Panther Shark", you can Special Summon this card (from your hand).
-- You can only control 1 "Eagle Shark".
--[[ __CARD_HEADER_END__ ]]

--イーグル・シャーク
function c7500772.initial_effect(c)
	c:SetUniqueOnField(1,0,7500772)
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(7500772,0))
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c7500772.ntcon)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_HAND)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetCondition(c7500772.spcon)
	c:RegisterEffect(e2)
end
function c7500772.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)>1
end
function c7500772.filter(c)
	return c:IsFaceup() and c:IsCode(70101178)
end
function c7500772.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c7500772.filter,c:GetControler(),LOCATION_ONFIELD,0,1,nil)
end
