--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 光子卫星  (ID: 63223260)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Machine
-- Level 1
-- ATK 0 | DEF 0
-- Setcode: 85
--
-- Effect Text:
-- 1回合1次，选择这张卡以外的自己场上1只名字带有「光子」的怪兽才能发动。选择的怪兽和这张卡变成各自等级合计的等级。
--[[ __CARD_HEADER_END__ ]]

--フォトン・サテライト
function c63223260.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(63223260,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetTarget(c63223260.target)
	e1:SetOperation(c63223260.operation)
	c:RegisterEffect(e1)
end
function c63223260.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x55) and c:IsLevelAbove(1)
end
function c63223260.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c63223260.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c63223260.filter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c63223260.filter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
end
function c63223260.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsFaceup() and c:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local lv=c:GetLevel()+tc:GetLevel()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(lv)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		tc:RegisterEffect(e2)
	end
end
