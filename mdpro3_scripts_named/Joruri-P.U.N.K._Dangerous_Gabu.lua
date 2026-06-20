--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 净琉璃朋克危险口裂  (ID: 43685562)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 369
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：以对方场上1只效果怪兽为对象才能发动。那只怪兽的效果直到回合结束时无效。自己场上有「朋克」怪兽存在的场合，再让自己基本分回复作为对象的怪兽的原本攻击力的数值。
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
