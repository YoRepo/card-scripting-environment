--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 七音服·索尔费吉娅  (ID: 84693918)
-- Type: Monster / Effect / Pendulum
-- Attribute: LIGHT
-- Race: Fairy
-- Level 2
-- Pendulum Scales: L9 / R9
-- ATK 400 | DEF 400
-- Setcode: 354
--
-- Effect Text:
-- ←9 【灵摆】 9→
-- 这个卡名的灵摆效果1回合只能使用1次。
-- ①：由对方在场上发动的怪兽的效果的处理时，自己场上有「大钢琴之七音服」怪兽存在的场合，可以把那个发动的效果无效。那之后，这张卡破坏。
-- 【怪兽效果】
-- 这个卡名的①②的怪兽效果1回合各能使用1次。
-- ①：自己场上的怪兽不存在的场合或者只有「七音服」怪兽的场合才能发动。这张卡从手卡特殊召唤。
-- ②：自己主要阶段才能发动（也能把这张卡解放来发动）。从手卡把「七音服·索尔费吉娅」以外的1只「七音服」怪兽特殊召唤。把这张卡解放发动的场合，也能从自己的额外卡组（表侧）·墓地选特殊召唤的怪兽。
--[[ __CARD_HEADER_END__ ]]

--ドレミコード・ソルフェージア
local s,id,o=GetID()
function s.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--Negate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAIN_SOLVING)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCondition(s.negcon)
	e1:SetOperation(s.negop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,id)
	e2:SetCondition(s.spcon)
	e2:SetTarget(s.sptg)
	e2:SetOperation(s.spop)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,id+o)
	e3:SetCost(s.spcost2)
	e3:SetTarget(s.sptg2)
	e3:SetOperation(s.spop2)
	c:RegisterEffect(e3)
end
function s.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x1162)
end
function s.negcon(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and Duel.GetFlagEffect(tp,id)==0
		and Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)==LOCATION_MZONE
		and re:IsActiveType(TYPE_MONSTER)
		and Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsChainDisablable(ev) and not Duel.IsChainDisabled(ev)
end
function s.negop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,id)==0
		and Duel.SelectEffectYesNo(tp,e:GetHandler(),aux.Stringid(id,3)) then
		Duel.Hint(HINT_CARD,0,id)
		Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,0,1)
		if Duel.NegateEffect(ev) then
			Duel.BreakEffect()
			Duel.Destroy(e:GetHandler(),REASON_EFFECT)
		end
	end
end
function s.cfilter2(c)
	return c:IsFacedown() or not c:IsSetCard(0x162)
end
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(s.cfilter2,tp,LOCATION_MZONE,0,1,nil)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToChain() then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function s.spcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(s.spfilter2,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_EXTRA,0,nil,e,tp,c:IsReleasable(),c)
	if chk==0 then return g:GetCount()>0 end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and g:IsExists(Card.IsLocation,1,nil,LOCATION_HAND) and (not c:IsReleasable() or not Duel.SelectYesNo(tp,aux.Stringid(id,2))) then
		e:SetLabel(0)
	else
		Duel.Release(c,REASON_COST)
		e:SetLabel(1)
	end
end
function s.spfilter2(c,e,tp,res,rc)
	return c:IsFaceupEx() and not c:IsCode(id) and c:IsSetCard(0x162)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and (res and (not c:IsLocation(LOCATION_EXTRA)
		and Duel.GetMZoneCount(tp,rc)>0
		or c:IsLocation(LOCATION_EXTRA) and Duel.GetLocationCountFromEx(tp,tp,rc,c)>0)
		or c:IsLocation(LOCATION_HAND) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0)
end
function s.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(s.spfilter2,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_EXTRA,0,1,nil,e,tp,c:IsReleasable(),c) end
	local loc=LOCATION_HAND
	if e:GetLabel()==1 then
		loc=LOCATION_HAND+LOCATION_GRAVE+LOCATION_EXTRA
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,loc)
end
function s.spop2(e,tp,eg,ep,ev,re,r,rp)
	local res=false
	if e:GetLabel()==1 then
		res=true
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.spfilter2),tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_EXTRA,0,1,1,nil,e,tp,res,nil)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
