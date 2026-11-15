--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-11-15T00:00:00
-- Card: Ink Shader Carling  (ID: 99811000)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 4
-- ATK 950 | DEF 1600
-- Setcode: 0x960 (Ink Shader)
--
-- Effect Text:
-- You can Special Summon this card (from your hand) by discarding 1 "Ink-Shade" Spell/Trap. You can
-- only Special Summon "Ink Shader Carling" once per turn this way. You can only use the ① effect of
-- "Ink Shader Carling" once per turn.
-- ① If this card is Normal or Special Summoned: You can send 1 "Ink-Shade" Spell/Trap from your Deck
-- to the GY.
-- ② Gains 1 Level for each of your banished "Ink-Shade" Spell/Traps.
--[[ __CARD_HEADER_END__ ]]

--Ink Shader Carling
local s,id,o=GetID()
function s.initial_effect(c)
	--SS proc (from hand): discard 1 "Ink-Shade" Spell/Trap; once per turn this way (cf. Nightmare Apprentice)
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetRange(LOCATION_HAND)
	e0:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e0:SetCondition(s.spcon)
	e0:SetTarget(s.sptg)
	e0:SetOperation(s.spop)
	c:RegisterEffect(e0)
	--(1) if this card is Normal or Special Summoned: send 1 "Ink-Shade" Spell/Trap from Deck to GY
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,id+o)
	e1:SetTarget(s.tgtg)
	e1:SetOperation(s.tgop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--(2) gains 1 Level for each of your banished "Ink-Shade" Spells/Traps (cf. Mecha Phantom Beast Raiten)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_UPDATE_LEVEL)
	e3:SetValue(s.lvval)
	c:RegisterEffect(e3)
end
--SS proc (discard 1 "Ink-Shade" Spell/Trap)
function s.spcfilter(c)
	return c:IsSetCard(0x961) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDiscardable(REASON_SPSUMMON)
end
function s.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.spcfilter,tp,LOCATION_HAND,0,1,c)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(s.spcfilter,tp,LOCATION_HAND,0,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function s.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local tc=e:GetLabelObject()
	Duel.SendtoGrave(tc,REASON_SPSUMMON+REASON_DISCARD)
end
--(1)
function s.tgfilter(c)
	return c:IsSetCard(0x961) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToGrave()
end
function s.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function s.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,s.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
--(2)
--"your banished": face-up cards in your banishment (a face-down banished card has no name)
function s.lvfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x961) and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function s.lvval(e,c)
	return Duel.GetMatchingGroupCount(s.lvfilter,c:GetControler(),LOCATION_REMOVED,0,nil)
end
