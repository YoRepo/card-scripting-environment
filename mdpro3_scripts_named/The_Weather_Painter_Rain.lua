--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 雨天气 湛蓝  (ID: 92411493)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fairy
-- Level 3
-- ATK 1200 | DEF 1400
-- Setcode: 265
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡特殊召唤成功的场合才能发动。从手卡选1张「天气」魔法·陷阱卡在自己的魔法与陷阱区域表侧表示放置。
-- ②：场上的这张卡为让「天气」卡的效果发动而被除外的场合，下个回合的准备阶段才能发动。除外的这张卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--雨天気ラズラ
function c92411493.initial_effect(c)
	--place
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(92411493,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,92411493)
	e1:SetTarget(c92411493.tftg)
	e1:SetOperation(c92411493.tfop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_REMOVE)
	e2:SetOperation(c92411493.spreg)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(92411493,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetRange(LOCATION_REMOVED)
	e3:SetCondition(c92411493.spcon)
	e3:SetTarget(c92411493.sptg)
	e3:SetOperation(c92411493.spop)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
end
function c92411493.tffilter(c,tp)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and not c:IsType(TYPE_FIELD) and c:IsSetCard(0x109)
		and not c:IsForbidden() and c:CheckUniqueOnField(tp)
end
function c92411493.tftg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c92411493.tffilter,tp,LOCATION_HAND,0,1,nil,tp) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function c92411493.tfop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local tc=Duel.SelectMatchingCard(tp,c92411493.tffilter,tp,LOCATION_HAND,0,1,1,nil,tp):GetFirst()
	if tc then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end
function c92411493.spreg(e,tp,eg,ep,ev,re,r,rp)
	if not re then return end
	local c=e:GetHandler()
	local rc=re:GetHandler()
	if c:IsReason(REASON_COST) and rc:IsSetCard(0x109) and c:IsPreviousLocation(LOCATION_ONFIELD) and re:IsActivated() then
		e:SetLabel(Duel.GetTurnCount()+1)
		c:RegisterFlagEffect(92411493,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,2)
	end
end
function c92411493.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabelObject():GetLabel()==Duel.GetTurnCount() and e:GetHandler():GetFlagEffect(92411493)>0
end
function c92411493.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	e:GetHandler():ResetFlagEffect(92411493)
end
function c92411493.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
