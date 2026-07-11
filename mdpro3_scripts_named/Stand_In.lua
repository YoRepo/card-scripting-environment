--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Stand In  (ID: 49154689)
-- Type: Spell / Quick-Play
-- Scope: OCG / TCG
--
-- Effect Text:
-- Tribute 1 monster, then target 1 monster in your opponent's GY with the same original Type and
-- Attribute; Special Summon it to your field.
-- You can only activate 1 "Stand In" per turn.
--[[ __CARD_HEADER_END__ ]]

--スタンド・イン
function c49154689.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetLabel(0)
	e1:SetCountLimit(1,49154689+EFFECT_COUNT_CODE_OATH)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCost(c49154689.cost)
	e1:SetTarget(c49154689.target)
	e1:SetOperation(c49154689.activate)
	c:RegisterEffect(e1)
end
function c49154689.cfilter(c,e,tp)
	local race=c:GetOriginalRace()
	local attr=c:GetOriginalAttribute()
	return bit.band(c:GetOriginalType(),TYPE_MONSTER)~=0
		and Duel.GetMZoneCount(tp,c,tp)>0
		and Duel.IsExistingMatchingCard(c49154689.spfilter,tp,0,LOCATION_GRAVE,1,nil,race,attr,e,tp)
end
function c49154689.spfilter(c,race,attr,e,tp)
	return c:GetOriginalRace()==race and c:GetOriginalAttribute()==attr
		and c:IsCanBeEffectTarget(e)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,tp)
end
function c49154689.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c49154689.cfilter,1,nil,e,tp) end
	local sg=Duel.SelectReleaseGroup(tp,c49154689.cfilter,1,1,nil,e,tp)
	e:SetLabelObject(sg:GetFirst())
	Duel.Release(sg,REASON_COST)
end
function c49154689.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local rc=e:GetLabelObject()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp)
		and c49154689.spfilter(chkc,rc:GetOriginalRace(),rc:GetOriginalAttribute(),e,tp) end
	if chk==0 then
		if e:GetLabel()~=100 then return false end
		e:SetLabel(0)
		return true
	end
	e:SetLabel(0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectTarget(tp,c49154689.spfilter,tp,0,LOCATION_GRAVE,1,1,nil,rc:GetOriginalRace(),rc:GetOriginalAttribute(),e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,sg,1,0,0)
end
function c49154689.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
end
