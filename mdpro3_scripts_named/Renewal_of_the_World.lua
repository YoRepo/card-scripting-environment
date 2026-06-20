--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 世界再生  (ID: 81306186)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：作为这张卡的发动时的效果处理，从卡组把1只仪式怪兽除外。
-- ②：可以把这张卡送去墓地，从以下效果选择1个发动。
-- ●直到变成仪式召唤的怪兽的等级以上为止，把自己的手卡·场上1只怪兽解放或者作为解放的代替而让自己墓地1只仪式怪兽回到卡组，把这张卡的①的效果除外的怪兽仪式召唤。
-- ●这张卡的效果除外的怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--リターン・オブ・ザ・ワールド
function c81306186.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCountLimit(1,81306186)
	e1:SetTarget(c81306186.rmtg)
	e1:SetOperation(c81306186.rmop)
	c:RegisterEffect(e1)
	--ritual summon/to hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,81306186)
	e2:SetLabelObject(e1)
	e2:SetCost(c81306186.cost)
	e2:SetTarget(c81306186.target)
	c:RegisterEffect(e2)
end
function c81306186.filter(c)
	return bit.band(c:GetType(),0x81)==0x81 and c:IsAbleToRemove()
end
function c81306186.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c81306186.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_DECK)
end
function c81306186.rmop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local tc=Duel.SelectMatchingCard(tp,c81306186.filter,tp,LOCATION_DECK,0,1,1,nil):GetFirst()
	if tc and Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)~=0 then
		tc:RegisterFlagEffect(81306186,RESET_EVENT+RESETS_STANDARD,0,0)
		e:SetLabelObject(tc)
	end
end
function c81306186.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c81306186.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetLabelObject():GetLabelObject()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then
		if not tc or tc:IsFacedown() or tc:GetFlagEffect(81306186)==0 then return false end
		local b1=tc:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,false,true)
			and Duel.IsExistingMatchingCard(c81306186.relfilter,tp,LOCATION_MZONE+LOCATION_HAND+LOCATION_GRAVE,0,1,tc,e,tp,tc,ft)
		local b2=tc:IsAbleToHand()
		return b1 or b2
	end
	local b1=tc:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,false,true)
		and Duel.IsExistingMatchingCard(c81306186.relfilter,tp,LOCATION_MZONE+LOCATION_HAND+LOCATION_GRAVE,0,1,tc,e,tp,tc,ft)
	local b2=tc:IsAbleToHand()
	local sel=0
	if b1 and b2 then
		sel=Duel.SelectOption(tp,aux.Stringid(81306186,0),aux.Stringid(81306186,1))
	elseif b1 then
		sel=Duel.SelectOption(tp,aux.Stringid(81306186,0))
	else
		sel=Duel.SelectOption(tp,aux.Stringid(81306186,1))+1
	end
	if sel==0 then
		e:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e:SetOperation(c81306186.spop)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,tc,1,0,0)
		Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,0,tp,LOCATION_GRAVE)
	else
		e:SetCategory(CATEGORY_TOHAND)
		e:SetOperation(c81306186.thop)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,tc,1,0,0)
	end
end
function c81306186.relfilter(c,e,tp,tc,ft)
	if not c:IsLevelAbove(tc:GetLevel()) then return false end
	if tc.mat_filter and not tc.mat_filter(c,tp) then return false end
	if c:IsLocation(LOCATION_GRAVE) then
		return c:IsType(TYPE_RITUAL) and ft>0 and c:IsAbleToDeck()
	else
		return (ft>0 or c:IsControler(tp)) and c:IsReleasableByEffect(e)
	end
end
function c81306186.spop(e,tp,eg,ep,ev,re,r,rp)
	local rc=e:GetLabelObject():GetLabelObject()
	if not rc or rc:IsFacedown() or rc:GetFlagEffect(81306186)==0 then return end
	if not rc:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,false,true) then return end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local tc=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c81306186.relfilter),tp,LOCATION_MZONE+LOCATION_HAND+LOCATION_GRAVE,0,1,1,rc,e,tp,rc,ft):GetFirst()
	if tc then
		rc:SetMaterial(Group.FromCards(tc))
		if tc:IsLocation(LOCATION_GRAVE) then
			Duel.HintSelection(Group.FromCards(tc))
			if Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT+REASON_MATERIAL+REASON_RITUAL)==0 then return end
		else
			if Duel.Release(tc,REASON_EFFECT+REASON_MATERIAL+REASON_RITUAL)==0 then return end
		end
		Duel.SpecialSummon(rc,SUMMON_TYPE_RITUAL,tp,tp,false,true,POS_FACEUP)
		rc:CompleteProcedure()
	end
end
function c81306186.thop(e,tp,eg,ep,ev,re,r,rp)
	local rc=e:GetLabelObject():GetLabelObject()
	if not rc or rc:IsFacedown() or rc:GetFlagEffect(81306186)==0 then return end
	Duel.SendtoHand(rc,nil,REASON_EFFECT)
end
