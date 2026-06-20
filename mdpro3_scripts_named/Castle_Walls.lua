--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 城壁  (ID: 44209392)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 选择场上表侧表示存在的1只怪兽发动。选择的怪兽的守备力直到结束阶段时上升500。
--[[ __CARD_HEADER_END__ ]]

--城壁
function c44209392.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(aux.dscon)
	e1:SetTarget(c44209392.target)
	e1:SetOperation(c44209392.activate)
	c:RegisterEffect(e1)
end
function c44209392.filter(c)
	return c:IsFaceup() and c:IsDefenseAbove(0)
end
function c44209392.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c44209392.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44209392.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c44209392.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c44209392.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_DEFENSE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(500)
		tc:RegisterEffect(e1)
	end
end
