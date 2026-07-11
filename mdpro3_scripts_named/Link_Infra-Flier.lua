--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Link Infra-Flier  (ID: 65100616)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Cyberse
-- Level: 2
-- ATK 0 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Special Summon this card (from your hand) to your zone a Link Monster points to.
-- You can only Special Summon "Link Infra-Flier" once per turn this way.
--[[ __CARD_HEADER_END__ ]]

--リンク・インフライヤー
function c65100616.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,65100616+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c65100616.spcon)
	e1:SetValue(c65100616.spval)
	c:RegisterEffect(e1)
end
function c65100616.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local zone=Duel.GetLinkedZone(tp)
	return Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)>0
end
function c65100616.spval(e,c)
	return 0,Duel.GetLinkedZone(c:GetControler())
end
