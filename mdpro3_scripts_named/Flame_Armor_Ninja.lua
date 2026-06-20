--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 机甲忍者 火  (ID: 33034646)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Warrior
-- Level 4
-- ATK 1700 | DEF 1000
-- Setcode: 43
--
-- Effect Text:
-- 这张卡召唤·反转召唤·特殊召唤成功时，选择自己场上1只名字带有「忍者」的怪兽才能发动。选择的怪兽的等级上升1星。
--[[ __CARD_HEADER_END__ ]]

--機甲忍者フレイム
function c33034646.initial_effect(c)
	--lv up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33034646,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c33034646.target)
	e1:SetOperation(c33034646.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c33034646.filter(c)
	return c:IsFaceup() and c:IsLevelAbove(1) and c:IsSetCard(0x2b)
end
function c33034646.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c33034646.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c33034646.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c33034646.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c33034646.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(1)
		tc:RegisterEffect(e1)
	end
end
