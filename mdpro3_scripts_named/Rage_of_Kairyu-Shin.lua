--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Rage of Kairyu-Shin  (ID: 82685480)
-- Type: Spell / Quick-Play
-- Setcode: 0x177
-- Scope: OCG / TCG
--
-- Effect Text:
-- If "Umi" is on the field: Target monsters your opponent controls, up to the number of WATER monsters
-- you control whose original Levels are 5 or higher; destroy them, and if you do, the zones they were
-- in cannot be used until the end of the next turn.
-- You can only activate 1 "Rage of Kairyu-Shin" per turn.
--[[ __CARD_HEADER_END__ ]]

--海竜神の怒り
function c82685480.initial_effect(c)
	aux.AddCodeList(c,22702055)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,82685480+EFFECT_COUNT_CODE_OATH)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCondition(c82685480.condition)
	e1:SetTarget(c82685480.target)
	e1:SetOperation(c82685480.activate)
	c:RegisterEffect(e1)
end
function c82685480.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsEnvironment(22702055)
end
function c82685480.filter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER) and c:GetOriginalLevel()>=5
end
function c82685480.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) end
	local ct=Duel.GetMatchingGroupCount(c82685480.filter,tp,LOCATION_MZONE,0,nil)
	if chk==0 then return ct>0 and Duel.IsExistingTarget(nil,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,nil,tp,0,LOCATION_MZONE,1,ct,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c82685480.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()==0 then return end
	if Duel.Destroy(g,REASON_EFFECT)==0 then return end
	local val=0
	local og=Duel.GetOperatedGroup()
	local tc=og:GetFirst()
	while tc do
		val=val|aux.SequenceToGlobal(tc:GetPreviousControler(),LOCATION_MZONE,tc:GetPreviousSequence())
		tc=og:GetNext()
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE_FIELD)
	e1:SetValue(val)
	e1:SetReset(RESET_PHASE+PHASE_END,2)
	Duel.RegisterEffect(e1,tp)
end
