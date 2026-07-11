--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Bujinfidel  (ID: 66727115)
-- Type: Trap
-- Setcode: 0x88
-- Scope: OCG / TCG
--
-- Effect Text:
-- Tribute 1 Beast-Warrior-Type "Bujin" monster, then target 1 "Bujin" monster with a different name in
-- your Graveyard; Special Summon that target.
--[[ __CARD_HEADER_END__ ]]

--武神逐
function c66727115.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c66727115.cost)
	e1:SetTarget(c66727115.target)
	e1:SetOperation(c66727115.activate)
	c:RegisterEffect(e1)
end
function c66727115.rfilter(c,e,tp)
	return c:IsSetCard(0x88) and c:IsRace(RACE_BEASTWARRIOR)
		and Duel.IsExistingTarget(c66727115.spfilter,tp,LOCATION_GRAVE,0,1,nil,c:GetCode(),e,tp)
end
function c66727115.spfilter(c,code,e,tp)
	return c:IsSetCard(0x88) and not c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c66727115.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function c66727115.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c66727115.spfilter(chkc,e:GetLabel(),e,tp) end
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.CheckReleaseGroup(tp,c66727115.rfilter,1,nil,e,tp)
	end
	local g=Duel.SelectReleaseGroup(tp,c66727115.rfilter,1,1,nil,e,tp)
	local code=g:GetFirst():GetCode()
	e:SetLabel(code)
	Duel.Release(g,REASON_COST)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectTarget(tp,c66727115.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,code,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,sg,1,0,0)
end
function c66727115.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
