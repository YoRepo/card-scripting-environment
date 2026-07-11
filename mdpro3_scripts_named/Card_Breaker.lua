--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Card Breaker  (ID: 51047350)
-- Type: Monster / Effect / Special Summon
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 2
-- ATK 100 | DEF 900
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card cannot be Normal Summoned or Set.
-- This card can only be Special Summoned, in face-up Attack Position, by sending 1 card from your
-- Spell & Trap Card Zone to the Graveyard.
--[[ __CARD_HEADER_END__ ]]

--カード・ブレイカー
function c51047350.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e1:SetTargetRange(POS_FACEUP_ATTACK,0)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c51047350.spcon)
	e1:SetTarget(c51047350.sptg)
	e1:SetOperation(c51047350.spop)
	c:RegisterEffect(e1)
end
function c51047350.filter(c)
	return c:GetSequence()<5 and c:IsAbleToGraveAsCost()
end
function c51047350.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c51047350.filter,c:GetControler(),LOCATION_SZONE,0,1,nil)
end
function c51047350.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c51047350.filter,tp,LOCATION_SZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c51047350.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.SendtoGrave(g,REASON_SPSUMMON)
end
