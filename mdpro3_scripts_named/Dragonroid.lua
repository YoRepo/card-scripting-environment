--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 龙机人  (ID: 9069157)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Machine
-- Level 8
-- ATK 2900 | DEF 1000
-- Setcode: 22
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：可以把这张卡从手卡丢弃，从以下效果选择1个发动。
-- ●从卡组把1只风属性以外的「机人」怪兽加入手卡。
-- ●这个回合，包含把融合怪兽融合召唤效果的效果由自己发动的场合，那个发动不会被无效化，在那次融合召唤成功时对方不能把魔法·陷阱·怪兽的效果发动。
-- ②：1回合1次，这张卡在墓地存在的场合才能发动。墓地的这张卡直到回合结束时变成龙族。
--[[ __CARD_HEADER_END__ ]]

--ドラゴンロイド
function c9069157.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,9069157)
	e1:SetCost(c9069157.cost)
	e1:SetTarget(c9069157.target)
	e1:SetOperation(c9069157.operation)
	c:RegisterEffect(e1)
	--race change
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1)
	e2:SetTarget(c9069157.rctg)
	e2:SetOperation(c9069157.rcop)
	c:RegisterEffect(e2)
end
function c9069157.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c9069157.thfilter(c)
	return c:IsNonAttribute(ATTRIBUTE_WIND) and c:IsSetCard(0x16) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c9069157.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local b1=Duel.IsExistingMatchingCard(c9069157.thfilter,tp,LOCATION_DECK,0,1,nil)
	local b2=Duel.GetFlagEffect(tp,9069157)==0
	if chk==0 then return b1 or b2 end
	local op=0
	if b1 and b2 then
		op=Duel.SelectOption(tp,aux.Stringid(9069157,0),aux.Stringid(9069157,1))
	elseif b1 then
		op=Duel.SelectOption(tp,aux.Stringid(9069157,0))
	else
		op=Duel.SelectOption(tp,aux.Stringid(9069157,1))+1
	end
	e:SetLabel(op)
	if op==0 then
		e:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	else
		e:SetCategory(0)
	end
end
function c9069157.operation(e,tp,eg,ep,ev,re,r,rp)
	local op=e:GetLabel()
	if op==0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c9069157.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
	if op==1 and Duel.GetFlagEffect(tp,9069157)==0 then
		local c=e:GetHandler()
		--inactivatable
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_INACTIVATE)
		e1:SetValue(c9069157.efilter)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
		--act limit
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_SPSUMMON_SUCCESS)
		e2:SetCondition(c9069157.limcon)
		e2:SetOperation(c9069157.limop)
		e2:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e2,tp)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetCode(EVENT_CHAIN_END)
		e3:SetOperation(c9069157.limop2)
		e3:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e3,tp)
		Duel.RegisterFlagEffect(tp,9069157,RESET_PHASE+PHASE_END,0,1)
	end
end
function c9069157.efilter(e,ct)
	local p=e:GetHandlerPlayer()
	local te,tp=Duel.GetChainInfo(ct,CHAININFO_TRIGGERING_EFFECT,CHAININFO_TRIGGERING_PLAYER)
	return p==tp and te:IsHasCategory(CATEGORY_FUSION_SUMMON)
end
function c9069157.limfilter(c,tp)
	return c:IsSummonPlayer(tp) and c:IsSummonType(SUMMON_TYPE_FUSION)
		and c:GetSpecialSummonInfo(SUMMON_INFO_REASON_EFFECT):IsHasCategory(CATEGORY_FUSION_SUMMON)
end
function c9069157.limcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c9069157.limfilter,1,nil,tp)
end
function c9069157.limop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetCurrentChain()==0 then
		Duel.SetChainLimitTillChainEnd(c9069157.chainlm)
	elseif Duel.GetCurrentChain()==1 then
		Duel.RegisterFlagEffect(tp,9069158,0,0,1)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_CHAINING)
		e1:SetOperation(c9069157.resetop)
		Duel.RegisterEffect(e1,tp)
		local e2=e1:Clone()
		e2:SetCode(EVENT_BREAK_EFFECT)
		e2:SetReset(RESET_CHAIN)
		Duel.RegisterEffect(e2,tp)
	end
end
function c9069157.resetop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ResetFlagEffect(tp,9069158)
	e:Reset()
end
function c9069157.limop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,9069158)~=0 then
		Duel.SetChainLimitTillChainEnd(c9069157.chainlm)
	end
end
function c9069157.chainlm(e,rp,tp)
	return tp==rp
end
function c9069157.rctg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsRace(RACE_DRAGON) end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,e:GetHandler(),1,0,0)
end
function c9069157.rcop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_RACE)
		e1:SetValue(RACE_DRAGON)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
