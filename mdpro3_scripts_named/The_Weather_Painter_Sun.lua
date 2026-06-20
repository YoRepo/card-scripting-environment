--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 晴天气 锈红  (ID: 54895237)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Fairy
-- Level 3
-- ATK 1600 | DEF 400
-- Setcode: 265
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡在墓地存在的场合，把自己场上1张表侧表示的永续魔法·永续陷阱卡送去墓地才能发动。这张卡守备表示特殊召唤，从手卡选1张「天气」魔法·陷阱卡在自己的魔法与陷阱区域表侧表示放置。
-- ②：场上的这张卡为让「天气」卡的效果发动而被除外的场合，下个回合的准备阶段才能发动。除外的这张卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--晴天気ベンガーラ
function c54895237.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(54895237,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,54895237)
	e1:SetCost(c54895237.gspcost)
	e1:SetTarget(c54895237.gsptg)
	e1:SetOperation(c54895237.gspop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_REMOVE)
	e2:SetOperation(c54895237.spreg)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(54895237,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetRange(LOCATION_REMOVED)
	e3:SetCondition(c54895237.spcon)
	e3:SetTarget(c54895237.sptg)
	e3:SetOperation(c54895237.spop)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
end
function c54895237.costfilter(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_CONTINUOUS) and c:IsAbleToGraveAsCost()
		and Duel.GetMZoneCount(tp,c)>0 and Duel.GetSZoneCount(tp,c)>0
		and Duel.IsExistingMatchingCard(c54895237.setfilter,tp,LOCATION_HAND,0,1,nil,c,tp)
end
function c54895237.setfilter(c,cc,tp)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and not c:IsType(TYPE_FIELD) and c:IsSetCard(0x109)
		and not c:IsForbidden() and c:CheckUniqueOnField(tp,LOCATION_ONFIELD,cc)
end
function c54895237.gspcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c54895237.costfilter,tp,LOCATION_ONFIELD,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c54895237.costfilter,tp,LOCATION_ONFIELD,0,1,1,nil,tp)
	Duel.SendtoGrave(g,REASON_COST)
end
function c54895237.gsptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return e:IsCostChecked()
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c54895237.gspop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsRelateToEffect(e)
		and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_DEFENSE)>0
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
		local tc=Duel.SelectMatchingCard(tp,c54895237.setfilter,tp,LOCATION_HAND,0,1,1,nil,nil,tp):GetFirst()
		if tc then
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		end
	end
end
function c54895237.spreg(e,tp,eg,ep,ev,re,r,rp)
	if not re then return end
	local c=e:GetHandler()
	local rc=re:GetHandler()
	if c:IsReason(REASON_COST) and rc:IsSetCard(0x109) and c:IsPreviousLocation(LOCATION_ONFIELD) and re:IsActivated() then
		e:SetLabel(Duel.GetTurnCount()+1)
		c:RegisterFlagEffect(54895237,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,2)
	end
end
function c54895237.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabelObject():GetLabel()==Duel.GetTurnCount() and e:GetHandler():GetFlagEffect(54895237)>0
end
function c54895237.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	e:GetHandler():ResetFlagEffect(54895237)
end
function c54895237.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
