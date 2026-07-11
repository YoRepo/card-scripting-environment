--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Big Piece Golem  (ID: 25247218)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level: 5
-- ATK 2100 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- If your opponent controls a monster and you control no monsters, you can Normal Summon this card
-- without Tributing.
--[[ __CARD_HEADER_END__ ]]

--ビッグ・ピース・ゴーレム
function c25247218.initial_effect(c)
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(25247218,0))
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c25247218.ntcon)
	c:RegisterEffect(e1)
end
function c25247218.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)==0
		and Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)>0
end
