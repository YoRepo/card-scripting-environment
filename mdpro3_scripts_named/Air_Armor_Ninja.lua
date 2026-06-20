--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 机甲忍者 风  (ID: 69023354)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Warrior
-- Level 4
-- ATK 1400 | DEF 1400
-- Setcode: 43
--
-- Effect Text:
-- 这张卡召唤·反转召唤·特殊召唤成功时，选择自己场上1只名字带有「忍者」的怪兽才能发动。选择的怪兽的等级下降1星。
--[[ __CARD_HEADER_END__ ]]

--機甲忍者エアー
function c69023354.initial_effect(c)
	--lv down
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(69023354,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c69023354.target)
	e1:SetOperation(c69023354.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c69023354.filter(c)
	return c:IsFaceup() and c:GetLevel()~=0 and c:IsSetCard(0x2b)
end
function c69023354.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c69023354.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c69023354.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c69023354.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c69023354.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(-1)
		tc:RegisterEffect(e1)
	end
end
