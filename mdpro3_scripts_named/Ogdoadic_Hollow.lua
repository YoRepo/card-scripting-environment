--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 溟界之虚  (ID: 96433300)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
-- Setcode: 353
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：自己·对方的主要阶段，把自己场上1只爬虫类族效果怪兽解放，以对方墓地1只怪兽为对象才能发动。那只怪兽在自己场上特殊召唤。这个效果特殊召唤的怪兽在结束阶段送去墓地。
-- ②：魔法与陷阱区域的表侧表示的这张卡被送去墓地的场合发动。爬虫类族怪兽以外的自己场上的表侧表示怪兽全部送去墓地。
--[[ __CARD_HEADER_END__ ]]

--溟界の虚
function c96433300.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(96433300,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetRange(LOCATION_SZONE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetHintTiming(0,TIMING_MAIN_END)
	e2:SetCountLimit(1,96433300)
	e2:SetCondition(c96433300.spcon)
	e2:SetCost(c96433300.spcost)
	e2:SetTarget(c96433300.sptg)
	e2:SetOperation(c96433300.spop)
	c:RegisterEffect(e2)
	--to grave
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(96433300,1))
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c96433300.tgcon)
	e3:SetTarget(c96433300.tgtg)
	e3:SetOperation(c96433300.tgop)
	c:RegisterEffect(e3)
end
function c96433300.spcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph==PHASE_MAIN1 or ph==PHASE_MAIN2
end
function c96433300.rfilter(c,tp)
	return c:IsRace(RACE_REPTILE) and c:IsType(TYPE_EFFECT)
		and (c:IsControler(tp) or c:IsFaceup()) and Duel.GetMZoneCount(tp,c)>0
end
function c96433300.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c96433300.rfilter,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectReleaseGroup(tp,c96433300.rfilter,1,1,nil,tp)
	Duel.Release(g,REASON_COST)
end
function c96433300.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c96433300.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_GRAVE) and c96433300.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c96433300.spfilter,tp,0,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c96433300.spfilter,tp,0,LOCATION_GRAVE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c96433300.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local fid=e:GetHandler():GetFieldID()
		tc:RegisterFlagEffect(96433300,RESET_EVENT+RESETS_STANDARD,0,1,fid)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetLabel(fid)
		e1:SetLabelObject(tc)
		e1:SetCondition(c96433300.tgcon1)
		e1:SetOperation(c96433300.tgop1)
		Duel.RegisterEffect(e1,tp)
	end
end
function c96433300.tgcon1(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:GetFlagEffectLabel(96433300)~=e:GetLabel() then
		e:Reset()
		return false
	else return true end
end
function c96433300.tgop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoGrave(e:GetLabelObject(),REASON_EFFECT)
end
function c96433300.tgcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_SZONE) and c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousSequence()<5
end
function c96433300.cfilter(c)
	return not c:IsRace(RACE_REPTILE) and c:IsFaceup() and c:IsAbleToGrave()
end
function c96433300.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c96433300.cfilter,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,#g,0,0)
end
function c96433300.tgop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c96433300.cfilter,tp,LOCATION_MZONE,0,nil)
	if #g>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
