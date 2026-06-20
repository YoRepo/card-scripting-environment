--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 进化的奇迹  (ID: 34026662)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 选择名字带有「进化虫」的怪兽的效果特殊召唤的1只怪兽发动。这个回合，选择的怪兽不会被战斗以及卡的效果破坏。
--[[ __CARD_HEADER_END__ ]]

--進化の奇跡
function c34026662.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c34026662.target)
	e1:SetOperation(c34026662.activate)
	c:RegisterEffect(e1)
end
function c34026662.filter(c)
	local typ=c:GetSpecialSummonInfo(SUMMON_INFO_TYPE)
	return c:IsFaceup() and c:IsSummonType(SUMMON_VALUE_EVOLTILE) or (typ&TYPE_MONSTER~=0 and c:IsSpecialSummonSetCard(0x304e))
end
function c34026662.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c34026662.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c34026662.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c34026662.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c34026662.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(1)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		tc:RegisterEffect(e2)
	end
end
