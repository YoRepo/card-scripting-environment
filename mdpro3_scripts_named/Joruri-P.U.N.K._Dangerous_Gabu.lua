--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Joruri-P.U.N.K. Dangerous Gabu  (ID: 43685562)
-- Type: Trap
-- Setcode: 0x171
-- Scope: OCG / TCG
--
-- Effect Text:
-- Target 1 Effect Monster your opponent controls; negate its effects (until the end of this turn),
-- then, if you control a "P.U.N.K." monster, gain LP equal to that targeted monster's original ATK.
-- You can only activate 1 "Joruri-P.U.N.K. Dangerous Gabu" per turn.
--[[ __CARD_HEADER_END__ ]]

--Jo－P.U.N.K.デンジャラス・ガブ
function c43685562.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE+CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetCountLimit(1,43685562+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c43685562.target)
	e1:SetOperation(c43685562.activate)
	c:RegisterEffect(e1)
end
function c43685562.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and aux.NegateEffectMonsterFilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(aux.NegateEffectMonsterFilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,aux.NegateEffectMonsterFilter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,0)
end
function c43685562.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x171)
end
function c43685562.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and tc:IsCanBeDisabledByEffect(e) then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		Duel.AdjustInstantly(tc)
		if Duel.IsExistingMatchingCard(c43685562.cfilter,tp,LOCATION_MZONE,0,1,nil) then
			Duel.Recover(tp,tc:GetBaseAttack(),REASON_EFFECT)
		end
	end
end
