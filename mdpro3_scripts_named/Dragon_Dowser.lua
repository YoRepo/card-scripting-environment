--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 小龙探物摆  (ID: 76066541)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Wyrm
-- Level 4
-- ATK 1500 | DEF 1500
--
-- Effect Text:
-- 「小龙探物摆」的效果1回合只能使用1次。
-- ①：场上的这张卡被战斗或者对方的效果破坏送去墓地时才能发动。从卡组把1只地属性灵摆怪兽守备表示特殊召唤。这个效果特殊召唤的怪兽在结束阶段破坏。
--[[ __CARD_HEADER_END__ ]]

--ドラゴンダウザー
function c76066541.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(76066541,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCountLimit(1,76066541)
	e1:SetCondition(c76066541.condition)
	e1:SetTarget(c76066541.target)
	e1:SetOperation(c76066541.operation)
	c:RegisterEffect(e1)
end
function c76066541.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return (c:IsReason(REASON_BATTLE)
		or rp==1-tp and c:IsReason(REASON_DESTROY) and c:IsPreviousControler(tp))
		and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c76066541.filter(c,e,tp)
	return c:IsType(TYPE_PENDULUM) and c:IsAttribute(ATTRIBUTE_EARTH)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c76066541.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c76066541.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c76066541.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c76066541.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_DEFENSE)~=0 then
		local fid=e:GetHandler():GetFieldID()
		tc:RegisterFlagEffect(76066541,RESET_EVENT+RESETS_STANDARD,0,1,fid)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetLabel(fid)
		e1:SetLabelObject(tc)
		e1:SetCondition(c76066541.descon)
		e1:SetOperation(c76066541.desop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c76066541.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:GetFlagEffectLabel(76066541)~=e:GetLabel() then
		e:Reset()
		return false
	else return true end
end
function c76066541.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetLabelObject(),REASON_EFFECT)
end
