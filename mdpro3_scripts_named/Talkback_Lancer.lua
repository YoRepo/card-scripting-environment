--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Talkback Lancer  (ID: 96380700)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Cyberse
-- Link Rating: 1
-- Link Arrows: Bottom
-- ATK 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Level 2 or lower Cyberse monster
-- You can Tribute 1 other Cyberse monster, then target 1 "Code Talker" monster in your GY with a
-- different original name from that monster; Special Summon it to your zone this card points to.
-- You can only use this effect of "Talkback Lancer" once per turn.
--[[ __CARD_HEADER_END__ ]]

--トークバック・ランサー
function c96380700.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,c96380700.matfilter,1,1)
	c:EnableReviveLimit()
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(96380700,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,96380700)
	e1:SetCost(c96380700.spcost)
	e1:SetTarget(c96380700.sptg)
	e1:SetOperation(c96380700.spop)
	c:RegisterEffect(e1)
end
function c96380700.matfilter(c)
	return c:IsLevelBelow(2) and c:IsLinkRace(RACE_CYBERSE)
end
function c96380700.cfilter(c,e,tp,zone)
	return c:IsRace(RACE_CYBERSE) and c:IsType(TYPE_MONSTER) and Duel.GetMZoneCount(tp,c,tp,LOCATION_REASON_TOFIELD,zone)>0
		and Duel.IsExistingTarget(c96380700.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,c)
end
function c96380700.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local zone=c:GetLinkedZone(tp)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c96380700.cfilter,1,c,e,tp,zone) end
	local g=Duel.SelectReleaseGroup(tp,c96380700.cfilter,1,1,c,e,tp,zone)
	Duel.Release(g,REASON_COST)
	e:SetLabelObject(g:GetFirst())
end
function c96380700.spfilter(c,e,tp,rc)
	return c:IsSetCard(0x101) and c:IsType(TYPE_MONSTER) and not c:IsOriginalCodeRule(rc:GetOriginalCodeRule())
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c96380700.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local cc=e:GetLabelObject()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp)
		and c96380700.spfilter(chkc,e,tp,cc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c96380700.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,cc)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c96380700.spop(e,tp,eg,ep,ev,re,r,rp)
	local zone=e:GetHandler():GetLinkedZone(tp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and zone&0x1f~=0 then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP,zone)
	end
end
