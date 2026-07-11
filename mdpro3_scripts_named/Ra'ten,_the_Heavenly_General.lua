--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Ra'ten, the Heavenly General  (ID: 30163008)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Warrior
-- Link Rating: 3
-- Link Arrows: Top-Left, Bottom-Left, Bottom-Right
-- ATK 2200
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2+ monsters with the same Type
-- Once per turn, during the Standby Phase: You can target 1 face-up monster this card points to;
-- Special Summon 1 Level 4 or lower monster with the same Type as that monster from your hand to your
-- zone this card points to.
-- At the start of the Battle Phase: You can target 1 card your opponent controls; destroy it.
-- You can only use this effect of "Ra'ten, the Heavenly General" once per turn.
--[[ __CARD_HEADER_END__ ]]

--羅天神将
function c30163008.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,nil,2,nil,c30163008.lcheck)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c30163008.target)
	e1:SetOperation(c30163008.operation)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_BATTLE_START)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,30163008)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetTarget(c30163008.destg)
	e2:SetOperation(c30163008.desop)
	c:RegisterEffect(e2)
end
function c30163008.lcheck(g)
	return aux.SameValueCheck(g,Card.GetLinkRace)
end
function c30163008.cfilter(c,e,tp,lg,zone)
	return c:IsFaceup() and lg:IsContains(c)
		and Duel.IsExistingMatchingCard(c30163008.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp,c:GetRace(),zone)
end
function c30163008.chkfilter(c,e,tp,lg,rc)
	return c:IsFaceup() and lg:IsContains(c) and c:GetRace()&rc==rc
end
function c30163008.spfilter(c,e,tp,rac,zone)
	return c:IsLevelBelow(4) and c:IsRace(rac) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,tp,zone)
end
function c30163008.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local lg=c:GetLinkedGroup()
	local zone=c:GetLinkedZone(tp)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c30163008.chkfilter(chkc,e,tp,lg,e:GetLabel()) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)>0
		and Duel.IsExistingTarget(c30163008.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,e,tp,lg,zone) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c30163008.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,e,tp,lg,zone)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
	e:SetLabel(g:GetFirst():GetRace())
end
function c30163008.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) or not tc:IsRelateToEffect(e) or tc:IsFacedown() then return end
	local zone=c:GetLinkedZone(tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sc=Duel.SelectMatchingCard(tp,c30163008.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp,tc:GetRace(),zone):GetFirst()
	if sc then
		Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP,zone)
	end
end
function c30163008.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,nil,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c30163008.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
