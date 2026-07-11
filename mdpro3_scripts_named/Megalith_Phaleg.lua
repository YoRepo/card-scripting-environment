--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Megalith Phaleg  (ID: 63233638)
-- Type: Monster / Effect / Ritual
-- Attribute: EARTH
-- Race: Rock
-- Level: 8
-- ATK 2500 | DEF 1200
-- Setcode: 0x138
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Ritual Summon this card with a "Megalith" card.
-- You can discard this card; Ritual Summon 1 "Megalith" Ritual Monster from your hand, by Tributing
-- monsters from your hand or field whose total Levels equal or exceed its Level.
-- You can only use this effect of "Megalith Phaleg" once per turn.
-- Monsters you control gain 300 ATK/DEF for each Ritual Monster in your GY.
--[[ __CARD_HEADER_END__ ]]

--メガリス・ファレグ
function c63233638.initial_effect(c)
	c:EnableReviveLimit()
	--ritual summon
	local e1=aux.AddRitualProcGreater2(c,c63233638.filter,nil,nil,c63233638.matfilter,true)
	e1:SetDescription(aux.Stringid(63233638,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCode(0)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,63233638)
	e1:SetCost(c63233638.rscost)
	c:RegisterEffect(e1)
	--atk/def up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetValue(c63233638.val)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
end
function c63233638.filter(c,e,tp,chk)
	return c:IsSetCard(0x138) and (not chk or c~=e:GetHandler())
end
function c63233638.matfilter(c,e,tp,chk)
	return not chk or c~=e:GetHandler()
end
function c63233638.rscost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c63233638.cfilter(c)
	return c:IsType(TYPE_RITUAL) and c:IsType(TYPE_MONSTER)
end
function c63233638.val(e,c)
	return Duel.GetMatchingGroupCount(c63233638.cfilter,e:GetHandlerPlayer(),LOCATION_GRAVE,0,nil)*300
end
