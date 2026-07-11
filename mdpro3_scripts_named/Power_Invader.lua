--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Power Invader  (ID: 18842395)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 5
-- ATK 2200 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- If your opponent controls 2 or more monsters, you can Normal Summon this card without Tributing.
--[[ __CARD_HEADER_END__ ]]

--パワー・インベーダー
function c18842395.initial_effect(c)
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(18842395,0))
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c18842395.ntcon)
	c:RegisterEffect(e1)
end
function c18842395.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)>=2
end
