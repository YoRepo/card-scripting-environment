--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Great Moth  (ID: 14141448)
-- Type: Monster / Effect / Special Summon
-- Attribute: EARTH
-- Race: Insect
-- Level: 8
-- ATK 2600 | DEF 2500
-- Scope: OCG / TCG
--
-- Effect Text:
-- This monster cannot be Normal Summoned or Set.
-- This card can only be Special Summoned by Tributing "Petit Moth" on the 4th of your turns after
-- "Petit Moth" has been equipped with "Cocoon of Evolution".
--[[ __CARD_HEADER_END__ ]]

--グレート・モス
function c14141448.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c14141448.spcon)
	e2:SetTarget(c14141448.sptg)
	e2:SetOperation(c14141448.spop)
	c:RegisterEffect(e2)
end
function c14141448.eqfilter(c)
	return c:IsCode(40240595) and c:GetTurnCounter()>=4
end
function c14141448.rfilter(c,tp)
	return c:IsCode(58192742) and c:GetEquipGroup():IsExists(c14141448.eqfilter,1,nil)
		and Duel.GetMZoneCount(tp,c)>0
end
function c14141448.spcon(e,c)
	if c==nil then return true end
	return Duel.CheckReleaseGroupEx(c:GetControler(),c14141448.rfilter,1,REASON_SPSUMMON,false,nil,c:GetControler())
end
function c14141448.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetReleaseGroup(tp,false,REASON_SPSUMMON):Filter(c14141448.rfilter,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c14141448.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.Release(g,REASON_SPSUMMON)
end
